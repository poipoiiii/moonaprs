# moonaprs

MoonBit 实现的 APRS / AX.25 业余无线电数据栈：从比特级的 AX.25 UI 帧、KISS 串口封装，
到 TNC2 报文、APRS-IS 登录与过滤表达式，再到报文语义解析、航迹存储、Douglas-Peucker
简化与 Web Mercator SVG 地图渲染。

APRS（Automatic Packet Reporting System）是全球业余无线电爱好者使用的实时位置与遥测
报文中继系统：车载台、手持台、气象站和网关通过 1200 bps 的 AX.25 分组无线电网和
APRS-IS 互联网骨干交换位置、天气、遥测、短消息与对象信息。

## 为什么是 MoonBit

- 协议栈天然适合纯函数式、零平台依赖的核心库：同一份代码编译到 native / Wasm / JS。
- 现有 MoonBit 生态中没有 APRS 或 AX.25 实现（`moon search aprs`、`moon search ax25`
  均无结果），本项目填补这一空白。
- 位级编码（地址字段左移、CRC-16/X.25、HDLC 位填充、KISS 转义）非常适合作为 MoonBit
  系统编程能力的展示。

## 功能

- **AX.25**
  - 呼号/SSID 解析与规范化
  - 地址字段编解码（6 字符左移 + SSID/扩展位/命令位）
  - UI 帧（control `0x03`、PID `0xF0`）编解码
  - CRC-16/X.25（校验值 `"123456789"` → `0x906E`）
  - HDLC 位填充/去填充
  - KISS 封装、转义与增量流解码器
  - TNC2 monitor 格式（`SRC>DST,PATH:info`）互转
- **APRS-IS**
  - passcode 算法（含 `N0CALL → 13023` 等回归向量）
  - 登录行生成、只读模式
  - 过滤表达式构造（范围、矩形、前缀、好友、类型）
  - 会话状态机：keepalive、`#` 注释、登录确认、包/错误计数
  - 重复包窗口（忽略路径，按源/目标/信息字段去重）
  - 传输无关客户端引擎：登录握手、keepalive 看门狗、指数退避重连；附原生 TCP
    传输与 `is-live` 命令（默认 `rotate.aprs2.net:14580`，`--out` 落盘导出 GPX/GeoJSON）
- **报文解析**
  - 无时间戳/带时间戳的非压缩位置（含位置歧义）
  - 压缩位置（base-91）
  - Mic-E 压缩位置（纬度编码在 AX.25 目的地址，含速度/航向与状态文本）
  - 气象报文与位置附带气象（`_` 符号、`DDD/SSS` 前缀）
  - 遥测（`T#`）
  - 消息与 ACK、状态、对象、条目、查询、第三方报文
  - 公告与 NWS 消息分类（`BLN0`-`BLN9`、5 字符主题）
  - 时间戳解析（`DDHHMMz` / `DDHHMM/` / `HHMMSSh` / `MMDDHHMM`）并按参考时刻
    锚定到完整 UTC 日期时间（支持跨午夜、跨月、跨年）
  - 主/备符号表查询与 overlay 字符
  - 位置报文构造与 `=` / `@` 编码往返
- **航迹**
  - 按呼号/对象/条目聚合
  - 重复信标去重
  - 大圆距离、初始方位、罗盘方位、Maidenhead 网格
  - 分段速度、航向与平均速度
  - 打点锚定 epoch：跨午夜/跨月速度精确计算，GPX/GeoJSON 输出 ISO 8601 时间
  - Douglas-Peucker 航迹简化
  - GPX 1.1 与 GeoJSON 导出
- **地图**
  - 经纬度 → Web Mercator 投影
  - SVG 航迹折线、起终点标记、呼号标注、经纬网
  - 常见 APRS 符号名称
- **CLI**：`decode` / `decode-file` / `encode` / `passcode` / `login` / `kiss` /
  `track` / `svg` / `gpx` / `geojson` / `is-feed` / `is-live` / `symbols`
