################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

C_SRCS += \
../src/GPS.c \
../src/SD_Card.c \
../src/imodeAndGps_proj.c \
../src/platform.c \
../src/tdc.c 

OBJS += \
./src/GPS.o \
./src/SD_Card.o \
./src/imodeAndGps_proj.o \
./src/platform.o \
./src/tdc.o 

C_DEPS += \
./src/GPS.d \
./src/SD_Card.d \
./src/imodeAndGps_proj.d \
./src/platform.d \
./src/tdc.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	arm-none-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I../../ImodeAndGps_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


