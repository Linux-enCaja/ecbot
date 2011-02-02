#ifndef PNGWRITER_H
#define PNGWRITER_H 1

#define PNGWRITER_VERSION 0.53

#include <png.h>

#include <iostream>
#include <cmath>
#include <cwchar>
#include <string>
#include <stdlib.h>
#include <stdio.h>
#include <setjmp.h>


#define PNG_BYTES_TO_CHECK (4)
#define PNGWRITER_DEFAULT_COMPRESSION (6)

class pngwriter 
{
 private:
   
   char * filename_;   
   char * textauthor_;   
   char * textdescription_;   
   char * texttitle_;   
   char * textsoftware_;   


   
   int height_;
   int width_;
   int  backgroundcolour_;
   int bit_depth_;
   int rowbytes_;
   int colortype_;
   int compressionlevel_;
   unsigned char * * graph_;
   double filegamma_;
   double screengamma_;
   void circle_aux(int xcentre, int ycentre, int x, int y, int red, int green, int blue);
   int check_if_png(char *file_name, FILE **fp);
   int read_png_info(FILE *fp, png_structp *png_ptr, png_infop *info_ptr);
   int read_png_image(FILE *fp, png_structp png_ptr, png_infop info_ptr,
 		       png_bytepp *image, png_uint_32 *width, png_uint_32 *height);

 public:

   pngwriter(int width, int height, int backgroundcolour, char * filename);   
   ~pngwriter();  

   void plot(int x, int y, unsigned char red, unsigned char green, unsigned char  blue); 
   void clear(void);    
   
   void close(void); 

   void pngwriter_rename(char * newname);               
   void pngwriter_rename(const char * newname);            
   void pngwriter_rename(long unsigned int index);            

   /* Figures */
   void line(int xfrom, int yfrom, int xto, int yto, unsigned char red, unsigned char green,unsigned char  blue);
   void square(int xfrom, int yfrom, int xto, int yto, int red, int green,int  blue);
   void circle(int xcentre, int ycentre, int radius, int red, int green, int blue);

   int getheight(void);
   int getwidth(void);

   void setcompressionlevel(int level);

   int getbitdepth(void);
   int getcolortype(void);
   void setgamma(double gamma);
   double getgamma(void);

   static double version(void);

   void write_png(void);
   void invert(void);
};


#endif

