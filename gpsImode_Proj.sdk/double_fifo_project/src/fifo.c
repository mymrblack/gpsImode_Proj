
#include <stdio.h>
#include "sleep.h"
#include "xsdps.h"
#include "xil_printf.h"
#include "fifo.h"


void FIFO_rst(void){
    FIFO_mWriteReg(FIFO_BASEADDR, FIFO_CTRL_REG_OFFSET, FIFO_RST);
    FIFO_mWriteReg(FIFO_BASEADDR, FIFO_CTRL_REG_OFFSET, FIFO_CTRL_CLEAR);
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
void FIFO_test(Lidar_Data *data){
    int i;
    int fifoNum;
    print("Hello World\n\r");
    xil_printf("FIFO System Example Test \r\n");
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
            FIFO_getData(&data[i], fifoNum);
        }
        xil_printf("%d\r\n", fifoNum);
        FIFO_printData(data, FIFO_SIZE, 300);
    }
}

void FIFO_printData(Lidar_Data *data, int range, int step){
    int i;
    #ifdef IMODE
    for(i = 0; i < range; i+= step){
        xil_printf("%d\tgps1:%d\tgps2:%d\tch1:%d\tch2:%d\tch3:%d\tch4:%d\tch5:%d\tch6:%d\tch7:%d\tch8:%d\r\n",
        		(&data[i])->triTimes, (&data[i])->gps1, (&data[i])->gps2,
				(&data[i])->ch1, (&data[i])->ch2, (&data[i])->ch3,
				(&data[i])->ch4, (&data[i])->ch5, (&data[i])->ch6,
				(&data[i])->ch7, (&data[i])->ch8);
    }
    #else
    for(i = 0; i < range; i+= step){
        xil_printf("%d\tgps1:%d\tgps2:%d\tch1:%d\tch2:%d\r\n",
        		(&data[i])->triTimes, (&data[i])->gps1, (&data[i])->gps2,
        		(&data[i])->ch1, (&data[i])->ch2);
    }
    #endif
}

int WaitUntilFifoIsFull(void){
    int fifoNum;
    while(1){
        fifoNum = FIFO_checkFifoStatus();
        if(fifoNum != 0){
            break;
        }
        usleep(1);
    }
    return fifoNum;
}
