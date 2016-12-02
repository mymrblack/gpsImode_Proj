/*
 * SD_Card.h
 *
 *  Created on: 2016Äê11ÔÂ12ÈÕ
 *      Author: lin.zheng
 */

#ifndef SRC_SD_CARD_H_
#define SRC_SD_CARD_H_


#define MyFileSize  30000     //  10min*60*5kHz

int indexFile;

/************************** Variable Definitions *****************************/
static FIL fil;		/* File object */
static FATFS fatfs;
static char FileName[32] = "data.bin";
static char *SD_File;
u32 Platform;

#ifdef __ICCARM__
#pragma data_alignment = 32
u8 DestinationAddress[10*1024*1024];
u8 SourceAddress[10*1024*1024];
#pragma data_alignment = 4
#else
u8 DestinationAddress[10*1024*1024] __attribute__ ((aligned(32)));
u8 SourceAddress[10*1024*1024] __attribute__ ((aligned(32)));
#endif



int FfsSdPolledExample(int *);




#endif /* SRC_SD_CARD_H_ */
