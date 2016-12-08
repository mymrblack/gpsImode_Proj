/*
 * Copyright (c) 2009-2012 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "myImode.h"
#include "sleep.h"
#include "xparameters.h"	/* SDK generated parameters */
#include "xsdps.h"		/* SD device driver */
#include "xil_printf.h"
#include "ff.h"
#include "xil_cache.h"
#include "xplatform_info.h"


#define TDC_BASEADDR XPAR_MYIMODE_0_S00_AXI_BASEADDR
#define printf xil_printf
#define MyFileSize  30000     //  10min*60*5kHz
//#define BIN 82.3045

void TDC_config(void);
int FfsSdPolledExample(int *);

unsigned int chandata[MyFileSize][8]={{0,0,0,0,0,0,0,0}};
unsigned int abs_head;
unsigned int abs_i = 0;
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

#define TEST 7
/*****************************************************************************/
/**
*
* Main function to call the SD example.
*
* @param	None
*
* @return	XST_SUCCESS if successful, otherwise XST_FAILURE.
*
* @note		None
*
******************************************************************************/


int main()
{

	int Status;
	int *pchandata=chandata;

    int IrFlag;
    int ErrFlag;
    int EF1;
    int EF2;
    int r_data;
    int channel;
    int time;
    int start;
    int count=0;

    int reg;
    int i = 0;

    init_platform();
    print("Hello World\n\r");
    xil_printf("SD Polled File System Example Test \r\n");

    TDC_config();

    indexFile = 0;
flag:
    abs_head = -1;
    do
	 {

    	abs_i = MYIMODE_mReadReg(XPAR_MYIMODE_0_S00_AXI_BASEADDR, MYIMODE_S00_AXI_SLV_REG2_OFFSET);

    	if(abs_head == -1)
    		abs_head = abs_i;
    	i = abs_i - abs_head;


			 IrFlag = MYIMODE_mReadReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG8_OFFSET);
			 ErrFlag= MYIMODE_mReadReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG12_OFFSET);
			 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG3_OFFSET , 0x0c);
			 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x00);
			 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG2_OFFSET , 0x00);
			 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG2_OFFSET , 0x01);
			 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x01);
			 if(IrFlag == 1)
			 {
				 usleep(1);
				 printf("interrupt\n\r");
				 continue;
			 }
			 if(ErrFlag == 1)
			 {
				 usleep(1);
			     printf("error\n\r");
				 continue;
			 }

			 EF1 = MYIMODE_mReadReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG5_OFFSET);
			 EF2 = MYIMODE_mReadReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG6_OFFSET);

			if(EF1 == 0)
			{
				 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG3_OFFSET , 0x08);
				 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x00);
				 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG2_OFFSET , 0x00);
				 r_data= MYIMODE_mReadReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG4_OFFSET);
				 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG2_OFFSET , 0x01);
				 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x01);

				channel=((r_data & 0xC000000)>>26) + 1;
				time=(r_data & 0x1FFFF)-1242;//bylk
				reg = MYIMODE_mReadReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG20_OFFSET);

				switch(channel)
				{
					case 1:
						if((reg&1)|(time>121500))
							chandata[i][0]=-1;
						else
							chandata[i][0]=time;
						break;
					case 2:
						if(((reg>>1)&1)|(time>121500))
							chandata[i][1]=-1;
						else
							chandata[i][1]=time;
						break;
					case 3:
						if(((reg>>2)&1)|(time>121500))
							chandata[i][2]=-1;
						else
							chandata[i][2]=time;
						break;
					case 4:
						if(((reg>>3)&1)|(time>121500))
							chandata[i][3]=-1;
						else
							chandata[i][3]=time;
						break;
     			}
			}
			if(EF2 == 0)
			{
				 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG3_OFFSET , 0x09);
				 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x00);
				 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG2_OFFSET , 0x00);
				 r_data= MYIMODE_mReadReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG4_OFFSET);
				 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG2_OFFSET , 0x01);
				 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x01);
				channel=((r_data & 0xC000000)>>26) + 5;
				time=(r_data & 0x1FFFF)-1242;//bylk
				reg = MYIMODE_mReadReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG20_OFFSET);
				switch(channel)
				{
					case 5:
						if(((reg>>4)&1)|(time>121500))
							chandata[i][4]=-1;
						else
							chandata[i][4]=time;
						break;
					case 6:
						if(((reg>>5)&1)|(time>121500))
							chandata[i][5]=-1;
						else
							chandata[i][5]=time;
						break;
					case 7:
						if(((reg>>6)&1)|(time>121500))
							chandata[i][6]=-1;
						else
							chandata[i][6]=time;
						break;
					case 8:
						if(((reg>>7)&1)|(time>121500))
							chandata[i][7]=-1;
						else
							chandata[i][7]=time;
						break;
				}
			}
          count=count+1;
         if(count==100)
          {
             MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG3_OFFSET , 0x04);
           	 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x00);
           	 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x00);
           	 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG4_OFFSET , 0x6400000);//bylk
           	 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x01);
           	 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x01);

           	 count=0;

          }
	 }while(abs_i-abs_head<MyFileSize);

      int j;
    	for(j=0;j<MyFileSize;j=j+300)
    	{
    		printf("%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\r\n",
    				chandata[j][0],chandata[j][1],
					chandata[j][2],chandata[j][3],
					chandata[j][4],chandata[j][5],
					chandata[j][6],chandata[j][7]);
    	}
		Status = FfsSdPolledExample(pchandata);//bylk
		if (Status != XST_SUCCESS) {
			xil_printf("SD Polled File System Example Test failed \r\n");
			return XST_FAILURE;
		}

		xil_printf("Successfully ran SD Polled File System Example Test \r\n");
		goto flag;
    return 0;

}

