# 错误目录修订版 2026-10-27

移除 I2C SDA STUCK、SCL STUCK、CAN FORM ERROR 和 CAN TX BIT。
同步 ERROR 页面、测试总数/结论、历史错误详情、事件标色、HOME 告警和 STM32 case 映射。
原始 ABI 和枚举编号保留，旧 PL 相关原始记录显示 INFO。

14 项主机检查、生产渲染/触摸回归、ARM 编译及 JTAG 下载通过。
board/i2c_errors.png、can_errors.png 是实际板上帧缓冲，不是相机照片；已检查布局和四项删除。
本轮未重新人工验触摸；HISTORY 手感此前用户验收，本轮自动回归通过。
程序已运行；没有发协议故障刺激，没有更新 STM32 或 QSPI，没有推送 Git。
JTAG 更新会清空 RAM 历史记录，掉电后需重新下载。

四件套为本目录 BIT/HDF/ps7_init.tcl/platform_app.elf，哈希见 manifest.json。
应用 ELF SHA256: FEE5215E6443A57B67068D2A45FD0B31C493E9730C6AF5FF97ECAA6EE2091514。
源码：../../software/src；记录：../../docs/test-results/2026-10-27-retired-error-catalog.md。
