#include "pngwriter.h"

//Constructor for int colour levels, char * filename
//////////////////////////////////////////////////////////////////////////
pngwriter::pngwriter(int x, int y, int backgroundcolour, char * filename)
{
   width_            = x;
   height_           = y;
   backgroundcolour_ = backgroundcolour;
   compressionlevel_ = 0;
   filegamma_        = 0.8;

   textauthor_      = new char[255];
   textdescription_ = new char[255];
   texttitle_       = new char[strlen(filename)+1];
   textsoftware_    = new char[255];
   filename_        = new char[strlen(filename)+1];

   strcpy(textauthor_, "Carlos Camargo");
   strcpy(textdescription_, "ECBot image");
   strcpy(textsoftware_, "");
   strcpy(texttitle_, filename);
   strcpy(filename_, filename);

   if((width_<0)||(height_<0)){
	   width_ = 1;
	   height_ = 1;
   }

   int kkkk;

   bit_depth_   = 8;
   colortype_   = 2;
   screengamma_ = 2.2;

   graph_ = (png_bytepp)malloc(height_ * sizeof(png_bytep));
   if(graph_ == NULL){
	   std::cerr << " PNGwriter::pngwriter - ERROR **:  Not able to allocate memory for image." << std::endl;
   }

   for (kkkk = 0; kkkk < height_; kkkk++){
     graph_[kkkk] = (png_bytep)malloc(3*width_ * sizeof(png_byte));
	   if(graph_[kkkk] == NULL){
	     std::cerr << " PNGwriter::pngwriter - ERROR **:  Not able to allocate memory for image." << std::endl;
	   }
   }

   if(graph_ == NULL){
	   std::cerr << " PNGwriter::pngwriter - ERROR **:  Not able to allocate memory for image." << std::endl;
   }
};
//Destructor
///////////////////////////////////////
pngwriter::~pngwriter()
{
   delete [] filename_;
   delete [] textauthor_;
   delete [] textdescription_;
   delete [] texttitle_;
   delete [] textsoftware_;

   for (int jjj = 0; jjj < height_; jjj++) free(graph_[jjj]);
   free(graph_);
};


void pngwriter::plot(int x, int y, unsigned char red, unsigned char green, unsigned char blue)
{
   int tempindex;

   if((bit_depth_ == 8)){
	  if( (y<height_+1) && (y>0) && (x>0) && (x<width_+1) ){
	     tempindex= 3*x-3;
	     graph_[height_-y][tempindex]   = red;
	     graph_[height_-y][tempindex+1] = green;
	     graph_[height_-y][tempindex+2] = blue;
	  };
  }
};

///////////////////////////////////////////////////////
void pngwriter::clear()
{
   int pen = 0;
   int pencil = 0;
   int tempindex;

   if(bit_depth_==16)
     {
	for(pen = 0; pen<width_;pen++)
	  {
	     for(pencil = 0; pencil<height_;pencil++)
	       {
		  tempindex=6*pen;
		  graph_[pencil][tempindex] = 0;
		  graph_[pencil][tempindex+1] = 0;
		  graph_[pencil][tempindex+2] = 0;
		  graph_[pencil][tempindex+3] = 0;
		  graph_[pencil][tempindex+4] = 0;
		  graph_[pencil][tempindex+5] = 0;
	       }
	  }
     }

   if(bit_depth_==8)
     {
	for(pen = 0; pen<width_;pen++)
	  {
	     for(pencil = 0; pencil<height_;pencil++)
	       {
		  tempindex=3*pen;
		  graph_[pencil][tempindex] = 0;
		  graph_[pencil][tempindex+1] = 0;
		  graph_[pencil][tempindex+2] = 0;
	       }
	  }
     }

};

/////////////////////////////////////////////////////
void pngwriter::pngwriter_rename(char * newname)
{
   delete [] filename_;
   delete [] texttitle_;

   filename_ = new char[strlen(newname)+1];
   texttitle_ = new char[strlen(newname)+1];

   strcpy(filename_,newname);
   strcpy(texttitle_,newname);
};

///////////////////////////////////////////////////////
void pngwriter::pngwriter_rename(const char * newname)
{
   delete [] filename_;
   delete [] texttitle_;

   filename_ = new char[strlen(newname)+1];
   texttitle_ = new char[strlen(newname)+1];

   strcpy(filename_,newname);
   strcpy(texttitle_,newname);
};

