#ifndef TEST_XIL_IO_H
#define TEST_XIL_IO_H
#include "xil_types.h"
u32 test_read32(u32 address);
void test_write32(u32 address,u32 value);
#define Xil_In32 test_read32
#define Xil_Out32 test_write32
#endif
