/*
 * SD_Card.c
 *
 *  Created on: 2016��11��12��
 *      Author: lin.zheng
 */

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
#include "SD_Card.h"
#include "GPS.h"


/*****************************************************************************/
/**
*
* File system example using SD driver to write to and read from an SD card
* in polled mode. This example creates a new file on an
* SD card (which is previously formatted with FATFS), write data to the file
* and reads the same data back to verify.
*
* @param	None
*
* @return	XST_SUCCESS if successful, otherwise XST_FAILURE.
*
* @note		None
*
******************************************************************************/


int FfsSdPolledExample(int *pchandata, Time_Data *timeData, TCHAR *Path)
{
	FRESULT Res;
	UINT NumBytesWritten;
	u32 BuffCnt;
	u32 FileSize = (10*1024*1024);
	char FileName[256] = "0";
//	TCHAR *Path = "0:/";
	unsigned int i=1,j=0;
	unsigned int count_per_page = FileSize / 100;
	unsigned int count_page = 0;

	Res = f_mount(&fatfs, Path, 0);
	if (Res != FR_OK) {
		return XST_FAILURE;
	}

	sprintf(FileName, "/data%d.bin", indexFile++);
	strcpy(SD_File, Path);
	strcat(SD_File, FileName);

	Res = f_open(&fil, SD_File, FA_CREATE_ALWAYS | FA_WRITE | FA_READ);
	if (Res) {
		return XST_FAILURE;
	}

	Res = f_lseek(&fil, 0);
	if (Res) {
		return XST_FAILURE;
	}

	for(BuffCnt = 0; BuffCnt < FileSize; BuffCnt++){
		SourceAddress[BuffCnt] =  0;
	}

	do{
		if((*(pchandata+8*i+0))==0&&(*(pchandata+8*i+1)==0)&&
		   (*(pchandata+8*i+2))==0&&(*(pchandata+8*i+3)==0)&&
		   (*(pchandata+8*i+4))==0&&(*(pchandata+8*i+5)==0)&&
		   (*(pchandata+8*i+6))==0&&(*(pchandata+8*i+7)==0))
			{
				j++;
				i++;
				continue;
			}
   		GPS_timeDataDecode(timeData+i);
		sprintf(SourceAddress + count_page * 100,
				"%4d/%2d/%2d\t%2d:%2d:%2d:%3d:%3d\t%8d\t%8d\t%8d\t%8d\t%8d\t%8d\t%8d\t%8d\n",
				(timeData+i)->year,(timeData+i)->month,(timeData+i)->day,
				(timeData+i)->hour,(timeData+i)->minute,(timeData+i)->second,
				(timeData+i)->millisec,(timeData+i)->microsec,
				*(pchandata+8*i+0),*(pchandata+8*i+1),*(pchandata+8*i+2),*(pchandata+8*i+3),
				*(pchandata+8*i+4),*(pchandata+8*i+5),*(pchandata+8*i+6),*(pchandata+8*i+7));
		i++;
		count_page++;
		if(count_page == count_per_page)
		{
			count_page = 0;

			Res = f_write(&fil, (const void*)SourceAddress, strlen(SourceAddress),&NumBytesWritten);
			printf("%d\r\n", strlen(SourceAddress));
			for(BuffCnt = 0; BuffCnt < FileSize; BuffCnt++){
				SourceAddress[BuffCnt] =  0;
			}
		}
	}while(i < MyFileSize);

	if(strlen(SourceAddress) != 0)
	{
		Res = f_write(&fil, (const void*)SourceAddress, strlen(SourceAddress),&NumBytesWritten);
		printf("%d\r\n", strlen(SourceAddress));
	}

	Res = f_close(&fil);
	printf("%d\r\n", j);
	if (Res) {
		return XST_FAILURE;
	}
	return XST_SUCCESS;

}

#define DIR_NAME_FORMAT "0:%d-%d-%d-%dh%dm%ds"
FRESULT Ffs_Init(TCHAR *Path){
	FRESULT Res;

	Time_Data GpsDataFromFpga={0};

	Gps_GetRealTime(&GpsDataFromFpga);

	sprintf(Path, DIR_NAME_FORMAT,
			GpsDataFromFpga.year, GpsDataFromFpga.month,
			GpsDataFromFpga.day, GpsDataFromFpga.hour,
			GpsDataFromFpga.minute, GpsDataFromFpga.second);

	Res = f_mount(&fatfs, Path, 0);
	if (Res != FR_OK) {
		xil_printf("f_mount XST_FAILURE\n");
		return XST_FAILURE;
	}

	Res = f_mkdir(Path);
	if (Res != FR_OK) {
		xil_printf("f_mkdir XST_FAILURE\n");
		xil_printf("%d\n", Res);
		return XST_FAILURE;
	}
	xil_printf("XST_SUCCESS\n");
	return XST_SUCCESS;
}
#define FILE_NAME_FORMAT "/data%d.xls"
#define BYTES_EACH_LINE 100
int Ffs_Try(TCHAR *Path)
{
	FRESULT Res;
	UINT NumBytesWritten;
	u32 BuffCnt;
	u32 FileSize = (10*1024*1024);
	char FileName[32] = "0";
	char FilePath[256] = "0";
	unsigned int i=1,j=0;
	unsigned int count_per_page = FileSize / BYTES_EACH_LINE;
	unsigned int count_page = 0;

	Res = f_mount(&fatfs, Path, 0);
	if (Res != FR_OK) {
		return XST_FAILURE;
	}

	sprintf(FileName, FILE_NAME_FORMAT, indexFile++);
	strcpy(FilePath, Path);
	strcat(FilePath, FileName);

	Res = f_open(&fil, FilePath, FA_CREATE_NEW| FA_OPEN_ALWAYS | FA_WRITE | FA_READ);
	if (Res) {
		return XST_FAILURE;
	}



	for(BuffCnt = 0; BuffCnt < FileSize; BuffCnt++){
			SourceAddress[BuffCnt] =  0;
	}

	do{
		Res = f_lseek(&fil, count_page * BYTES_EACH_LINE);
		if (Res) {
			xil_printf("f_lseek: %d\n", Res);
			return XST_FAILURE;
		}

		sprintf(SourceAddress,
				"%4d/%2d/%2d\t%2d:%2d:%2d:%3d:%3d\t%8d\t%8d\t%8d\t%8d\t%8d\t%8d\t%8d\t%8d\n",
				2016,12,13,
				20,31,0,
				0,0,
				count_page,2,3,4,
				5,6,7,8);
		Res = f_write(&fil, (const void*)SourceAddress, BYTES_EACH_LINE,&NumBytesWritten);
		count_page++;
		if (Res) {
			xil_printf("f_write: %d\n", Res);
			return XST_FAILURE;
		}
		for(BuffCnt = 0; BuffCnt < BYTES_EACH_LINE; BuffCnt++){
		SourceAddress[BuffCnt] =  0;
	}

	}while(count_page < count_per_page);


	Res = f_close(&fil);
	printf("%d\r\n", j);
	if (Res) {
		return XST_FAILURE;
	}
	return XST_SUCCESS;
}
