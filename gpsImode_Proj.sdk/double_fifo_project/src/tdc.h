/*
 * tdc.h
 *
 *  Created on: 2016Äê11ÔÂ12ÈÕ
 *      Author: lin.zheng
 */
//#include "SD_Card.h"
#include "GPS.h"
#ifndef SRC_TDC_H_
#define SRC_TDC_H_


#define TDC_REG_0	0x00
#define TDC_REG_1	0x01
#define TDC_REG_2	0x02
#define TDC_REG_3	0x03
#define TDC_REG_4	0x04
#define TDC_REG_5	0x05
#define TDC_REG_6	0x06
#define TDC_REG_7	0x07
#define TDC_REG_8	8
#define TDC_REG_9	9
#define TDC_REG_10	10
#define TDC_REG_11	0x0b
#define TDC_REG_12	0x0c
#define TDC_REG_13	13
#define TDC_REG_14	0x0e
#define ALU_MASTER_RST	(1<<23)
#define STOP_DIS_START	(1<<21)

#define MYIMODE_S00_AXI_SLV_REG0_OFFSET 0
#define MYIMODE_S00_AXI_SLV_REG1_OFFSET 4
#define MYIMODE_S00_AXI_SLV_REG2_OFFSET 8
#define MYIMODE_S00_AXI_SLV_REG3_OFFSET 12
#define MYIMODE_S00_AXI_SLV_REG4_OFFSET 16
#define MYIMODE_S00_AXI_SLV_REG5_OFFSET 20
#define MYIMODE_S00_AXI_SLV_REG6_OFFSET 24
#define MYIMODE_S00_AXI_SLV_REG7_OFFSET 28
#define MYIMODE_S00_AXI_SLV_REG8_OFFSET 32
#define MYIMODE_S00_AXI_SLV_REG9_OFFSET 36
#define MYIMODE_S00_AXI_SLV_REG10_OFFSET 40
#define MYIMODE_S00_AXI_SLV_REG11_OFFSET 44
#define MYIMODE_S00_AXI_SLV_REG12_OFFSET 48
#define MYIMODE_S00_AXI_SLV_REG13_OFFSET 52
#define MYIMODE_S00_AXI_SLV_REG14_OFFSET 56
#define MYIMODE_S00_AXI_SLV_REG15_OFFSET 60
#define MYIMODE_S00_AXI_SLV_REG16_OFFSET 64
#define MYIMODE_S00_AXI_SLV_REG17_OFFSET 68
#define MYIMODE_S00_AXI_SLV_REG18_OFFSET 72
#define MYIMODE_S00_AXI_SLV_REG19_OFFSET 76
#define MYIMODE_S00_AXI_SLV_REG20_OFFSET 80
#define MYIMODE_S00_AXI_SLV_REG21_OFFSET 84
#define MYIMODE_S00_AXI_SLV_REG22_OFFSET 88
#define MYIMODE_S00_AXI_SLV_REG23_OFFSET 92
#define MYIMODE_S00_AXI_SLV_REG24_OFFSET 96
#define MYIMODE_S00_AXI_SLV_REG25_OFFSET 100

#define REG_CSN		MYIMODE_S00_AXI_SLV_REG0_OFFSET
#define REG_RDN		MYIMODE_S00_AXI_SLV_REG2_OFFSET
#define REG_ADDR	MYIMODE_S00_AXI_SLV_REG3_OFFSET
#define	REG_DATA	MYIMODE_S00_AXI_SLV_REG4_OFFSET

#define REG_EF1		MYIMODE_S00_AXI_SLV_REG5_OFFSET
#define REG_EF2		MYIMODE_S00_AXI_SLV_REG6_OFFSET
#define REG_STOPDIS	MYIMODE_S00_AXI_SLV_REG7_OFFSET
#define REG_RECV_FLAG	MYIMODE_S00_AXI_SLV_REG20_OFFSET

#define REG_START_TRI_COUNTTER	MYIMODE_S00_AXI_SLV_REG2_OFFSET
#define REG_IRFLAG	MYIMODE_S00_AXI_SLV_REG8_OFFSET
#define	REG_ERRFLAG	MYIMODE_S00_AXI_SLV_REG12_OFFSET


#define I_MODE_MAX_CH_NUM	8


#define TDC_BASEADDR XPAR_MYIMODE_0_S00_AXI_BASEADDR

typedef struct {
	int ErrFlag;
	int IrFlag;
	int EF1;
	int EF2;
}TDC_FlagInfo;


/**************************** Type Definitions *****************************/
/**
 *
 * Write a value to a MYIMODE register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the MYIMODEdevice.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void MYIMODE_mWriteReg(u32 BaseAddress, unsigned RegOffset, u32 Data)
 *
 */
#define MYIMODE_mWriteReg(BaseAddress, RegOffset, Data) \
  	Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))

/**
 *
 * Read a value from a MYIMODE register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the MYIMODE device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	u32 MYIMODE_mReadReg(u32 BaseAddress, unsigned RegOffset)
 *
 */
#define MYIMODE_mReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))

/************************** Function Prototypes ****************************/
/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the MYIMODE instance to be worked on.
 *
 * @return
 *
 *    - XST_SUCCESS   if all self-test code passed
 *    - XST_FAILURE   if any self-test code failed
 *
 * @note    Caching must be turned off for this function to work.
 * @note    Self test may fail if data memory and device are not on the same bus.
 *
 */
XStatus MYIMODE_Reg_SelfTest(void * baseaddr_p);


void TDC_config(void);

void TDC_RegConfig(int regNum, int configData);

int  TDC_ReadRegData(int regNum);

void TDC_CheckIfNeedMasterRest(void);

void TDC_PrintChDatas(unsigned int  (*chandata)[I_MODE_MAX_CH_NUM]);

void TDC_resetFifoFullFlag(void);

void TDC_TimeDataAllocate_test(void);
#endif /* SRC_TDC_H_ */
