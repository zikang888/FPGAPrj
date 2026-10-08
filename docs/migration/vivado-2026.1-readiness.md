# Vivado/Vitis 2026.1 迁移准备与验收门槛（2026-10-08）

## 当前可复现基线

- 保留的已上板基线：`codex/fpga-ab-week2-c-integration`，Vivado/SDK 2018.3，
  `xc7z020clg484-2`；候选 BIT/HDF 在 `Multi_protocol.sdk/platform_hw`。
- 2026-10-08 的整合版已实测 LCD/GT911 页面、自测、25 条虚拟事件滚动，
  STM32F407 板载 W25Q128 的 SPI 100 笔：STM32 100/100 正确，PL 600
  事件（100 START、400 DATA、100 END）、外部丢弃和协议错误为 0。
  早前一轮首笔 JEDEC 曾返回全 FF，原因未定位；详见同日验收记录。
- 该基线不等于 2026.1 验收。2026.1 的工程、BIT、XSA、PS ELF 均尚未生成。

## 环境与版本边界

本机常见安装位置只找到 Vivado/SDK 2018.3，未找到 2026.1 安装或安装包。
2026.1 需要可用许可证；官方列明 Zynq-7000 在各订阅层级受支持，
但具体功能仍受层级约束。安装前须在安装器摘要核对空间需求，
不要预设现有 D 盘约 39 GiB 空闲足够。不要卸载 2018.3。

旧路径 `Multi_protocol.xpr` / Block Design 为 2018.3 格式，
`fpga/build/build_bitstream.tcl` 使用 `write_hwdef` 产出 HDF，
`software/build_ps_app.tcl` 使用 SDK `xsct` 和 HDF。2026.1 迁移须在
隔离副本中处理 IP/BD 升级，并输出包含 BIT 的 XSA，再以 Vitis 2026.1
建立 Zynq A9 standalone 平台及应用。旧 SDK workspace、HDF、BSP 和 ELF
不能直接作为新版编译/上板通过的证据。

## 隔离迁移步骤与停止条件

1. 在不含 Vivado 自动修改的已提交基线上新建独立 Git 工作树/分支；
   保留 2018.3 分支及已验证 BIT/HDF/ELF，禁止在原工作树直接升级 IP。
2. 安装 Vivado 与 Vitis 2026.1、Zynq-7000 器件支持，确认许可证能让
   Vivado 正常启动；确认足够的安装和实现运行空间。未达到此门槛时
   不宣称迁移已开始编译。
3. 在副本打开 `.xpr`，先记录 `report_ip_status`/BD 验证差异，
   再逐项升级必要 IP。关注 PS7、AXI VDMA/VTC/Video Out、AXI
   interconnect/SmartConnect、`xlconstant` 等；升级可能删除旧 output
   products 和 DCP，必须重新生成，不能沿用 2018.3 的实现结果。
4. 运行现有五项 RTL 回归，并对新版 BD 做 Validate Design；重新综合、
   实现、生成 BIT，记录 DRC、LUT/FF/BRAM/DSP、WNS/WHS/TNS/THS。
   若管脚、时钟或地址映射变化，先停止并审查，不直接上板。
5. 导出包含 BIT 的 XSA，在 Vitis 2026.1 为 `ps7_cortexa9_0` 建立
   standalone 平台与 PS 应用，引用仓库唯一源码 `software/src`；
   重新编译 ELF 并检查寄存器基地址、BSP 驱动、触摸/LCD 初始化。
6. 只用新 BIT/XSA/ELF 配套组合上板：先确认 DONE/PS JTAG、
   SYS_ID/版本/能力位，后测 LCD/触摸/D1/自测，再测 SPI 10 笔和
   独立 100 笔。保留 2018.3 与 2026.1 同一测试用例的差异记录。
   任一门槛失败即停在迁移分支，不替换已验证发布基线。

## 项目后续，不因工具升级而自动完成

- 当前 PL 只有 SPI Mode-0 监听器；UART、I2C、CAN 的 PL 监听/异常
  判定、故障注入仍未见已验证实现。
- STM32F407 工程包含 SPI/UART/I2C/CAN 测试命令，但本整合版只拿到
  SPI 与 FPGA 的同轮实板证据。UART、I2C、CAN 还需器件/收发器接线
  核对、独立真值日志及与 FPGA 的一致性验收。
- `docs/protocol-rules/protocol_rules.yaml` 已从成员 C 原分支补回，
  当前 `rules_version=1.0.0-draft-repo-abi`、状态仍为草案；正式冻结、
  变更批准及更高强度的验收阈值需团队确认，不把草案写成已批准规则。

## 官方依据

- [UG973：2026.1 器件层级、许可证和安装要求](https://docs.amd.com/r/en-US/ug973-vivado-release-notes-install-license/Supported-Devices-and-Features)
- [UG973：Zynq-7000 各层级器件支持](https://docs.amd.com/r/en-US/ug973-vivado-release-notes-install-license/Device-Availability-by-Subscription-Tier)
- [UG896：升级 IP 时输出产物和设计运行会被移除](https://docs.amd.com/r/en-US/ug896-vivado-ip/Upgrading-IP)
- [UG1400：以 XSA 建立 Vitis 平台](https://docs.amd.com/r/en-US/ug1400-vitis-embedded/Creating-a-Platform-Component-from-XSA)
