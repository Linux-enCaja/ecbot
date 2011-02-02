#ifndef	CONVERT_H
#define	CONVERT_H

typedef struct _YCbYCr
{
	unsigned char Y0;
	unsigned char Cb0;
	unsigned char Y1;
	unsigned char Cr1;
} YCbYCr;

typedef struct _RGB
{
	unsigned char R;
	unsigned char G;
	unsigned char B;
} RGB;

void YCbCr2RGB( unsigned char Y, unsigned char Cb, unsigned char Cr, RGB* rgb);

void YCbYCr2RGB( YCbYCr* ybyr, RGB* rgb);

#endif
