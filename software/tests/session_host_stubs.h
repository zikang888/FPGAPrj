#ifndef SESSION_HOST_STUBS_H
#define SESSION_HOST_STUBS_H
#include <stdint.h>
typedef uint64_t XTime;
typedef struct { unsigned int BaseAddress; } XUartPs_Config;
typedef struct { int unused; } XUartPs;
#define COUNTS_PER_SECOND 1000U
#define XPAR_MULTI_PROTOCOL_CORE_0_BASEADDR 0U
#define XPAR_XUARTPS_0_DEVICE_ID 0U
#define XST_SUCCESS 0
#define XST_FAILURE 1
extern u32 mock_regs[2048];
extern XTime mock_time;
static inline u32 Xil_In32(u32 addr) { return mock_regs[addr/4U]; }
static inline void Xil_Out32(u32 addr,u32 value)
{
    u32 i;
    if(addr==0x64U && value==1U) for(i=0x3CU;i<=0x70U;i+=4U) mock_regs[i/4U]=0U;
    else if(addr==0x90U && value==1U) for(i=0x74U;i<0x90U;i+=4U) mock_regs[i/4U]=0U;
    else mock_regs[addr/4U]=value;
}
static inline void XTime_GetTime(XTime *time) { *time=mock_time; }
static inline XUartPs_Config *XUartPs_LookupConfig(u32 id)
{ static XUartPs_Config config; (void)id; return &config; }
static inline int XUartPs_CfgInitialize(XUartPs *u,XUartPs_Config *c,u32 base)
{ (void)u;(void)c;(void)base;return 0; }
static inline int XUartPs_SetBaudRate(XUartPs *u,u32 baud) { (void)u;(void)baud;return 0; }
static inline u32 XUartPs_Recv(XUartPs *u,u8 *ch,u32 count)
{ (void)u;(void)ch;(void)count;return 0U; }
static inline void usleep(u32 delay) { (void)delay; }
static inline int gt911_init(void) { return 0; }
/* Deliberately omit console output in this host-only lifecycle test. */
#define xil_printf(...) ((void)0)
#endif
