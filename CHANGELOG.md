# Changelog

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
