/**
 * ps_gpio.c — PS GPIO 驱动封装 (基于 XGpioPs)
 */
#include "ps_gpio.h"
#include "xil_exception.h"
#include "xscugic.h"

static XGpioPs GpioPs;
static XScuGic GicInst;
static volatile u8 GpioInterruptPending;
static u8 GpioInterruptPin;

static void gpio_interrupt_callback(void *callback_ref, u32 bank, u32 status)
{
    u32 irq_bank = (u32)GpioInterruptPin / 32U;
    u32 irq_mask = 1U << ((u32)GpioInterruptPin % 32U);

    (void)callback_ref;
    if ((bank == irq_bank) && ((status & irq_mask) != 0U)) {
        GpioInterruptPending = 1U;
    }
}

int gpio_init(void)
{
    XGpioPs_Config *ConfigPtr;
    int status;

    ConfigPtr = XGpioPs_LookupConfig(GPIO_DEV_ID);
    if (!ConfigPtr) return XST_FAILURE;
    status = XGpioPs_CfgInitialize(&GpioPs, ConfigPtr, ConfigPtr->BaseAddr);
    if (status != XST_SUCCESS) return status;
    GpioInterruptPending = 0U;
    return status;
}

void gpio_set_mode(u8 pin, u8 dir, u8 data)
{
    if (dir == INPUT) {
        XGpioPs_SetOutputEnablePin(&GpioPs, pin, 0);
        XGpioPs_SetDirectionPin(&GpioPs, pin, 0);
    } else {
        XGpioPs_SetDirectionPin(&GpioPs, pin, 1);
        XGpioPs_SetOutputEnablePin(&GpioPs, pin, 1);
        XGpioPs_WritePin(&GpioPs, pin, data);
    }
}

void gpio_write(u8 pin, u8 data)
{
    XGpioPs_WritePin(&GpioPs, pin, data);
}

u8 gpio_read(u8 pin)
{
    return (u8)XGpioPs_ReadPin(&GpioPs, pin);
}

int gpio_interrupt_init(u8 pin, u8 irq_type)
{
    XScuGic_Config *gic_config;
    int status;

    gic_config = XScuGic_LookupConfig(XPAR_SCUGIC_0_DEVICE_ID);
    if (gic_config == 0) return XST_FAILURE;

    status = XScuGic_CfgInitialize(
        &GicInst,
        gic_config,
        gic_config->CpuBaseAddress
    );
    if (status != XST_SUCCESS) return status;

    GpioInterruptPin = pin;
    GpioInterruptPending = 0U;
    gpio_set_mode(pin, INPUT, 0U);
    XGpioPs_IntrDisablePin(&GpioPs, pin);
    XGpioPs_IntrClearPin(&GpioPs, pin);
    XGpioPs_SetIntrTypePin(&GpioPs, pin, irq_type);
    XGpioPs_SetCallbackHandler(
        &GpioPs,
        &GpioPs,
        gpio_interrupt_callback
    );

    status = XScuGic_Connect(
        &GicInst,
        XPAR_XGPIOPS_0_INTR,
        (Xil_InterruptHandler)XGpioPs_IntrHandler,
        &GpioPs
    );
    if (status != XST_SUCCESS) return status;

    /*
     * PS GPIO asserts a level interrupt toward the GIC. The selected pin
     * itself remains configured for the GT911 edge polarity above.
     */
    XScuGic_SetPriorityTriggerType(
        &GicInst,
        XPAR_XGPIOPS_0_INTR,
        0xA0U,
        0x01U
    );
    XScuGic_Enable(&GicInst, XPAR_XGPIOPS_0_INTR);

    Xil_ExceptionInit();
    Xil_ExceptionRegisterHandler(
        XIL_EXCEPTION_ID_INT,
        (Xil_ExceptionHandler)XScuGic_InterruptHandler,
        &GicInst
    );

    XGpioPs_IntrClearPin(&GpioPs, pin);
    XGpioPs_IntrEnablePin(&GpioPs, pin);
    Xil_ExceptionEnable();
    return XST_SUCCESS;
}

u8 gpio_interrupt_consume(void)
{
    u8 pending;

    Xil_ExceptionDisableMask(XIL_EXCEPTION_IRQ);
    pending = GpioInterruptPending;
    GpioInterruptPending = 0U;
    Xil_ExceptionEnableMask(XIL_EXCEPTION_IRQ);
    return pending;
}