void TDC_config(void)
{
	MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x01);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x01);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG2_OFFSET , 0x01);


	    MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG7_OFFSET , 0x1F);
		//Disable inputs

		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG3_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG4_OFFSET , 0x007FC81);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x01);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x01);


		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG3_OFFSET , 0x01);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG4_OFFSET , 0x0000000);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x01);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x01);


		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG3_OFFSET , 0x02);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG4_OFFSET , 0x0000002);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x01);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x01);

		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG3_OFFSET , 0x03);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG4_OFFSET , 0x0000000);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x01);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x01);

		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG3_OFFSET , 0x04);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG4_OFFSET , 0x6000000);//bylk
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x01);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x01);

		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG3_OFFSET , 0x05);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG4_OFFSET , 0x0E004DA);//bylk
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x01);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x01);

		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG3_OFFSET , 0x06);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG4_OFFSET , 0x0000000);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x01);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x01);

		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG3_OFFSET , 0x07);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG4_OFFSET , 0x0281FB4);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x01);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x01);

		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG3_OFFSET , 0x0b);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG4_OFFSET , 0x7FF0000);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x01);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x01);

		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG3_OFFSET , 0x0c);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG4_OFFSET , 0x0000000);//last
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x01);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x01);

		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG3_OFFSET , 0x0e);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG4_OFFSET , 0x0000000);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x01);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x01);

		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG3_OFFSET , 0x04);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x00);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG4_OFFSET , 0x6400000);//bylk
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG1_OFFSET , 0x01);
		 MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x01);

		  MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG7_OFFSET , 0x00);

		  MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG3_OFFSET , 0x0a);
		  MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x00);
		  MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG2_OFFSET , 0x00);

		  MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG2_OFFSET , 0x01);
		  MYIMODE_mWriteReg(TDC_BASEADDR,  MYIMODE_S00_AXI_SLV_REG0_OFFSET , 0x01);
		 //Enable inputs

}



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
//int FfsSdPolledExample(int *chandata)
int FfsSdPolledExample(int *pchandata)
{
	FRESULT Res;
	UINT NumBytesWritten;
	u32 BuffCnt;
	u32 FileSize = (10*1024*1024);
	TCHAR *Path = "0:/";
	unsigned int i=0,j=0;
	unsigned int count_per_page = FileSize / 72;
	unsigned int count_page = 0;
	Res = f_mount(&fatfs, Path, 0);

	if (Res != FR_OK) {
		return XST_FAILURE;
	}

	sprintf(FileName, "data%d.bin", indexFile++);
	SD_File = (char *)FileName;

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
		sprintf(SourceAddress + count_page * 72, "%8d\t%8d\t%8d\t%8d\t%8d\t%8d\t%8d\t%8d\n",
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
