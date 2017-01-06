/*
 * fifo.h
 *
 *  Created on: 2016Äê12ÔÂ29ÈÕ
 *      Author: Lin
 */
/****************** Include Files ********************/
#include "lidar_sys.h"

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
#define FIFO_mWriteReg(BaseAddress, RegOffset, Data) \
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
#define FIFO_mReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))


#define FIFO_BASEADDR 	XPAR_MYIP_FIFO_CTRL_0_FIFO_AXI_BASEADDR
#define FIFO_CTRL_REG_OFFSET   0
#define FIFO_FLAG_REG_OFFSET   0
#define FIFO1_CH1_DATA_REG     4
#define FIFO1_CH2_DATA_REG     8
#define FIFO1_CH3_DATA_REG     12
#define FIFO1_CH4_DATA_REG     16
#define FIFO1_CH5_DATA_REG     20
#define FIFO1_CH6_DATA_REG     24
#define FIFO1_CH7_DATA_REG     28
#define FIFO1_CH8_DATA_REG     32
#define FIFO1_GPS1_DATA_REG     36
#define FIFO1_GPS2_DATA_REG     40
#define FIFO1_START_TRI_DATA_REG     44


#define FIFO2_CH1_DATA_REG    88
#define FIFO2_CH2_DATA_REG     92
#define FIFO2_CH3_DATA_REG     96
#define FIFO2_CH4_DATA_REG     100
#define FIFO2_CH5_DATA_REG     104
#define FIFO2_CH6_DATA_REG     108
#define FIFO2_CH7_DATA_REG     112
#define FIFO2_CH8_DATA_REG     116
#define FIFO2_GPS1_DATA_REG     120
#define FIFO2_GPS2_DATA_REG     124
#define FIFO2_START_TRI_DATA_REG     128

#define FIFO_RST        1
#define FIFO1_RD        2
#define FIFO2_RD        4
#define FIFO_CTRL_CLEAR 0

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
XStatus FIFO_Reg_SelfTest(void * baseaddr_p);

void FIFO_getData(Lidar_Data *data, int fifoNum);

void FIFO_rst(void);

int FIFO_checkFifoStatus(void);

void FIFO_test(Lidar_Data *data);

void FIFO_printData(Lidar_Data *data, int range, int step);

int WaitUntilFifoIsFull(void);