///////////////////////////////////////////////////////
void pngwriter::pngwriter_rename(long unsigned int index)
{
   char buffer[255];

   //   %[flags][width][.precision][modifiers]type
   //
   if((index > 999999999)||(index < 0))
     {
	std::cerr << " PNGwriter::pngwriter_rename - ERROR **: Numerical name is out of 0 - 999 999 999 range (" << index <<")." << std::endl;
	return;
     }

   if( 0>  sprintf(buffer, "%9.9lu.png",index))
     {
	std::cerr << " PNGwriter::pngwriter_rename - ERROR **: Error creating numerical filename." << std::endl;
	return;
     }

   delete [] filename_;
   delete [] texttitle_;

   filename_ = new char[strlen(buffer)+1];
   texttitle_ = new char[strlen(buffer)+1];

   strcpy(filename_,buffer);
   strcpy(texttitle_,buffer);

};
///////////////////////////////////////////////////////
void pngwriter::close()
{
   FILE            *fp;
   png_structp     png_ptr;
   png_infop       info_ptr;

   fp = fopen(filename_, "wb");
   if( fp == NULL){
	    std::cerr << " PNGwriter::close - ERROR **: Error creating file (fopen() returned NULL pointer)." << std::endl;
	    perror(" PNGwriter::close - ERROR **");
	    return;
   }

   png_ptr = png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
   info_ptr = png_create_info_struct(png_ptr);
   png_init_io(png_ptr, fp);
   png_set_filter(png_ptr, 0, PNG_FILTER_NONE);

   if(compressionlevel_ != -2){
	  png_set_compression_level(png_ptr, compressionlevel_);
   }
   else{
	   png_set_compression_level(png_ptr, PNGWRITER_DEFAULT_COMPRESSION);
   }

   png_set_IHDR(png_ptr, info_ptr, width_, height_,
	 bit_depth_, PNG_COLOR_TYPE_RGB, PNG_INTERLACE_NONE,
   PNG_COMPRESSION_TYPE_DEFAULT, PNG_FILTER_TYPE_DEFAULT);

   if(filegamma_ < 0.1){
	   filegamma_ = 0.8;
   }

   png_set_gAMA(png_ptr, info_ptr, filegamma_);

   time_t          gmt;
   png_time        mod_time;
   png_text        text_ptr[5];
   time(&gmt);
   png_convert_from_time_t(&mod_time, gmt);
   png_set_tIME(png_ptr, info_ptr, &mod_time);
   text_ptr[0].key = "Title";
   text_ptr[0].text = texttitle_;
   text_ptr[0].compression = PNG_TEXT_COMPRESSION_NONE;
   text_ptr[1].key = "Author";
   text_ptr[1].text = textauthor_;
   text_ptr[1].compression = PNG_TEXT_COMPRESSION_NONE;
   text_ptr[2].key = "Description";
   text_ptr[2].text = textdescription_;
   text_ptr[2].compression = PNG_TEXT_COMPRESSION_NONE;
   text_ptr[3].key = "Creation Time";
   text_ptr[3].text = png_convert_to_rfc1123(png_ptr, &mod_time);
   text_ptr[3].compression = PNG_TEXT_COMPRESSION_NONE;
   text_ptr[4].key = "Software";
   text_ptr[4].text = textsoftware_;
   text_ptr[4].compression = PNG_TEXT_COMPRESSION_NONE;
   png_set_text(png_ptr, info_ptr, text_ptr, 5);

   png_write_info(png_ptr, info_ptr);
   png_write_image(png_ptr, graph_);
   png_write_end(png_ptr, info_ptr);
   png_destroy_write_struct(&png_ptr, &info_ptr);
   fclose(fp);
}

