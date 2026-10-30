# A 版工作台 UI（2026-10-30）

状态：离线验证、ARM 编译和本轮实板界面／触摸验收通过。真实四协议故障注入未在本轮重测。

## 界面

- 800×480，左侧“波形／测试／错误／历史／状态”导航；顶部 SPI／UART／I2C／CAN 选择。
- 深色背景、青绿色选中状态、卡片数字及中文标签；波形区域配网格与位索引。
- 协议选择联动各页；测试运行时锁定协议，历史详情使用该记录保存的协议。
- 波形保持到主动重新捕获；历史列表和详情支持拖动，松手轻点打开，返回保留位置。
- I²C BUSY NACK 使用 INFO 语义；已删除的 SDA/SCL STUCK、CAN FORM、CAN TX BITS 不恢复。
- 轨迹由事件解码重构；CAN 仅显示负载位。界面不会生成未采集到的完整总线位流。

## 文件与验证

开发源码在 software/src，渲染主体 ui_a_views.inc，字体子集 ui_a_font.h。
16 项主机单元检查与生产渲染器／触摸回归通过。覆盖导航、协议锁定、测试生命周期、错误语义、历史手势和波形保持。
新 ELF 已完成 ARM 全量编译；BIT／HDF／ps7_init.tcl 复用 ui-home-hold-20261027 配套，BSP 使用的 HDF 与该版本 SHA256 一致。
精确文件哈希见 manifest.json，编译和测试日志随包附带。
preview 中图片来自实际 C 渲染器的离线测试数据，不代表实板拍照或新增实板验证。

## 本机构建

在工程根目录运行：
```powershell
& ./software/tests/run_session_checks.ps1
& ./tools/build_ui_workbench_a.ps1
```

字体文件已生成，编译时不需安装字体。若修改中文标签，运行 tools/generate_ui_a_font.py 重新生成子集；该脚本当前使用本机 Windows Consolas 和微软雅黑字体。

## 上板验收范围

匹配 BIT＋PS 初始化＋本包 ELF 下载后，核对中文显示、五页切换、四协议页面、测试开始／停止保存、HISTORY 拖动和详情返回；再用真实协议流量检查错误计数及换帧。
下载会重新启动 PS 并清空 RAM 历史。本包已执行 JTAG 下载，用户确认显示与触摸正常；未写入 QSPI。详细记录见 docs/test-results/2026-10-30-ui-workbench-a.md。
