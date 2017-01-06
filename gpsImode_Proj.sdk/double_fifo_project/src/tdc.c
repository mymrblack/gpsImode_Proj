/*
 * tdc.c
 *
 *  Created on: 2016Äê11ÔÂ12ÈÕ
 *      Author: lin.zheng
 */
#include <stdio.h>
#include "xsdps.h"
#include "xil_printf.h"
#include "sleep.h"
#include "tdc.h"


//tested.
void TDC_config(void)
{
	TDC_RegConfig(TDC_REG_0, 0x007FC81);
	TDC_RegConfig(TDC_REG_1, 0x0000000);
	TDC_RegConfig(TDC_REG_2, 0x0000002);
	TDC_RegConfig(TDC_REG_3, 0x0000000);
	TDC_RegConfig(TDC_REG_4, 0x6000000);
	TDC_RegConfig(TDC_REG_5, 0x0E004DA | ALU_MASTER_RST | STOP_DIS_START);
	TDC_RegConfig(TDC_REG_6, 0x0000000);
	TDC_RegConfig(TDC_REG_7, 0x0281FB4);
	TDC_RegConfig(TDC_REG_11, 0x7FF0000);
	TDC_RegConfig(TDC_REG_12, 0x0000000);
	TDC_RegConfig(TDC_REG_14, 0x0000000);
	TDC_RegConfig(TDC_REG_4, 0x6400000);
	return;
}


//tested.
void TDC_resetFifoFullFlag(void){
	MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 1<<4|0x0c);
	MYIMODE_mReadReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG4_OFFSET);
	MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x00);
}


//tested.
void TDC_RegConfig(int regNum, int configData){
	 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG4_OFFSET , configData);//WRITE_DATA
	 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 1<<5|regNum);//WRN_SET
	 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x00);//WRN_RSET
	 return;
}

//tested.
int TDC_ReadRegData(int regNum){
	int readData = 0;
	MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 1<<4|regNum);
	readData= MYIMODE_mReadReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG4_OFFSET);
	MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x00);
	return readData;
}


//tested.
void TDC_CheckIfNeedMasterRest(void){
		 TDC_RegConfig(TDC_REG_4, 0x6400000);
}

//#define TDC_TEST
#ifdef TDC_TEST
#define FIFO_SIZE  8192
unsigned int chandata[FIFO_SIZE][11]={{0,0,0,0,0,0,0,0,0}};
void TDC_TimeDataAllocate_test(void){
    int i;
    int status = 0;

    xil_printf("Tstart status :%d\r\n", MYIMODE_mReadReg(TDC_BASEADDR, 8));
    while(1){

        for(i = 0; i < FIFO_SIZE; i++){
            while(1){
            	status = MYIMODE_mReadReg(TDC_BASEADDR, 0);//check stopDis, if it became 1, then the data can be read.
                if(status != 0){
                    usleep(11);
                    break;
                }
                usleep(1);
            }
                 chandata[i][0] = MYIMODE_mReadReg(TDC_BASEADDR, 36);
                 chandata[i][1] = MYIMODE_mReadReg(TDC_BASEADDR, 40);
                 chandata[i][2] = MYIMODE_mReadReg(TDC_BASEADDR, 44);
                 chandata[i][3] = MYIMODE_mReadReg(TDC_BASEADDR, 48);
                 chandata[i][4] = MYIMODE_mReadReg(TDC_BASEADDR, 52);
                 chandata[i][5] = MYIMODE_mReadReg(TDC_BASEADDR, 56);
                 chandata[i][6] = MYIMODE_mReadReg(TDC_BASEADDR, 60);
                 chandata[i][7] = MYIMODE_mReadReg(TDC_BASEADDR, 64);
                 chandata[i][8] = MYIMODE_mReadReg(TDC_BASEADDR, 8);//tstart_counter
                 while(1){
                 	status = MYIMODE_mReadReg(TDC_BASEADDR, 0);//check stopDis, if it became 1, then the data can be read.
                     if(status == 0){
                         break;
                     }
                     usleep(1);
                 }
         }

        	for(i = 0; i<FIFO_SIZE; i+= 20){
        		xil_printf("%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\r\n",
        				chandata[i][0], chandata[i][1], chandata[i][2], chandata[i][3],
						chandata[i][4], chandata[i][5], chandata[i][6], chandata[i][7],chandata[i][8]);
        	}

    }
}
#endif
