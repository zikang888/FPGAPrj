# HOME 波形保留版 2026-10-27

波形区点击不重采集；只有 CAPTURE AGAIN 按钮或串口 capture again 启动。
等待期间状态 WAIT / PREVIOUS，保留上一帧；新数据完整后替换。
含此前错误目录删除、HISTORY 滑动修复。
15 项主机检查和生产触摸/绘图回归通过，实板两笔 SPI JEDEC 验证保持与替换。
board/before.png、waiting.png、after.png 是实际板上帧缓冲，不是相机照片。
四件套在本目录，哈希见 manifest.json；JTAG 临时下载，掉电需重载，不写 QSPI。
本轮未人工验触摸、未逐一重测其他三种协议实板流量、未推送 Git。
详细记录：../../docs/test-results/2026-10-27-home-waveform-hold.md。
