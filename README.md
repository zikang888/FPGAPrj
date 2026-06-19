# 无线传输信号模拟系统 — STM32 控制板固件

基于 STM32F103 + FreeRTOS 的 ZYNQ7020 无线传输信号模拟器控制面板，提供 OLED 菜单交互与 UART 串口参数下发。

## 硬件需求

| 外设 | 接口 | 引脚 |
|------|------|------|
| OLED (SSD1306, 128x64, I2C) | I2C1 | PB6(SCL), PB7(SDA) |
| KEY_UP (向上) | GPIO 输入(内部上拉) | PA0 |
| KEY_DOWN (向下) | GPIO 输入(内部上拉) | PA1 |
| KEY_OK (确认) | GPIO 输入(内部上拉) | PA2 |
| UART (至 ZYNQ) | USART1 | PA9(TX), PA10(RX) |

> OLED I2C 地址默认为 0x3C (7位地址)。

## 文件结构

```
├── Core/                      # STM32CubeMX 生成代码
│   ├── Inc/
│   │   ├── main.h             # 引脚宏定义 (KEY_UP_Pin, KEY_DOWN_Pin, KEY_OK_Pin)
│   │   ├── gpio.h
│   │   ├── i2c.h              # hi2c1 声明
│   │   └── usart.h            # huart1 声明
│   └── Src/
│       ├── main.c             # 入口, 外设初始化, 启动调度器
│       ├── freertos.c         # FreeRTOS 任务创建 + __weak work 函数
│       ├── gpio.c             # GPIO 初始化 (按键引脚)
│       ├── i2c.c              # I2C1 初始化 (OLED)
│       └── usart.c            # USART1 初始化 (UART 通信)
├── Middlewares/Third_Party/FreeRTOS/
├── ModuleLayer/               # 用户模块 (核心代码)
│   ├── OLED.h                 # OLED 驱动 API
│   ├── OLED.c                 # SSD1306 驱动 + 覆盖 oled_work()
│   ├── OLED_Font.h            # 8x16 ASCII 字库
│   ├── KEY.h                  # 按键/菜单/参数结构体定义
│   ├── KEY.c                  # 按键扫描+消抖+菜单状态机 + 覆盖 key_work()
│   ├── uart.h                 # UART 发送 API
│   └── uart.c                 # 数据帧组包+CRC + 覆盖 uart_work()
└── README.md
```

## 基本操作

### 按键功能

| 按键 | 主菜单 | 子菜单 |
|------|--------|--------|
| UP (PA0) | 上移选中项 | 增大参数值 |
| DOWN (PA1) | 下移选中项 | 减小参数值 |
| OK 单击 (PA2) | 进入子菜单 | 确认值，返回主菜单 |
| OK 双击 (300ms内) | — | 立即返回主菜单 |

### 主菜单

OLED 显示标题行 `==Param Menu==`，下方滚动显示 7 个参数项，`>` 指示当前选中项：

```
==Param Menu==
>Freq     35
 Ampl   500
 Mod     50%
```

### 子菜单

按 OK 进入当前参数的子菜单，显示参数名、当前值、范围、操作提示：

```
Freq
Value: 35
Range:30-40MHz
UD:adj OK:cfm
```

- 按 UP/DOWN 调整值（自动进入编辑模式）
- 按 OK 确认并返回主菜单
- OK 双击直接返回主菜单

### 参数列表

| # | 参数名 | 范围 | 步进 | 默认值 | UART 字段 |
|---|--------|------|------|--------|-----------|
| 0 | 载波频率 | 30 ~ 40 MHz | 1 | 35 | `F` (3位) |
| 1 | 直达信号幅度 | 100 ~ 1000 mV | 100 | 500 | `A` (4位) |
| 2 | AM 调制度 | 30 ~ 90% | 10 | 50 | `M` (2位) |
| 3 | 多径信号时延 | 50/80/110/140/170/200 ns | — | 110 | `D` (3位) |
| 4 | 多径信号初相位差 | 0/30/60/90/120/150/180 deg | — | 0 | `P` (3位) |
| 5 | 多径信号幅度衰减 | 0/2/4/.../20 dB | — | 0 | `L` (2位) |
| 6 | 信号类型 | CW / AM | — | CW | `T` (2字符) |

> 调制度仅 AM 类型有效，相位差仅 CW 类型有效。

