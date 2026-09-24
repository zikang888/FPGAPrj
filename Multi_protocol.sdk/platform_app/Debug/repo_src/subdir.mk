################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
D:/Vivado/Project/Multi_protocol/software/src/capture_demo.c \
D:/Vivado/Project/Multi_protocol/software/src/main.c \
D:/Vivado/Project/Multi_protocol/software/src/platform_ui.c \
D:/Vivado/Project/Multi_protocol/software/src/ps_gpio.c \
D:/Vivado/Project/Multi_protocol/software/src/ps_iic.c \
D:/Vivado/Project/Multi_protocol/software/src/touch.c 

OBJS += \
./repo_src/capture_demo.o \
./repo_src/main.o \
./repo_src/platform_ui.o \
./repo_src/ps_gpio.o \
./repo_src/ps_iic.o \
./repo_src/touch.o 

C_DEPS += \
./repo_src/capture_demo.d \
./repo_src/main.d \
./repo_src/platform_ui.d \
./repo_src/ps_gpio.d \
./repo_src/ps_iic.d \
./repo_src/touch.d 


# Each subdirectory must supply rules for building sources it contributes
repo_src/capture_demo.o: D:/Vivado/Project/Multi_protocol/software/src/capture_demo.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O3 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../platform_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

repo_src/main.o: D:/Vivado/Project/Multi_protocol/software/src/main.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O3 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../platform_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

repo_src/platform_ui.o: D:/Vivado/Project/Multi_protocol/software/src/platform_ui.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O3 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../platform_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

repo_src/ps_gpio.o: D:/Vivado/Project/Multi_protocol/software/src/ps_gpio.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O3 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../platform_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

repo_src/ps_iic.o: D:/Vivado/Project/Multi_protocol/software/src/ps_iic.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O3 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../platform_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

repo_src/touch.o: D:/Vivado/Project/Multi_protocol/software/src/touch.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O3 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../platform_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


