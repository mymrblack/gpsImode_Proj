/*
 * lidar_sys.c
 *
 *  Created on: 2017Äê1ÔÂ5ÈÕ
 *      Author: Lin
 */
#include "lidar_sys.h"
#include <stdio.h>
#include "platform.h"
#include "sleep.h"
#include "xsdps.h"
#include "xil_printf.h"
#include "fifo.h"
#include "tdc.h"
#include "GPS.h"
#include "SD_card.h"

Lidar_Data lidarData[FIFO_SIZE] = {{0}};

void LidarSystemInitial(TCHAR *dirPath){
    print("Hello World\n\r");
    xil_printf("GPS and FIFO and SD System Example Test \r\n");

    xil_printf("Waiting for GPS initial.. \r\n");
	Gps_Init();
    xil_printf("GPS initialed.  \r\n");
    Gps_FuncTest();

    xil_printf("Waiting for FFS initial.. \r\n");
    Ffs_Init(dirPath); //this take a long time, so it was set in initial.
    xil_printf("FFS initialed.  \r\n");
    xil_printf("dirPath is : %s\r\n", dirPath);

    FIFO_rst();
    xil_printf("Now you can turn your trigger system.  \r\n");

}
