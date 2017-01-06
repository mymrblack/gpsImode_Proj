#include "fifo.h"
#include <stdio.h>
#include "platform.h"
#include "sleep.h"
#include "xparameters.h"	/* SDK generated parameters */
#include "xsdps.h"		/* SD device driver */
#include "xil_printf.h"
#include "ff.h"
#include "xil_cache.h"
#include "xplatform_info.h"

#include "tdc.h"

void FIFO_rst(void){
    FIFO_mWriteReg(FIFO_BASEADDR, FIFO_CTRL_REG_OFFSET, FIFO_RST);
    FIFO_mWriteReg(FIFO_BASEADDR, FIFO_CTRL_REG_OFFSET, FIFO_CTRL_CLEAR);
}

unsigned int chandata[FIFO_SIZE][11]={{0,0,0,0,0,0,0,0,0}};
void TdcTimeDataAllocate_test(void){
    int i;
    int status = 0;

    FIFO_rst();

    xil_printf("Tstart status :%d\r\n", FIFO_mReadReg(TDC_BASEADDR, 8));
    while(1){

        for(i = 0; i < FIFO_SIZE; i++){
            while(1){
            	status = FIFO_mReadReg(TDC_BASEADDR, 0);//check stopDis, if it became 1, then the data can be read.
                if(status != 0){
                    usleep(11);
                    break;
                }
                usleep(1);
            }
                 chandata[i][0] = FIFO_mReadReg(TDC_BASEADDR, 36);
                 chandata[i][1] = FIFO_mReadReg(TDC_BASEADDR, 40);
                 chandata[i][2] = FIFO_mReadReg(TDC_BASEADDR, 44);
                 chandata[i][3] = FIFO_mReadReg(TDC_BASEADDR, 48);
                 chandata[i][4] = FIFO_mReadReg(TDC_BASEADDR, 52);
                 chandata[i][5] = FIFO_mReadReg(TDC_BASEADDR, 56);
                 chandata[i][6] = FIFO_mReadReg(TDC_BASEADDR, 60);
                 chandata[i][7] = FIFO_mReadReg(TDC_BASEADDR, 64);
                 chandata[i][8] = FIFO_mReadReg(TDC_BASEADDR, 8);//tstart_counter
                 while(1){
                 	status = FIFO_mReadReg(TDC_BASEADDR, 0);//check stopDis, if it became 1, then the data can be read.
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

int FIFO_checkFifoStatus(void){
    int res = 0;
    int status;
    status = FIFO_mReadReg(FIFO_BASEADDR, FIFO_FLAG_REG_OFFSET);
    if((status & 0x8) >> 3 == 1){
        res = 2;
    }
    else if((status & 0x2) >> 1 == 1){
        res = 1;
    }
    else{
        res = 0;
    }
    return res;
}

void FIFO_getData(Lidar_Data *data, int fifoNum){
    if(fifoNum == 1){
        FIFO_mWriteReg(FIFO_BASEADDR, FIFO_CTRL_REG_OFFSET, FIFO1_RD);
        data->ch1 = FIFO_mReadReg(FIFO_BASEADDR, FIFO1_CH1_DATA_REG);
        data->ch2 = FIFO_mReadReg(FIFO_BASEADDR, FIFO1_CH2_DATA_REG);
        #ifdef IMODE
        data->ch3 = FIFO_mReadReg(FIFO_BASEADDR, FIFO1_CH3_DATA_REG);
        data->ch4 = FIFO_mReadReg(FIFO_BASEADDR, FIFO1_CH4_DATA_REG);
        data->ch5 = FIFO_mReadReg(FIFO_BASEADDR, FIFO1_CH5_DATA_REG);
        data->ch6 = FIFO_mReadReg(FIFO_BASEADDR, FIFO1_CH6_DATA_REG);
        data->ch7 = FIFO_mReadReg(FIFO_BASEADDR, FIFO1_CH7_DATA_REG);
        data->ch8 = FIFO_mReadReg(FIFO_BASEADDR, FIFO1_CH8_DATA_REG);
        #endif
        data->gps1 = FIFO_mReadReg(FIFO_BASEADDR, FIFO1_GPS1_DATA_REG);
        data->gps2 = FIFO_mReadReg(FIFO_BASEADDR, FIFO1_GPS2_DATA_REG);
        data->triTimes = FIFO_mReadReg(FIFO_BASEADDR, FIFO1_START_TRI_DATA_REG);
        FIFO_mWriteReg(FIFO_BASEADDR, FIFO_CTRL_REG_OFFSET, FIFO_CTRL_CLEAR);
    }
    else if(fifoNum == 2){
        FIFO_mWriteReg(FIFO_BASEADDR, FIFO_CTRL_REG_OFFSET, FIFO2_RD);
        data->ch1 = FIFO_mReadReg(FIFO_BASEADDR, FIFO2_CH1_DATA_REG);
        data->ch2 = FIFO_mReadReg(FIFO_BASEADDR, FIFO2_CH2_DATA_REG);
        #ifdef IMODE
        data->ch3 = FIFO_mReadReg(FIFO_BASEADDR, FIFO2_CH3_DATA_REG);
        data->ch4 = FIFO_mReadReg(FIFO_BASEADDR, FIFO2_CH4_DATA_REG);
        data->ch5 = FIFO_mReadReg(FIFO_BASEADDR, FIFO2_CH5_DATA_REG);
        data->ch6 = FIFO_mReadReg(FIFO_BASEADDR, FIFO2_CH6_DATA_REG);
        data->ch7 = FIFO_mReadReg(FIFO_BASEADDR, FIFO2_CH7_DATA_REG);
        data->ch8 = FIFO_mReadReg(FIFO_BASEADDR, FIFO2_CH8_DATA_REG);
        #endif
        data->gps1 = FIFO_mReadReg(FIFO_BASEADDR, FIFO2_GPS1_DATA_REG);
        data->gps2 = FIFO_mReadReg(FIFO_BASEADDR, FIFO2_GPS2_DATA_REG);
        data->triTimes = FIFO_mReadReg(FIFO_BASEADDR, FIFO2_START_TRI_DATA_REG);
        FIFO_mWriteReg(FIFO_BASEADDR, FIFO_CTRL_REG_OFFSET, FIFO_CTRL_CLEAR);
    }
    else{
        xil_printf("Wrong Fifo Number!\r\n");
    }
}
void FIFO_test(void){
    int i;
    int fifoNum;

    FIFO_rst();

    while(1){
        while(1){
            fifoNum = FIFO_checkFifoStatus();
            if(fifoNum != 0){
                break;
            }
            usleep(1);
        }

        for(i = 0; i < FIFO_SIZE; i++){
            FIFO_getData(&lidarData[i], fifoNum);
        }
        xil_printf("%d\r\n", fifoNum);
        FIFO_printData(FIFO_SIZE, 300);
    }
}

void FIFO_printData(int range, int step){
    int i;
    #ifdef IMODE
    for(i = 0; i < range; i+= step){
        xil_printf("%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\r\n",
                lidarData[i].triTimes, lidarData[i].gps1, lidarData[i].gps2, 
                lidarData[i].ch1, lidarData[i].ch2, lidarData[i].ch3,
                lidarData[i].ch4, lidarData[i].ch5, lidarData[i].ch6, 
                lidarData[i].ch7, lidarData[i].ch8);
    }
    #else
    for(i = 0; i < range; i+= step){
        xil_printf("%d\t%d\t%d\t%d\t%d\r\n",
                lidarData[i].triTimes, lidarData[i].gps1, lidarData[i].gps2, 
                lidarData[i].ch1, lidarData[i].ch2);
    }
    #endif
}
