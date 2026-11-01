# 当前实板版本：error-retention-20261101

文件集：releases/error-retention-20261101/，BIT/HDF/init/ELF 为同套新构建，哈希见 manifest.json。
平台 VERSION=00010009，CAPABILITIES=000003FF，需新旧软硬件一起匹配。
TESTS 使用异常事务档案，正常事件仅计数；单次捕获仍用原快照模式。
四协议各100笔、第50笔错误及周期10次错误实板验证通过，错误明细未被后续正常事件覆盖。
UART 奇偶校验/波特率和 CAN bus-off 未启用项已从屏幕删除。详细范围及限制见 docs/test-results/2026-11-01-error-retention.md。
原始数字采样未新增；RAM历史最多8轮、每轮256条异常事件，存满提示且不覆盖旧异常。JTAG掉电需重载，未写QSPI。
旧版本 releases/ui-home-hold-20261027、candidates/ui-saved-error-20261031 保留用于追溯和回退；本轮未推送。