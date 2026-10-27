# 四协议 UI 使用流程（2026-10-24）

## 2026-10-27 错误目录修订

- 按项目首版范围移除 I2C SDA STUCK、I2C SCL STUCK、CAN FORM ERROR 和 CAN TX BIT。
- I2C 错误页保留地址 NACK、EEPROM BUSY（INFO）、MISSING STOP 和事件丢失。
- CAN 错误页保留 ACK MISSING、STUFF、CRC 和事件丢失。BUS-OFF 仍需 STM32 状态，不能从监听结果推定。
- 四项不参与本轮错误总数、通过/失败结论、历史错误详情或 HOME 波形告警；STM32 对应 case ID 不再映射为受支持错误。
- 原始事件 ABI、寄存器地址和软件枚举编号保留，避免与现有 BIT/HDF 不兼容；旧 PL 若输出这些记录，事件列表显示 INFO，原始数据仍可追溯。
- 本次仅修改 PS 软件，无须重新生成 BIT。具体新发布及验收见 `docs/test-results/2026-10-27-retired-error-catalog.md`。

## 当前开发位置

- 工作目录：`D:\fpga_class\FPGAPrj\ab_new_board_test_20261017`
- 本地开发分支：`codex/ui-four-protocol-20261023`。
- FPGA/波形基线：远端 `fix/fpga_waveform`，提交 `0d9fde5`。
- 本次读取 STM32 `memberC/stm32-f407` 的 `d17568e` 发布说明，不覆盖或声称
  已整合其独立固件分支。原本地 STM32 目录保留，不等于该目录是最新固件。
- 本次只整合 `software`、`fpga`、协议/测试文档与配套 `platform_hw`。
  原本四个未提交文件未改动，也不接受队友分支对 STM32 目录的整体删除。

## 从用户角度操作

1. HOME 选 SPI、UART、I2C 或 CAN。`SUPPORTED` 只表示 BIT 实现了该协议，
   不表示插线正确或测试通过。
2. HOME 默认等待一次真实数据突发。STM32 发送后显示解码轨迹和字节。
   `CAPTURE AGAIN` 可再次采集。轨迹是解码事件重构，不是等时间模拟采样。
3. 需要正式错误计数时，打开 TESTS，点 `START NEW / RESET`。
4. 从 STM32 发正常或故障测试，再点 `STOP & SAVE`。正在测试时 START 按钮
   禁用，防止误触清掉计数。串口明确发出的重新开始命令保持原行为。
5. TESTS 查看事件并逐像素滚动，ERRORS 查看本轮结果和一条排查建议。
6. HISTORY 直接从底栏进入，点历史行、再点 `ERROR DETAILS` 查看对应协议
   结果；I2C/CAN 不再误用 SPI 标签。最多8轮、每轮保留最后256个事件，断电清除。
7. STATUS 保留系统 ID、版本、AXI、触摸、缓存和外部丢失等工程诊断。

## 状态与边界

- 无测试：`NO TEST YET`。开始但没流量：`WAITING FOR DATA`。
- 保存空测试：`NO DATA RECEIVED`。不能把没有流量当成已验证零错误。
- `UNKNOWN` 表示没有对应检测来源，不能当作0。
- EEPROM busy NACK 单独显示 INFO，仍保存次数，但不计入本轮失败/历史错误总数。
- UART 仍是 RX 监听，不能把干净的 RX 解码当作 FPGA 已实现 UART 回传。
- CAN 使用两个收发器的第二节点，W8输出/AA11输入。BUS-OFF 需STM32控制器状态，
  当前FPGA UI尚未接入该报告，因此保持未知，不虚构成功/零值。
- 本次没有给电机驱动器新增发送指令，也没有驱动外部电机。

## 验证

- 基线：队友版11项主机测试及生产 UI 渲染/触摸测试通过。
- 改版第一轮：12项主机测试及UI渲染/触摸测试通过。
- 第二轮：新增I2C busy计数到历史的生命周期回归、五页按钮、防误触、四协议
  轨迹与I2C/CAN历史预览。测试夹具busy寄存器地址初次填写错误，改为0xA0后
  全套重新通过。没有把该夹具错误当作硬件缺陷。
- 编译使用队友最新版匹配BIT/HDF，在隔离SDK目录生成新BSP和ELF。
- 原四个用户修改的前后diff补丁SHA256相同。
- UI预览是宿主端执行实际绘图代码的离线结果，**不是新版本的实板证据**。
- 本次未下载JTAG、未烧写QSPI、未推送远端。

## 文件位置

- 业务源码：`software/src/platform_ui.c`、`ui_workflow.h`、`main.c`。
- 回归：`powershell -ExecutionPolicy Bypass -File software/tests/run_session_checks.ps1`。
- 离线帧：`build/session20261020/preview/`，目录沿用原脚本名称，非验证日期。
- SDK：`build/ui-workflow-20261023/sdk/`，目录沿用本轮开始日期。
- 精确配套下载文件：`releases/ui-workflow-20261024/`。