- **浏览器演示**：粘贴 TNC2 报文，实时显示解码结果与地图，可下载 GPX / GeoJSON

## 快速开始

```powershell
moon check
moon test --target wasm

# 解码一条报文
moon run cmd/main --target wasm -- decode "N0CALL-9>APRS,WIDE2-1:!4903.50N/07201.75W-Test"

# APRS-IS 登录信息
moon run cmd/main --target wasm -- passcode N0CALL
moon run cmd/main --target wasm -- login N0CALL -1 "r/49.0/-72.0/100"

# 编码 AX.25 UI 帧（打印 AX.25 与 KISS 十六进制）
moon run cmd/main --target wasm -- encode N0CALL-9 APRS "WIDE2-1" "!4903.50N/07201.75W-Test"

# 航迹统计与地图
moon run cmd/main --target wasm -- track examples/aprs_sample.txt
moon run cmd/main --target wasm -- svg examples/aprs_sample.txt map.svg 960 600
moon run cmd/main --target wasm -- gpx examples/aprs_sample.txt map.gpx
moon run cmd/main --target wasm -- geojson examples/aprs_sample.txt map.geojson

# APRS-IS 会话逻辑演练（登录串、去重、计数）
moon run cmd/main --target wasm -- is-feed examples/aprs_sample.txt N0CALL-9

# 实时接收 APRS-IS 数据流（需原生目标，需 MSVC/系统 C 工具链）
moon run cmd/main --target native -- is-live N0CALL "r/49.0/-72.0/100"
moon run cmd/main --target native -- is-live rotate.aprs2.net 14580 N0CALL

# 边接收边落盘：收满 200 个位置点后停止并导出 GPX + GeoJSON
moon run cmd/main --target native -- is-live N0CALL --out live_track --count 200

# 符号查询
moon run cmd/main --target wasm -- symbols ">"
```

示例地图见 [examples/aprs_sample.svg](examples/aprs_sample.svg)，导出数据见
[examples/aprs_sample.gpx](examples/aprs_sample.gpx) 与
[examples/aprs_sample.geojson](examples/aprs_sample.geojson)。

### 浏览器演示

```powershell
powershell -File web/build.ps1
python -m http.server 8000 --directory .
# 打开 http://localhost:8000/web/index.html
```

## 库结构

```
lib/ax25   AX.25 帧、地址、CRC、HDLC、KISS
lib/aprs   TNC2、passcode、过滤器、位置/气象/遥测/消息/对象解析
lib/track  航迹存储、距离方位、Douglas-Peucker 简化
lib/svg    Web Mercator 投影、符号表、SVG 渲染
cmd/main   命令行工具
web        MoonBit→JS 浏览器演示
```

## 测试

```powershell
moon test --target wasm
```

测试覆盖 CRC 标准校验值、地址字段已知字节、帧/KISS 往返、TNC2 解析、压缩与
非压缩位置、Mic-E 位置、位置歧义、气象、遥测、消息与 ACK、对象/条目、APRS-IS
passcode 向量、过滤器、大圆距离、Douglas-Peucker、时间戳、符号表、公告分类、
速度/航向、GPX/GeoJSON 导出与 SVG 输出，共 111 个测试。

## 已知限制

- APRS-IS 实时客户端（`is-live`）依赖原始 TCP 套接字，仅原生（native）目标可用，
  构建需系统 C 工具链（Windows 需 MSVC Build Tools）；核心引擎与 `IsTransport`
  抽象本身与后端无关，可在 Wasm/JS 上复用，但这两个后端没有原始套接字。
- `is-live` 的 `--out` 落盘导出在收满 `--count` 个点后、或每积累 25 个点时触发；
  直接 Ctrl-C 且未满 25 个新点时，未落盘的少量新点会丢失（离线处理可用 `is-feed`）。

## 许可证

MIT
