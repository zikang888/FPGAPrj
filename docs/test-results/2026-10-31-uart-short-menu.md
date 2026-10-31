# UART SHORT TXN 菜单与混合模式验证（2026-10-31）

基线：STM32F407 分支源码提交 `b1fc635`。UART SHORT TXN（索引 7）重新显示，CAN FORM（索引 18）从 OLED 隐藏；两项原 `fault run` 保留，CAN FORM 混合串口入口保留。

主机测试：GCC 6.3.0，`-Wall -Wextra -Wpedantic -Werror`，15/15 通过。默认及 CAN 故障配置的真实板级应用模拟检查 UART SHORT 菜单 SINGLE、ONE IN 100，正常槽 99 次 8 字节，故障槽 1 次 3 字节，以及 CAN FORM 隐藏选择。调度器检查 11 个混合故障。以上不等价于波形或 FPGA 实板验证。

Keil 构建：本机 C:/Keil_v5/UV4/UV4.exe，ARMCC 5.06 update 1；默认版编译通过但链接报 `L6050U`，代码 37970 字节超过该链接器限制，未生成新 HEX；CAN 故障版因此未构建。未烧录或采集波形。已有发布 HEX 为旧版本，不能用于验证本次变更。
