# 2026-10-27：四协议分级菜单与正常发送验证

目标：天空星 STM32F407VGT6；分支 `memberC/stm32-f407`。不涉及 F103 控制/接收板。

## 变更边界

- 母菜单四协议；子菜单 6 个正常入口＋原 20 个故障＋各自 BACK。导航不发包，正常项一轮，不增加循环发送模式。
- 正常入口复用 runner；CAN TX 复用 normal 会话；RAW/LIVE 故障派发、宏和持有资源时的停止/恢复逻辑保留。
- 不改 `mc_faults.c`、冻结 case ID、协议 YAML、GPIO/时钟初始化、`.ioc`、USART1 RX 环形缓冲、JSONL 格式及 runner/logger。
- 新映射：`mc_ui_menu.h/.c`；消抖：`mc_button.h/.c`；板级接入：`mc_board_app.c`；更新 CMake、Keil 工程文件及使用文档。

## 主机测试

命令：`cmake -S stm32_f407 -B stm32_f407/build -G Ninja`、`cmake --build stm32_f407/build`、`ctest --test-dir stm32_f407/build --output-on-failure`。

结果：13/13 passed；GCC `-Wall -Wextra -Wpedantic -Werror`。

| 检查 | 覆盖与结果 |
|---|---|
| 纯菜单 | 四协议切换、循环、进入/BACK 不产生发送动作，6 个正常动作映射正确 |
| 故障兼容 | 所有 20 个原故障各出现一次、归属协议正确、串口索引反向定位不变、无效参数拒绝 |
| 真实板级应用（模拟 I/O） | 编译并调用实际 `mc_board_app.c`，分别启用默认/故障宏；6 正常入口调用对应原后端 |
| 长按 | 持续按住不重复触发；进入子菜单需松手再确认；返回不增加次数、不发送 |
| 消抖 | 按下/松开 30 ms 稳定确认、释放抖动不重置长按锁、启动按住不触发、毫秒计数溢出 |
| 结果反馈 | 成功显示 LOCAL OK；UART 无回送显示超时；JEDEC 探测失败不会显示上次成功；PB2 结果一致 |
| CAN 互斥 | 正常会话占用时不能启动 SPI 等；长按停止；恢复失败仍 held、短按不可退出，重试成功才解锁 |
| CAN 旧后端 | 故障宏配置的原 16 走 RAW、15 走 LIVE；仅验证派发，不凭模拟 I/O 声称真实位错误 |
| 串口兼容 | 原 `fault select/run/run N`、连续两行命令；正常菜单不覆盖最后选定的故障 |
| 原有 9 项 | 协议 runner、CAN 会话、默认/开启 HAL、RAW/LIVE 开关与时序/寄存器模型全部回归通过 |

## 固件构建与发布

使用 `stm32_f407/firmware/build_profiles.ps1 -Profile all` 首轮构建：默认版和故障版均 0 error / 0 warning。正式发布必须先提交固件源代码，再使用 `-Release` 重编译，记录干净源提交、程序大小、HEX SHA-256 和文件大小，见 [发布目录](../../stm32_f407/firmware/releases/README.md)。不覆盖历史 HEX；新菜单必须烧录新版 HEX 才可使用。

## 未完成的实板验收

本次未连接实板、未烧录、未采集总线波形，不声明屏幕显示或 FPGA 检出已实测。下列项目需人工完成：

1. 上电出现四协议母菜单，反复进入/返回，确认没有额外触发；原启动 JEDEC 探测仍存在。
2. 正常项分别采集 SPI CS/SCLK/MOSI/MISO、UART TX/RX、I²C SCL/SDA、CAN 收发器总线；与本地日志对齐。
3. UART 需要 echo；I²C 会覆盖预留 EEPROM 0x0100～0x010F；CAN TX 需 ACK，CAN ECHO 另需应用层回送。
4. 逐项回归原错误事件、宏关闭行为、引脚 AF 恢复、RAW/LIVE 互斥及恢复失败保护。
5. OLED 软件 SPI 刷新与短事务同时采集，核对真实波形和执行耗时。运行提示可能一闪而过，结果与累计次数应可读。
6. FPGA 自己的事件/计数才是 PL 检测证据；`LOCAL OK` / `R 0` / PASS 不代替 FPGA 验收。
