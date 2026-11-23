# Changelog

## 0.7.0

### Added

- SVG 站点标记按 APRS 符号类别成形：车辆/飞行器正三角、船艇倒三角、气象方块、
  基础设施菱形、应急十字（`<path>`），其余圆形。此前仅 `>` / 气象 / `#` 三个
  特判，其他一律圆形。
- 标记生成重构为纯函数 `marker_svg`（`lib/svg/render.mbt`），可对输出逐字断言。
- 5 个新测试：船艇倒三角、大型飞行器三角、医院十字、房屋菱形、未映射码回退圆形。

### Changed

- 测试总数 111 → 116。

## 0.6.0

### Added

- `is-live --out base [--count n]`：实时位置包直接 `ingest` 进 `TrackStore`
  （`now_reference()` 锚定 epoch），收满 `--count` 个位置点后通过 `on_event` 返回
  `false` 干净断开并导出 `base.gpx` + `base.geojson`；未设 `--count` 时每积累 25 个
  点增量重写导出，Ctrl-C 也能保留最近数据。`--count` 单独使用可作限量抓取。
- flag 与位置参数分离解析（`--out` / `--count` 可出现在任意位置），原有
  `[host] [port] <callsign> [filter]` 语法不变。

### Changed

- 测试总数保持 111（本轮为 CLI 原生端胶水逻辑，无新增库测试）。

## 0.5.0

### Added

- `lib/aprs/is_client.mbt`：传输无关的 APRS-IS 客户端引擎。定义 `pub(open) trait
  IsTransport { read_line / write_line / close }`，`IsClient` 负责发送登录行、分类
  服务器行（`ClientLine`：`Comment` / `Packet` / `Malformed` / `Ignored` /
  `LoggedIn` / `Eof`）、确认登录、`DedupeWindow` 去重与计数；`run` 循环在 EOF/读
  失败时以指数退避重连（1s 起翻倍，封顶 30s），同一引擎可接 TCP / stdio / 测试双工。
- `lib/aprs/is_client_wbtest.mbt`：4 个白盒测试（脚本化内存传输）——登录 + verified
  确认、重复包抑制、EOF 后重连、连接失败退避后成功。
- 原生 TCP 传输：`cmd/main/tcp_native.c`（跨平台阻塞套接字，borrowed-buffer 行读取，
  90s `SO_RCVTIMEO` keepalive 看门狗，静态 64KB 重组缓冲）+ `cmd/main/tcp_native.mbt`
  （C FFI，`TcpTransport` 实现 `IsTransport`）；`cmd/main/tcp_other.mbt` 为
  Wasm / JS 提供编译存根（无原始套接字）。
- CLI 新增 `is-live [host] [port] <callsign> [filter]`：连接 APRS-IS（默认
  `rotate.aprs2.net:14580`），流式打印事件（注释 / 报文 / 重复 / 重连），Ctrl-C
  退出。仅原生目标可用（需 C 工具链构建）。

### Changed

- 测试总数 107 → 111。

## 0.4.0

### Added

- `DateTime` 模块（`lib/aprs/datetime.mbt`）：proleptic 公历与 Unix epoch 双向换算
  （Hinnant 算法，负数 epoch 经 `floor_div` 修正），提供 `from_ymd_hms`、
  `from_unix_ms` / `from_unix_seconds`、`to_unix_seconds`、`add_minutes`、
  `to_iso8601`、`days_in_month`。
- `resolve_aprs_time(ts, reference, tz)`：将缺少年份的 APRS 时间戳锚定为“不晚于
  参考时刻的最近匹配点”，`DayZulu`/`HourMinuteSecond` 按 UTC、`DayLocal`/
  `MonthDayHourMinute` 应用本地时区偏移；mdhm 最多回溯 10 年、day 最多回溯 24 个月，
  正确处理跨午夜、跨月与跨年。
- `TrackPoint` 携带 `epoch`，`TrackStore` 可用 `with_reference(reference, tz)` 锚定；
  入库时自动解析并锚定时间戳。
- 速度计算：两点都有 epoch 时用精确秒差（跨月/跨年正确），否则回退到分钟差午夜回绕。
- GPX 导出：已锚定的点输出 `<time>`（ISO 8601）；GeoJSON 导出在 properties 中输出
  平行的 `times` 数组。
