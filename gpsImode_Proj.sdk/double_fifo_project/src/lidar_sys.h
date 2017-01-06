/*
 * lidar_sys.h
 *
 *  Created on: 2017Äê1ÔÂ5ÈÕ
 *      Author: Lin
 */
#include "ff.h"
#ifndef SRC_LIDAR_SYS_H_
#define SRC_LIDAR_SYS_H_

#define IMODE 1
#define FIFO_SIZE           8192
#ifdef IMODE
#define DATA_WORDS	11
#else
#define DATA_WORDS	5
#endif

#ifdef IMODE
typedef	struct{
	int ch1;
	int ch2;
	int ch3;
	int ch4;
	int ch5;
	int ch6;
	int ch7;
	int ch8;
	unsigned int gps1;
	unsigned int gps2;
	unsigned int triTimes;
}Lidar_Data;
#else
typedef	struct{
	int ch1;
	int ch2;
	unsigned int gps1;
	unsigned int gps2;
	unsigned int triTimes;
} Lidar_Data;
#endif

void LidarSystemInitial(TCHAR *dirPath);

#endif /* SRC_LIDAR_SYS_H_ */