## UART 通信协议

### 数据帧格式

```
$F036A0500M50D110P000L00TCW*<CRC2>\r\n
```

- `$` — 帧起始
- `F`、`A`、`M`、`D`、`P`、`L`、`T` — 参数字段（数值固定宽度，高位补零）
- `*` — CRC 分隔符
- `<CRC2>` — CRC8 校验值（大写十六进制 2 字符），计算范围：`$` 之后 `*` 之前的所有 ASCII 字节
- `\r\n` — 帧结束

### CRC8 算法

多项式 `0x31`，初始值 `0x00`（MAXIM 1-Wire CRC-8）：

```c
uint8_t CalcCRC8(const uint8_t *data, uint16_t len) {
    uint8_t crc = 0x00;
    for (uint16_t i = 0; i < len; i++) {
        crc ^= data[i];
        for (uint8_t j = 0; j < 8; j++) {
            if (crc & 0x80)
                crc = (uint8_t)((crc << 1) ^ 0x31);
            else
                crc = (uint8_t)(crc << 1);
        }
    }
    return crc;
}
```

## 如何移植到其他板子

### 1. STM32CubeMX 配置

参考以下配置创建新工程：

- **I2C1**：SCL=PB6, SDA=PB7, 100kHz
- **USART1**：TX=PA9, RX=PA10, 115200-8N1
- **GPIO**：PA0, PA1, PA2 为输入模式，内部上拉
- **FreeRTOS**：使用 CMSIS_V2 或 V1 接口均可（代码使用 `cmsis_os.h`）
- 创建 3 个任务（见下方）

### 2. 引脚修改

**按键引脚** — 修改 [`Core/Inc/main.h`](file:///d:/Cubemx/Project/STM32_test/Core/Inc/main.h) 中的宏定义：

```c
#define KEY_UP_Pin       GPIO_PIN_0    // 改为你的 UP 引脚号
#define KEY_UP_GPIO_Port GPIOA         // 改为你的 UP 引脚端口
#define KEY_DOWN_Pin     GPIO_PIN_1
#define KEY_DOWN_GPIO_Port GPIOA
#define KEY_OK_Pin       GPIO_PIN_2
#define KEY_OK_GPIO_Port GPIOA
```

**OLED** — I2C 引脚在 [`Core/Src/i2c.c`](file:///d:/Cubemx/Project/STM32_test/Core/Src/i2c.c) 中由 CubeMX 生成，无需手动修改。

**UART** — 串口引脚在 [`Core/Src/usart.c`](file:///d:/Cubemx/Project/STM32_test/Core/Src/usart.c) 中由 CubeMX 生成，无需手动修改。

### 3. FreeRTOS 任务创建

在 `freertos.c` 的 `MX_FREERTOS_Init()` 中创建以下任务（任务名需与 `__weak` 函数名对应）：

```c
osThreadDef(oled_task, oled_work, osPriorityNormal, 0, 256);
oled_taskHandle = osThreadCreate(osThread(oled_task), NULL);

osThreadDef(key_task, key_work, osPriorityAboveNormal, 0, 128);
key_taskHandle = osThreadCreate(osThread(key_task), NULL);

osThreadDef(uart_task, uart_work, osPriorityBelowNormal, 0, 256);
uart_taskHandle = osThreadCreate(osThread(uart_task), NULL);
```

> 三个 `__weak` 函数的实现在 `ModuleLayer/` 中，链接时会自动覆盖 `freertos.c` 中的弱定义。

### 4. 将 ModuleLayer 加入编译

将 `ModuleLayer/` 目录下所有 `.c` 文件加入编译（在 IDE 中添加到对应组，或修改 Makefile/CMakeLists 添加路径）。

### 5. 修改 UART 波特率（可选）

在 `usart.c` 的 `MX_USART1_UART_Init()` 中修改 `huart1.Init.BaudRate`。

### 6. 修改数据帧协议（可选）

如果需要修改 UART 数据帧中参数的字母代号或格式，修改 [`ModuleLayer/uart.c`](file:///d:/Cubemx/Project/STM32_test/ModuleLayer/uart.c) 中 `UART_SendParams()` 函数的组包逻辑。

## 依赖说明

- STM32 HAL 库
- FreeRTOS (CMSIS RTOS 封装)
- 无第三方库依赖