- CLI 与浏览器演示均接入当前时间作为锚定参考（`@env.now()` / `Date.now()`）；CLI
  `track` 摘要显示最后一点的 ISO 时间。
- 12 个新单元测试（DateTime 往返/epoch/时区/非法日期、锚定解析、跨月速度、导出带时间）。

### Changed

- 版本号升至 0.4.0（登录串与 CLI 版本同步）。
- 107 个单元测试。

## 0.3.0

### Added

- Mic-E 位置解码：纬度取自 AX.25 目的地址的 6 个字符，经度/速度/航向取自信息字段，
  支持当前/旧定位标志、800/600 节速度段与 400° 航向段、符号码与状态文本。
- `parse_info_with_dest`：同时接收信息字段与目的地址；`AprsPacket::parse` 自动传入
  目的地址，Mic-E 报文可直接解码。
- `MicE` 类型与 `AprsBody::MicE` 变体，CLI `decode` 与浏览器演示均可显示 Mic-E。
- 航迹存储接受 Mic-E 位置，可参与地图渲染与 GPX / GeoJSON 导出。
- `Callsign::base_call`：取不含 SSID 的呼号。
- 5 个 Mic-E 单元测试（规范示例、南纬/东经与速度偏移、截断输入、缺少目的地址）。

### Changed

- 版本号升至 0.3.0（登录串与 CLI 版本同步）。
- 95 个单元测试。

## 0.2.0

### Added

- APRS 时间戳解析：`DDHHMMz`、`DDHHMM/`、`HHMMSSh`、`MMDDHHMM`，含范围校验与
  跨午夜分钟差。
- 完整的主/备 APRS 符号表查询（名称与类别），支持 overlay 字符。
- 位置报文构造器：`Position::new`、`with_timestamp`、`to_aprs`，可生成 `=` / `@`
  信息字段并往返解析。
- APRS-IS 重复包窗口（忽略路径，按源/目标/信息字段去重）。
- APRS-IS 会话状态机：登录行、keepalive、`#` 注释解析、登录确认、包与错误计数。
- 公告消息分类：`BLN0`-`BLN9` 公告、NWS 消息，解析 5 字符主题与正文。
- 航迹速度与航向：基于时间戳计算分段速度/航向与平均速度。
- GPX 1.1 与 GeoJSON 导出（单航迹与多航迹）。
- 航迹点携带 APRS 符号码；SVG 按符号渲染三角/方形/菱形标记，并加入公里比例尺。
- 气象单位换算：摄氏温度、km/h 风速、毫米降水、hPa 气压。
- CLI 新增 `gpx`、`geojson`、`is-feed`、`symbols`，`track` 输出平均速度。
- 浏览器演示新增 GPX / GeoJSON 下载与总里程统计。
- 健壮性回归：合法报文的所有前缀、垃圾输入、控制字节与超长负载。

### Changed

- 版本号升至 0.2.0（登录串与 CLI 版本同步）。
- 90 个单元测试。

## 0.1.0

### Added

- AX.25 UI 帧编解码：呼号/SSID、地址字段（左移编码、C/H 位、扩展位）、
  控制字段、PID、CRC-16/X.25 FCS。
- HDLC 位填充与去填充（返回有效位数，正确处理字节对齐填充）。
- KISS 封装/转义、一次性解码与增量流式 `KissDecoder`。
- TNC2 monitor 格式解析与渲染。
- APRS-IS passcode、登录行、只读模式与过滤器构造（范围/矩形/前缀/好友/类型）。
- APRS 报文解析：非压缩与压缩位置、位置歧义、时间戳、气象（含 `_` 符号与
  `DDD/SSS` 前缀）、遥测、消息与 ACK、状态、对象、条目、查询、第三方报文。
- 航迹存储与去重、大圆距离、初始方位、罗盘方位、Maidenhead 网格、
  Douglas-Peucker 简化。
- Web Mercator 投影与 SVG 地图渲染（折线、起终点、标注、经纬网）。
- 命令行工具：`decode`、`decode-file`、`encode`、`passcode`、`login`、
  `kiss`、`track`、`svg`。
- MoonBit → JS 浏览器演示（`web/`）。
- 42 个单元测试（AX.25、APRS、航迹、SVG）。
