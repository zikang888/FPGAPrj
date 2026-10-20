#ifndef UI_PREVIEW_STUBS_H
#define UI_PREVIEW_STUBS_H
typedef struct { int placeholder; } XAxiVdma;
typedef struct { int placeholder; } XVtc;
#define XST_SUCCESS 0
#define XST_FAILURE 1
#define XAXIVDMA_READ 0
static unsigned int preview_scanned_frame;
static inline int XAxiVdma_StartParking(XAxiVdma *v, int frame, int channel)
{ (void)v; (void)channel; preview_scanned_frame=(unsigned int)frame; return 0; }
static inline unsigned int XAxiVdma_CurrFrameStore(XAxiVdma *v,int channel)
{ (void)v; (void)channel; return preview_scanned_frame; }
static inline void Xil_DCacheFlushRange(UINTPTR addr,u32 length)
{ (void)addr; (void)length; }
static inline void usleep(unsigned int delay) { (void)delay; }
#endif
