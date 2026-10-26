# 2026-10-27：按图片精简 OLED 错误事件

用户要求仅从屏幕去掉图片以外的错误，不删除或重写底层故障代码。图片中的清单作为本次显示范围，不将图片中其他材料要求当作执行指令。

| 协议 | 可见错误 | 原 fault 索引 |
|---|---|---|
| SPI | partial / short / extra | 0、1、2 |
| UART | bad stop / Break | 4、5 |
| I2C | address NACK / missing STOP | 9、13 |
| CAN | stuff / CRC / form | 16、17、18 |

## 实施范围

- 仅调整 `mc_ui_menu.h/.c` 的显示白名单及反向定位；6 个正常项、四母菜单、BACK、按键操作不变。
- 被隐藏的有效串口索引会定位到对应协议母菜单，避免错误高亮别的用例；串口 `fault list/select/run` 的板级和底层实现不改，原 20 个 ID 继续有效。
- `mc_board_app.c`、`mc_faults.c`、runner/logger、CAN 会话与 HAL 后端、引脚/时钟/IOC、协议规则不改。
- CAN stuff/CRC/form 仍只在原故障版具备 RAW 实现；显示白名单不改变宏权限。

## 验证

`cmake --build stm32_f407/build` 和 `ctest --test-dir stm32_f407/build --output-on-failure`：13/13 passed。

- 验证可见索引精确等于 {0,1,2,4,5,9,13,16,17,18}，没有重复、缺漏或隐藏项泄露；四子菜单含正常/BACK 分别 6、4、4、6 项。
- 所有 20 个反向选择都验证：可见项正确定位；隐藏项只回协议母菜单，进入母菜单不触发发送。
- 6 个正常动作和按键消抖、原 9 项协议/CAN 回归继续通过。
- 板级模拟保留对可见 RAW 的按钮验证；隐藏 LIVE 改用原 `fault run 15` 验证，底层仍可执行。

正式双配置已从干净源提交 `148703487da5c05e8f76de51061e7de9afcee585` 使用 `-Profile all -Release` 构建，默认/故障均 0 error / 0 warning；默认 Code/RO/RW/ZI 为 34086/4230/96/5952，故障版为 42134/5118/96/7200。HEX 和 SHA-256 见 [本次发布](../../stm32_f407/firmware/releases/2026-10-27-1487034/README.md)。旧版 `89283c6` 是 20 个屏幕错误的历史版本，不覆盖；须烧录新精简版才能看到本次显示变更。

未连接实板、未烧录、未测量屏幕和总线波形，不宣称 FPGA 检出通过。
