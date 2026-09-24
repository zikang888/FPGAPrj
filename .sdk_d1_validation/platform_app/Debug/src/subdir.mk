################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

C_SRCS += \
../src/capture_demo.c \
../src/main.c \
../src/platform_ui.c \
../src/ps_gpio.c \
../src/ps_iic.c \
../src/touch.c 

OBJS += \
./src/capture_demo.o \
./src/main.o \
./src/platform_ui.o \
./src/ps_gpio.o \
./src/ps_iic.o \
./src/touch.o 

C_DEPS += \
./src/capture_demo.d \
./src/main.d \
./src/platform_ui.d \
./src/ps_gpio.d \
./src/ps_iic.d \
./src/touch.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O3 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../platform_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


