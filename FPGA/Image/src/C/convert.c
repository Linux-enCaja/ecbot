#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>

#include "convert.h"


void YCbCr2RGB( unsigned char Y, unsigned char Cb, unsigned char Cr, RGB* rgb)
{
	float calcR = Y + 1.371f * (Cr - 128);
	float calcG = Y - 0.698f * (Cr - 128) - 0.336 * (Cb - 128);
	float calcB = Y + 1.732f * (Cb - 128);

	if (calcR < 0) calcR = 0;
	if (calcG < 0) calcG = 0;
	if (calcB < 0) calcB = 0;

	rgb->R = ((int)calcR) & 0xFF;
	rgb->G = ((int)calcG) & 0xFF;
	rgb->B = ((int)calcB) & 0xFF;
}

void YCbYCr2RGB( YCbYCr* ybyr, RGB* rgb)
{
	YCbCr2RGB( ybyr->Y0, ybyr->Cb0, ybyr->Cr1, &rgb[0] );
	YCbCr2RGB( ybyr->Y1, ybyr->Cb0, ybyr->Cr1, &rgb[1] );
}