//////////////////////////////////////////////////////
void pngwriter::line(int xfrom, int yfrom, int xto, int yto, unsigned char red, unsigned char green, unsigned char  blue)
{
   //  Bresenham Algorithm.
   //
   int dy = yto - yfrom;
   int dx = xto - xfrom;
   int stepx, stepy;

   if (dy < 0){
     dy = -dy;  stepy = -1;}
   else
	   stepy = 1;

   if (dx < 0){
	   dx = -dx;  stepx = -1;}
   else
	  stepx = 1;

   dy <<= 1;     // dy is now 2*dy
   dx <<= 1;     // dx is now 2*dx

   this->plot(xfrom,yfrom,red,green,blue);

   if (dx > dy) {
	   int fraction = dy - (dx >> 1);

	   while (xfrom != xto){
	     if (fraction >= 0){
		     yfrom += stepy;
		     fraction -= dx;
	     }
	     xfrom += stepx;
	     fraction += dy;
	     this->plot(xfrom,yfrom,red,green,blue);
	   }
   }
   else{
	   int fraction = dx - (dy >> 1);
	   while (yfrom != yto){
	     if (fraction >= 0){
		     xfrom += stepx;
		     fraction -= dy;
	     }
	     yfrom += stepy;
	     fraction += dx;
	     this->plot(xfrom,yfrom,red,green,blue);
	   }
   }
}

///////////////////////////////////////////////////////////////////////////////////////////
void pngwriter::square(int xfrom, int yfrom, int xto, int yto, int red, int green, int blue)
{
   this->line(xfrom, yfrom, xfrom, yto, red, green, blue);
   this->line(xto, yfrom, xto, yto, red, green, blue);
   this->line(xfrom, yfrom, xto, yfrom, red, green, blue);
   this->line(xfrom, yto, xto, yto, red, green, blue);
}

//////////////////////////////////////////////////////////////////////////////////////////////////
void pngwriter::circle(int xcentre, int ycentre, int radius, int red, int green, int blue)
{
   int x = 0;
   int y = radius;
   int p = (5 - radius*4)/4;

   circle_aux(xcentre, ycentre, x, y, red, green, blue);
   while (x < y){
	   x++;
	   if (p < 0)
	     p += 2*x+1;
	   else{
	     y--;
	     p += 2*(x-y)+1;
	   }
	   circle_aux(xcentre, ycentre, x, y, red, green, blue);
   }
}

////////////////////////////////////////////////////////////

void pngwriter::circle_aux(int xcentre, int ycentre, int x, int y, int red, int green, int blue)
{
   if (x == 0){
  	this->plot( xcentre, ycentre + y, red, green, blue);
  	this->plot( xcentre, ycentre - y, red, green, blue);
  	this->plot( xcentre + y, ycentre, red, green, blue);
  	this->plot( xcentre - y, ycentre, red, green, blue);
   }
   else
     if (x == y){
  	  this->plot( xcentre + x, ycentre + y, red, green, blue);
  	  this->plot( xcentre - x, ycentre + y, red, green, blue);
  	  this->plot( xcentre + x, ycentre - y, red, green, blue);
  	  this->plot( xcentre - x, ycentre - y, red, green, blue);
     }
     else
       if (x < y){
    	  this->plot( xcentre + x, ycentre + y, red, green, blue);
    	  this->plot( xcentre - x, ycentre + y, red, green, blue);
    	  this->plot( xcentre + x, ycentre - y, red, green, blue);
    	  this->plot( xcentre - x, ycentre - y, red, green, blue);
    	  this->plot( xcentre + y, ycentre + x, red, green, blue);
    	  this->plot( xcentre - y, ycentre + x, red, green, blue);
    	  this->plot( xcentre + y, ycentre - x, red, green, blue);
    	  this->plot( xcentre - y, ycentre - x, red, green, blue);
       }
}

int pngwriter::getheight(void)
{
   return height_;
}

int pngwriter::getwidth(void)
{
   return width_;
}


int pngwriter::getbitdepth(void)
{
   return bit_depth_;
}

int pngwriter::getcolortype(void)
{
   return colortype_;
}

double pngwriter::getgamma(void)
{
   return filegamma_;
}

void pngwriter::setgamma(double gamma)
{
   filegamma_ = gamma;
}


void pngwriter::setcompressionlevel(int level)
{
   if( (level < -1)||(level > 9) )
     {
	std::cerr << " PNGwriter::setcompressionlevel - ERROR **: Called with wrong compression level: should be -1 to 9, was: " << level << "." << std::endl;
     }
   compressionlevel_ = level;
}

double pngwriter::version(void)
{
   const char *a = "Jeramy Webb (jeramyw@gmail.com), Mike Heller (mkheller@gmail.com)"; // For their generosity ;-)
   char b = a[27];
   b++;
   return (PNGWRITER_VERSION);
}

void pngwriter::write_png(void)
{
   this->close();
}
