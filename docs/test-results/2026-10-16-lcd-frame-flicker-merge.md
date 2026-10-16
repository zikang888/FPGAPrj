# LCD 闪屏修复移植记录（2026-10-16）

## 来源与范围

- 来源工程：`D:\Vivado\FPGAPrj`
- 来源提交：`61e5c9a fix(ui): synchronize VDMA frame swap and cache mirrored regions`
- 目标工程：`D:\Vivado\Project\Multi_protocol`
- 功能改动仅涉及 `software/src/platform_ui.c` 的 VDMA 双缓冲换帧路径。

## 合入内容

1. 不再用固定 34 ms 延时推断换帧完成，改为通过
   `XAxiVdma_CurrFrameStore()` 等待 VDMA 确认当前读帧。
2. 将脏区域复制到备用帧后，立即执行 `Xil_DCacheFlushRange()`，避免
   VDMA 从 DDR 读到备用帧的旧像素。
3. `XAxiVdma_StartParking()` 失败时保留渲染请求，后续循环可以重试。
4. VDMA 启动前清零并写回两个帧缓冲，避免首次显示未初始化DDR内容。
5. 初始化阶段增加最多500 ms的硬件换帧确认超时。

## 兼容性

- 保留目标工程原有的SPI采集、错误模型、错误事件页面、协议选择和触摸逻辑。
- SDK `platform_app` 通过 `repo_src` 链接直接引用 `software/src`，无需复制源码。
- 本轮未连接FPGA，因此只进行离线检查；实板烧录和闪屏回归测试待后续完成。
