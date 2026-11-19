# Changelog

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
