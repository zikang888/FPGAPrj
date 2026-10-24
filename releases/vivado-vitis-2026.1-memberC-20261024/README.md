# member C · Vivado / Vitis 2026.1 迁移版板测镜像

这是 2026-10-24 由 member C 实际加载和测试的配套 BIT / XSA / ELF / PS 初始化文件，供其他成员交叉验证。**member C 已确认触控正常、切换页面正常、协议监听与显示正常；请其他成员复测并在 PR 中反馈。**

本组镜像的业务源码测试提交为 `92012009201c40fd85fb181736f847d93bec279e`；后续提交补充人工验收、协作说明及本目录，未更换测试镜像。SHA256 见 `manifest.json`。本目录的文件名称与仓库旧 2018.3 发布包不同，请整组使用。

## 下载到实板

适用原 ACZ702 / `xc7z020clg484-2` 和 AC820 / GT911 接线。安装路径和线缆按自己的电脑调整，先确认唯一的目标 Zynq。

在仓库根目录执行文件预检（不连接硬件）：

```powershell
.\releases\vivado-vitis-2026.1-memberC-20261024\program_2026_1.ps1 -PreflightOnly -ToolRoot 'E:\AMDDesignTools\2026.1'
```

member C 本机新版 hw_server 枚举阻塞，因此使用下面的兼容路径；已有正常服务时先核对它的路径和版本，勿再启动一个服务端争用同一根线缆：

```powershell
Start-Process -FilePath 'C:\Xilinx\Vivado\2018.3\bin\hw_server.bat' -ArgumentList '-stcp:127.0.0.1:3121' -WindowStyle Hidden
.\releases\vivado-vitis-2026.1-memberC-20261024\program_2026_1.ps1 -ToolRoot 'E:\AMDDesignTools\2026.1'
```

下载脚本使用 2026.1 XSDB，重新配置 PL、初始化 PS 并启动 ELF；不写 Flash / SD。`JTAG_CANDIDATE_STARTED` 只表示下载流程完成，需继续查看 PS UART、LCD / 触摸和实际协议结果。两个串口均为 115200 8N1，但端口号需现场重新枚举。XSDB 的 Tcl 错误可能返回退出码 0，包装器同时核对完成标记。

## 本轮结果与边界

SPI 100 笔对账通过；UART RX 监听通过；CAN 正常回环通过；四协议 HOME 解码波形、双帧缓冲、会话保存通过。用户人工确认实屏稳定、触摸切页正常。

UART 当前 RX-only，I2C EEPROM 仍有 busy NACK；新版 hw_server、外部时序预算、完整故障集和长时间稳定性未全部验收。详见 [实板记录](../../docs/test-results/2026-10-24-vivado-2026.1-board.md) 与 [交叉验证清单](../../docs/integration/2026-10-24-member-c-migration-cross-validation.md)。
