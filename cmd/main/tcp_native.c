// MoonAPRS native APRS-IS TCP transport.
//
// Blocking line-oriented socket helpers. A 90 s SO_RCVTIMEO makes a silent
// server look like EOF so the client engine reconnects (keepalive watchdog).
#include "moonbit.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifdef _WIN32
#include <winsock2.h>
#include <ws2tcpip.h>
#pragma comment(lib, "ws2_32.lib")
typedef SOCKET socket_t;
#define CLOSED_SOCKET INVALID_SOCKET
static int g_ws_started = 0;
static void ws_init(void) {
  if (!g_ws_started) {
    WSADATA d;
    WSAStartup(MAKEWORD(2, 2), &d);
    g_ws_started = 1;
  }
}
#else
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/time.h>
#include <netdb.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <time.h>
typedef int socket_t;
#define CLOSED_SOCKET (-1)
#define ws_init() ((void)0)
#endif

// Single connection at a time -> one static reassembly buffer is enough.
static char g_buf[65536];
static int g_len = 0;
static int64_t g_fd = -1;

static void reset_buf(int64_t fd) {
  g_len = 0;
  g_fd = fd;
}

MOONBIT_FFI_EXPORT int64_t moonaprs_tcp_connect(uint8_t *host, int host_len,
                                                int port) {
  ws_init();
  char host_str[256];
  if (host_len <= 0 || host_len >= (int)sizeof(host_str)) {
    return -1;
  }
  memcpy(host_str, host, host_len);
  host_str[host_len] = 0;
  char port_str[16];
  snprintf(port_str, sizeof(port_str), "%d", port);

  struct addrinfo hints, *res = NULL, *p;
  memset(&hints, 0, sizeof(hints));
  hints.ai_family = AF_UNSPEC;
  hints.ai_socktype = SOCK_STREAM;
  if (getaddrinfo(host_str, port_str, &hints, &res) != 0) {
    return -1;
  }
  socket_t s = CLOSED_SOCKET;
  for (p = res; p != NULL; p = p->ai_next) {
    s = socket(p->ai_family, p->ai_socktype, p->ai_protocol);
    if (s == CLOSED_SOCKET) {
      continue;
    }
    if (connect(s, p->ai_addr, (int)p->ai_addrlen) == 0) {
      break;
    }
#ifdef _WIN32
    closesocket(s);
#else
    close(s);
#endif
    s = CLOSED_SOCKET;
  }
  freeaddrinfo(res);
  if (s == CLOSED_SOCKET) {
    return -1;
  }
#ifdef _WIN32
  DWORD t = 90000;
  setsockopt(s, SOL_SOCKET, SO_RCVTIMEO, (const char *)&t, sizeof(t));
#else
  struct timeval t;
  t.tv_sec = 90;
  t.tv_usec = 0;
  setsockopt(s, SOL_SOCKET, SO_RCVTIMEO, &t, sizeof(t));
#endif
  reset_buf((int64_t)s);
  return (int64_t)s;
}

// Reads one line into the caller-provided `out` buffer (capacity `cap`),
// stripping the trailing CRLF. Returns the line length (>= 0), or -1 on
// EOF / read error / read timeout, or -2 if the line exceeds `cap`.
MOONBIT_FFI_EXPORT int moonaprs_tcp_read_line(int64_t handle, uint8_t *out,
                                              int cap) {
  socket_t s = (socket_t)handle;
  if (g_fd != handle) {
    reset_buf(handle);
  }
  while (1) {
    int i;
    for (i = 0; i < g_len; i++) {
      if (g_buf[i] == '\n') {
        int line_len = i;
        if (line_len > 0 && g_buf[line_len - 1] == '\r') {
          line_len--;
        }
        if (line_len > cap) {
          return -2;
        }
        memcpy(out, g_buf, line_len);
        int remain = g_len - (i + 1);
        if (remain > 0) {
          memmove(g_buf, g_buf + i + 1, remain);
        }
        g_len = remain;
        return line_len;
      }
    }
    if (g_len >= (int)sizeof(g_buf)) {
      return -2; // no newline within buffer -> drop & signal EOF
    }
    int n = recv(s, g_buf + g_len, (int)sizeof(g_buf) - g_len, 0);
    if (n <= 0) {
      return -1;
    }
    g_len += n;
  }
}

MOONBIT_FFI_EXPORT int moonaprs_tcp_write_line(int64_t handle, uint8_t *line,
                                               int len) {
  socket_t s = (socket_t)handle;
  int total = len + 2;
  uint8_t stack_buf[1024];
  uint8_t *buf;
  int need_free = 0;
  if (total <= (int)sizeof(stack_buf)) {
    buf = stack_buf;
  } else {
    buf = (uint8_t *)malloc(total);
    need_free = 1;
  }
  if (len > 0) {
    memcpy(buf, line, len);
  }
  buf[len] = '\r';
  buf[len + 1] = '\n';
  int sent = 0;
  while (sent < total) {
    int n = send(s, (const char *)(buf + sent), total - sent, 0);
    if (n <= 0) {
      if (need_free) {
        free(buf);
      }
      return -1;
    }
    sent += n;
  }
  if (need_free) {
    free(buf);
  }
  return 0;
}

MOONBIT_FFI_EXPORT void moonaprs_tcp_close(int64_t handle) {
  socket_t s = (socket_t)handle;
  if (s != CLOSED_SOCKET) {
#ifdef _WIN32
    closesocket(s);
#else
    close(s);
#endif
  }
  if (g_fd == handle) {
    g_fd = -1;
    g_len = 0;
  }
}

MOONBIT_FFI_EXPORT void moonaprs_sleep_ms(int ms) {
#ifdef _WIN32
  Sleep(ms);
#else
  struct timespec ts;
  ts.tv_sec = ms / 1000;
  ts.tv_nsec = (long)(ms % 1000) * 1000000L;
  nanosleep(&ts, NULL);
#endif
}
