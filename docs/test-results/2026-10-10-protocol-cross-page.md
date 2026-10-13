# 协议选择跨页修正与验证（2026-10-10）

用户反馈：HOME 选择协议后，其他页面几乎不变，容易误以为 UART/I²C/CAN
已接入并产生实时事件或零错误。此次只改 PS UI 和软件筛选，不改 PL
监听器、BIT、事件 ABI、STM32 固件或硬件接线。

- 四页页眉均显示 `VIEW <协议>`。未接入协议的状态为 `OFFLINE`。
- SELF TEST 保留公共板级检查，状态明确命名为 `BOARD HEALTH`，另示
  `LISTENER NOT WIRED`；SPI 抓取状态仍明确标为 `SPI CAPTURE`。
- EVENTS 的 `MATCH` 按事件 ABI 协议 ID 筛选真实快照，滚动范围按筛选
  后数量计算。SPI 虚拟快照保留 25 条自检记录，标为 `DEMO` 与 `VIRT`。
  未接入协议显示 `PL LISTENER NOT CONNECTED` / `NO LIVE EVENTS`，
  而不是显示其他协议的记录；ARM SPI 按钮禁用并提示 `SELECT SPI`。
- ERRORS 的 SPI 页保留已连接检测器。UART/I²C/CAN 页显示
  `ERROR DETECTOR NOT CONNECTED`，公共 `GLOBAL EXTERNAL LOSS`
  单独标注，不以零错误代替未测量。
- 协议 ID 映射及虚拟数据可见性在 `ui_protocol_select.h`，断言已加入
  `ui_protocol_select_test.c`。该测试的新增断言未在本次找到 Windows
  原生 C 执行器运行；SDK ARM 编译链接及实板渲染已完成。

SDK 2018.3 隔离工作区链接成功，ELF SHA-256：
`8095DA0087EB68E5A1FAD8CFCB863DDEE0E671F459D424CF45D48A9DCF01A388`。
JTAG 下载后读回 `SYS_ID=4D505254`、`VERSION=00010004`、
`CAPABILITIES=0000000F`、25 条演示快照。只在 RAM 中切换选中值与页面，
导出板上双帧缓存目视检查：UART 的 SELF TEST、EVENTS、ERRORS 均按
所选协议显示；发现缓存不可用时 EVENTS 提示不准确，已修正并复查。
SPI EVENTS 复查仍显示 DEMO 25 条且事件行为 VIRT。RAM 测试后再次
下载正式 ELF，恢复默认 SPI/25 条快照，未把测试选择留在板上。

仍需实体触摸回归：HOME 选择四个协议后进入三页，观察选择状态是否
保持；SPI 的真实 STM32 事务抓取及筛选后的滚动也需再次实测。
仅 RAM 设状态和帧缓存验屏不等于触摸命中或新真实总线采集。
