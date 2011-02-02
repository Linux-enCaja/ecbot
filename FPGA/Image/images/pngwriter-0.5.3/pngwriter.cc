#include "pngwriter.h"

// Default Constructor
////////////////////////////////////////////////////////////////////////////
pngwriter::pngwriter()
{

   filename_ = new char[255];
   textauthor_ = new char[255];
   textdescription_ = new char[255];
   texttitle_  = new char[255];
   textsoftware_ = new char[255];

   strcpy(filename_, "out.png");
   width_ = 250;
   height_ = 250;
   backgroundcolour_ = 65535;
   compressionlevel_ = -2;
   filegamma_ = 0.5;

   strcpy(textauthor_, "PNGwriter Author: Paul Blackburn");
   strcpy(textdescription_, "http://pngwriter.sourceforge.net/");
   strcpy(textsoftware_, "PNGwriter: An easy to use graphics library.");
   strcpy(texttitle_, "out.png");

   int kkkk;

   bit_depth_ = 16; //Default bit depth for new images
   colortype_=2;
   screengamma_ = 2.2;

   graph_ = (png_bytepp)malloc(height_ * sizeof(png_bytep));
   if(graph_ == NULL)
     {
	std::cerr << " PNGwriter::pngwriter - ERROR **:  Not able to allocate memory for image." << std::endl;
     }

   for (kkkk = 0; kkkk < height_; kkkk++)
     {
        graph_[kkkk] = (png_bytep)malloc(6*width_ * sizeof(png_byte));
	if(graph_[kkkk] == NULL)
	  {
	     std::cerr << " PNGwriter::pngwriter - ERROR **:  Not able to allocate memory for image." << std::endl;
	  }
     }

   if(graph_ == NULL)
     {
	std::cerr << " PNGwriter::pngwriter - ERROR **:  Not able to allocate memory for image." << std::endl;
     }

   int tempindex;
   for(int hhh = 0; hhh<width_;hhh++)
     {
	for(int vhhh = 0; vhhh<height_;vhhh++)
	  {
	     //graph_[vhhh][6*hhh + i] where i goes from 0 to 5
	     tempindex = 6*hhh;
	     graph_[vhhh][tempindex] = (char) floor(((double)backgroundcolour_)/256);
	     graph_[vhhh][tempindex+1] = (char)(backgroundcolour_%256);
	     graph_[vhhh][tempindex+2] = (char) floor(((double)backgroundcolour_)/256);
	     graph_[vhhh][tempindex+3] = (char)(backgroundcolour_%256);
	     graph_[vhhh][tempindex+4] = (char) floor(((double)backgroundcolour_)/256);
	     graph_[vhhh][tempindex+5] = (char)(backgroundcolour_%256);
	  }
     }

};

//Copy Constructor
//////////////////////////////////////////////////////////////////////////
pngwriter::pngwriter(const pngwriter &rhs)
{
   width_ = rhs.width_;
   height_ = rhs.height_;
   backgroundcolour_ = rhs.backgroundcolour_;
   compressionlevel_ = rhs.compressionlevel_;
   filegamma_ = rhs.filegamma_;

   filename_ = new char[strlen(rhs.filename_)+1];
   textauthor_ = new char[strlen(rhs.textauthor_)+1];
   textdescription_ = new char[strlen(rhs.textdescription_)+1];
   textsoftware_ = new char[strlen(rhs.textsoftware_)+1];
   texttitle_ = new char[strlen(rhs.texttitle_)+1];

   strcpy(filename_, rhs.filename_);
   strcpy(textauthor_, rhs.textauthor_);
   strcpy(textdescription_, rhs.textdescription_);
   strcpy(textsoftware_,rhs.textsoftware_);
   strcpy(texttitle_, rhs.texttitle_);

   int kkkk;

   bit_depth_ = rhs.bit_depth_;
   colortype_= rhs.colortype_;
   screengamma_ = rhs.screengamma_;

   graph_ = (png_bytepp)malloc(height_ * sizeof(png_bytep));
   if(graph_ == NULL)
     {
	std::cerr << " PNGwriter::pngwriter - ERROR **:  Not able to allocate memory for image." << std::endl;
     }

   for (kkkk = 0; kkkk < height_; kkkk++)
     {
        graph_[kkkk] = (png_bytep)malloc(6*width_ * sizeof(png_byte));
	if(graph_[kkkk] == NULL)
	  {
	     std::cerr << " PNGwriter::pngwriter - ERROR **:  Not able to allocate memory for image." << std::endl;
	  }
     }

   if(graph_ == NULL)
     {
	std::cerr << " PNGwriter::pngwriter - ERROR **:  Not able to allocate memory for image." << std::endl;
     }
   int tempindex;
   for(int hhh = 0; hhh<width_;hhh++)
     {
	for(int vhhh = 0; vhhh<height_;vhhh++)
	  {
	     //   graph_[vhhh][6*hhh + i ] i=0 to 5
	     tempindex=6*hhh;
	     graph_[vhhh][tempindex] = rhs.graph_[vhhh][tempindex];
	     graph_[vhhh][tempindex+1] = rhs.graph_[vhhh][tempindex+1];
	     graph_[vhhh][tempindex+2] = rhs.graph_[vhhh][tempindex+2];
	     graph_[vhhh][tempindex+3] = rhs.graph_[vhhh][tempindex+3];
	     graph_[vhhh][tempindex+4] = rhs.graph_[vhhh][tempindex+4];
	     graph_[vhhh][tempindex+5] = rhs.graph_[vhhh][tempindex+5];
	  }
     }

};

//Constructor for int colour levels, char * filename
//////////////////////////////////////////////////////////////////////////
pngwriter::pngwriter(int x, int y, int backgroundcolour, char * filename)
{
   width_ = x;
   height_ = y;
   backgroundcolour_ = backgroundcolour;
   compressionlevel_ = -2;
   filegamma_ = 0.5;

   textauthor_ = new char[255];
   textdescription_ = new char[255];
   texttitle_ = new char[strlen(filename)+1];
   textsoftware_ = new char[255];
   filename_ = new char[strlen(filename)+1];

   strcpy(textauthor_, "PNGwriter Author: Paul Blackburn");
   strcpy(textdescription_, "http://pngwriter.sourceforge.net/");
   strcpy(textsoftware_, "PNGwriter: An easy to use graphics library.");
   strcpy(texttitle_, filename);
   strcpy(filename_, filename);

   if((width_<0)||(height_<0))
     {
	std::cerr << " PNGwriter::pngwriter - ERROR **: Constructor called with negative height or width. Setting width and height to 1." << std::endl;
	width_ = 1;
	height_ = 1;
     }

   if(backgroundcolour_ >65535)
     {
	std::cerr << " PNGwriter::pngwriter - WARNING **: Constructor called with background colour greater than 65535. Setting to 65535."<<std::endl;
	backgroundcolour_ = 65535;
     }

   if(backgroundcolour_ <0)
     {
	std::cerr << " PNGwriter::pngwriter - WARNING **: Constructor called with background colour lower than 0. Setting to 0."<<std::endl;
	backgroundcolour_ = 0;
     }

   int kkkk;

   bit_depth_ = 16; //Default bit depth for new images
   colortype_=2;
   screengamma_ = 2.2;

   graph_ = (png_bytepp)malloc(height_ * sizeof(png_bytep));
   if(graph_ == NULL)
     {
	std::cerr << " PNGwriter::pngwriter - ERROR **:  Not able to allocate memory for image." << std::endl;
     }

   for (kkkk = 0; kkkk < height_; kkkk++)
     {
        graph_[kkkk] = (png_bytep)malloc(6*width_ * sizeof(png_byte));
	if(graph_[kkkk] == NULL)
	  {
	     std::cerr << " PNGwriter::pngwriter - ERROR **:  Not able to allocate memory for image." << std::endl;
	  }
     }

   if(graph_ == NULL)
     {
	std::cerr << " PNGwriter::pngwriter - ERROR **:  Not able to allocate memory for image." << std::endl;
     }

   int tempindex;
   for(int hhh = 0; hhh<width_;hhh++)
     {
	for(int vhhh = 0; vhhh<height_;vhhh++)
	  {
	     //graph_[vhhh][6*hhh + i] i = 0  to 5
	     tempindex = 6*hhh;
	     graph_[vhhh][tempindex] = (char) floor(((double)backgroundcolour_)/256);
	     graph_[vhhh][tempindex+1] = (char)(backgroundcolour_%256);
	     graph_[vhhh][tempindex+2] = (char) floor(((double)backgroundcolour_)/256);
	     graph_[vhhh][tempindex+3] = (char)(backgroundcolour_%256);
	     graph_[vhhh][tempindex+4] = (char) floor(((double)backgroundcolour_)/256);
	     graph_[vhhh][tempindex+5] = (char)(backgroundcolour_%256);
	  }
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

//Constructor for int levels, const char * filename
//////////////////////////////////////////////////////////////
pngwriter::pngwriter(int x, int y, int backgroundcolour, const char * filename)
{
   width_ = x;
   height_ = y;
   backgroundcolour_ = backgroundcolour;
   compressionlevel_ = -2;
   filegamma_ = 0.6;

   textauthor_ = new char[255];
   textdescription_ = new char[255];
   texttitle_ = new char[strlen(filename)+1];
   textsoftware_ = new char[255];
   filename_ = new char[strlen(filename)+1];

   strcpy(textauthor_, "PNGwriter Author: Paul Blackburn");
   strcpy(textdescription_, "http://pngwriter.sourceforge.net/");
   strcpy(textsoftware_, "PNGwriter: An easy to use graphics library.");
   strcpy(texttitle_, filename);
   strcpy(filename_, filename);

   if((width_<0)||(height_<0))
     {
	std::cerr << " PNGwriter::pngwriter - ERROR **: Constructor called with negative height or width. Setting width and height to 1." << std::endl;
	height_ = 1;
	width_ = 1;
     }

   if(backgroundcolour_ >65535)
     {
	std::cerr << " PNGwriter::pngwriter - WARNING **: Constructor called with background colour greater than 65535. Setting to 65535."<<std::endl;
	backgroundcolour_ = 65535;
     }

   if(backgroundcolour_ <0)
     {
	std::cerr << " PNGwriter::pngwriter - WARNING **: Constructor called with background colour lower than 0. Setting to 0."<<std::endl;
	backgroundcolour_ = 0;
     }

   int kkkk;

   bit_depth_ = 16; //Default bit depth for new images
   colortype_=2;
   screengamma_ = 2.2;

   graph_ = (png_bytepp)malloc(height_ * sizeof(png_bytep));
   if(graph_ == NULL)
     {
	std::cerr << " PNGwriter::pngwriter - ERROR **:  Not able to allocate memory for image." << std::endl;
     }

   for (kkkk = 0; kkkk < height_; kkkk++)
     {
        graph_[kkkk] = (png_bytep)malloc(6*width_ * sizeof(png_byte));
	if(graph_[kkkk] == NULL)
	  {
	     std::cerr << " PNGwriter::pngwriter - ERROR **:  Not able to allocate memory for image." << std::endl;
	  }
     }

   if(graph_ == NULL)
     {
	std::cerr << " PNGwriter::pngwriter - ERROR **:  Not able to allocate memory for image." << std::endl;
     }

   int tempindex;
   for(int hhh = 0; hhh<width_;hhh++)
     {
	for(int vhhh = 0; vhhh<height_;vhhh++)
	  {
	     //graph_[vhhh][6*hhh + i] where i = 0 to 5
	     tempindex=6*hhh;
	     graph_[vhhh][tempindex] = (char) floor(((double)backgroundcolour_)/256);
	     graph_[vhhh][tempindex+1] = (char)(backgroundcolour_%256);
	     graph_[vhhh][tempindex+2] = (char) floor(((double)backgroundcolour_)/256);
	     graph_[vhhh][tempindex+3] = (char)(backgroundcolour_%256);
	     graph_[vhhh][tempindex+4] = (char) floor(((double)backgroundcolour_)/256);
	     graph_[vhhh][tempindex+5] = (char)(backgroundcolour_%256);
	  }
     }

};

/////////////////////////////////////////////////////////
pngwriter & pngwriter::operator = (const pngwriter & rhs)
{
   if( this==&rhs)
     {
	return *this;
     }

   width_ = rhs.width_;
   height_ = rhs.height_;
   backgroundcolour_ = rhs.backgroundcolour_;
   compressionlevel_ = rhs.compressionlevel_;
   filegamma_ = rhs.filegamma_;

   filename_ = new char[strlen(rhs.filename_)+1];
   textauthor_ = new char[strlen(rhs.textauthor_)+1];
   textdescription_ = new char[strlen(rhs.textdescription_)+1];
   textsoftware_ = new char[strlen(rhs.textsoftware_)+1];
   texttitle_ = new char[strlen(rhs.texttitle_)+1];

   strcpy(textauthor_, rhs.textauthor_);
   strcpy(textdescription_, rhs.textdescription_);
   strcpy(textsoftware_,rhs.textsoftware_);
   strcpy(texttitle_, rhs.texttitle_);
   strcpy(filename_, rhs.filename_);

   int kkkk;

   bit_depth_ = rhs.bit_depth_;
   colortype_= rhs.colortype_;
   screengamma_ = rhs.screengamma_;

   graph_ = (png_bytepp)malloc(height_ * sizeof(png_bytep));
   if(graph_ == NULL)
     {
	std::cerr << " PNGwriter::pngwriter - ERROR **:  Not able to allocate memory for image." << std::endl;
     }

   for (kkkk = 0; kkkk < height_; kkkk++)
     {
        graph_[kkkk] = (png_bytep)malloc(6*width_ * sizeof(png_byte));
	if(graph_[kkkk] == NULL)
	  {
	     std::cerr << " PNGwriter::pngwriter - ERROR **:  Not able to allocate memory for image." << std::endl;
	  }
     }

   if(graph_ == NULL)
     {
	std::cerr << " PNGwriter::pngwriter - ERROR **:  Not able to allocate memory for image." << std::endl;
     }

   int tempindex;
   for(int hhh = 0; hhh<width_;hhh++)
     {
	for(int vhhh = 0; vhhh<height_;vhhh++)
	  {
	     tempindex=6*hhh;
	     graph_[vhhh][tempindex] = rhs.graph_[vhhh][tempindex];
	     graph_[vhhh][tempindex+1] = rhs.graph_[vhhh][tempindex+1];
	     graph_[vhhh][tempindex+2] = rhs.graph_[vhhh][tempindex+2];
	     graph_[vhhh][tempindex+3] = rhs.graph_[vhhh][tempindex+3];
	     graph_[vhhh][tempindex+4] = rhs.graph_[vhhh][tempindex+4];
	     graph_[vhhh][tempindex+5] = rhs.graph_[vhhh][tempindex+5];
	  }
     }

   return *this;
}

///////////////////////////////////////////////////////////////
void pngwriter::plot(int x, int y, int red, int green, int blue)
{
   int tempindex;

	red   = red   & 0x00FF;
	green = green & 0x00FF;
	blue  = blue  & 0x00FF;

   if((bit_depth_ == 8))
     {
	//	if( (height_-y >-1) && (height_-y <height_) && (6*(x-1) >-1) && (6*(x-1)+5<6*width_) )
	if( (y<height_+1) && (y>0) && (x>0) && (x<width_+1) )
	  {
	     //graph_[height_-y][6*(x-1) + i] where i goes from 0 to 5
	     tempindex= 3*x-3;
	     graph_[height_-y][tempindex]   = (unsigned char) floor(((double)red));
//	     graph_[height_-y][tempindex+1] = (char)(red%256);
	     graph_[height_-y][tempindex+1] = (unsigned char) floor(((double)green));
//	     graph_[height_-y][tempindex+3] = (char)(green%256);
	     graph_[height_-y][tempindex+2] = (unsigned char) floor(((double)blue));
//	     graph_[height_-y][tempindex+5] = (char)(blue%256);
	  };

	/*
	 if(!( (height_-y >-1) && (height_-y <height_) && (6*(x-1) >-1) && (6*(x-1)+5<6*width_) ))
	 {
	 std::cerr << " PNGwriter::plot-- Plotting out of range! " << y << "   " << x << std::endl;
	 }
	 */
     }

   if((bit_depth_ == 16))
     {
	//	 if( (height_-y >-1) && (height_-y <height_) && (3*(x-1) >-1) && (3*(x-1)+5<3*width_) )
//	if( (y<height_+1) && (y>0) && (x>0) && (x<width_+1) )
	if( (y<=height_) && (y>0) && (x>0) && (x<=width_) )
	  {
	     //	     graph_[height_-y][3*(x-1) + i] where i goes from 0 to 2
	     tempindex = 6*x-6;
	     graph_[height_-y][tempindex] =   (char)floor((red));
	     graph_[height_-y][tempindex+2] = (char)floor((green));
	     graph_[height_-y][tempindex+4] = (char)floor((blue));

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
void pngwriter::settext(char * title, char * author, char * description, char * software)
{
   delete [] textauthor_;
   delete [] textdescription_;
   delete [] texttitle_;
   delete [] textsoftware_;

   textauthor_ = new char[strlen(author)+1];
   textdescription_ = new char[strlen(description)+1];
   textsoftware_ = new char[strlen(software)+1];
   texttitle_ = new char[strlen(title)+1];

   strcpy(texttitle_, title);
   strcpy(textauthor_, author);
   strcpy(textdescription_, description);
   strcpy(textsoftware_, software);
};

///////////////////////////////////////////////////////
void pngwriter::settext(const char * title, const char * author, const char * description, const char * software)
{
   delete [] textauthor_;
   delete [] textdescription_;
   delete [] texttitle_;
   delete [] textsoftware_;

   textauthor_ = new char[strlen(author)+1];
   textdescription_ = new char[strlen(description)+1];
   textsoftware_ = new char[strlen(software)+1];
   texttitle_ = new char[strlen(title)+1];

   strcpy(texttitle_, title);
   strcpy(textauthor_, author);
   strcpy(textdescription_, description);
   strcpy(textsoftware_, software);
};

///////////////////////////////////////////////////////
void pngwriter::close()
{
   FILE            *fp;
   png_structp     png_ptr;
   png_infop       info_ptr;

   fp = fopen(filename_, "wb");
   if( fp == NULL)
     {
	std::cerr << " PNGwriter::close - ERROR **: Error creating file (fopen() returned NULL pointer)." << std::endl;
	perror(" PNGwriter::close - ERROR **");
	return;
     }

   png_ptr = png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
   info_ptr = png_create_info_struct(png_ptr);
   png_init_io(png_ptr, fp);
   if(compressionlevel_ != -2)
     {
	png_set_compression_level(png_ptr, compressionlevel_);
     }
   else
     {
	png_set_compression_level(png_ptr, PNGWRITER_DEFAULT_COMPRESSION);
     }

   png_set_IHDR(png_ptr, info_ptr, width_, height_,
		bit_depth_, PNG_COLOR_TYPE_RGB, PNG_INTERLACE_NONE,
		PNG_COMPRESSION_TYPE_DEFAULT, PNG_FILTER_TYPE_DEFAULT);

   if(filegamma_ < 1.0e-1)
     {
	filegamma_ = 0.4;
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
void pngwriter::line(int xfrom, int yfrom, int xto, int yto, int red, int green,int  blue)
{
   //  Bresenham Algorithm.
   //
   int dy = yto - yfrom;
   int dx = xto - xfrom;
   int stepx, stepy;

   if (dy < 0)
     {
	dy = -dy;  stepy = -1;
     }
   else
     {
	stepy = 1;
     }

   if (dx < 0)
     {
	dx = -dx;  stepx = -1;
     }
   else
     {
	stepx = 1;
     }
   dy <<= 1;     // dy is now 2*dy
   dx <<= 1;     // dx is now 2*dx

   this->plot(xfrom,yfrom,red,green,blue);

   if (dx > dy)
     {
	int fraction = dy - (dx >> 1);

	while (xfrom != xto)
	  {
	     if (fraction >= 0)
	       {
		  yfrom += stepy;
		  fraction -= dx;
	       }
	     xfrom += stepx;
	     fraction += dy;
	     this->plot(xfrom,yfrom,red,green,blue);
	  }
     }
   else
     {
	int fraction = dx - (dy >> 1);
	while (yfrom != yto)
	  {
	     if (fraction >= 0)
	       {
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
   while (x < y)
     {
	x++;
	if (p < 0)
	  {
	     p += 2*x+1;
	  }
	else
	  {
	     y--;
	     p += 2*(x-y)+1;
	  }
	circle_aux(xcentre, ycentre, x, y, red, green, blue);
     }
}

////////////////////////////////////////////////////////////

void pngwriter::circle_aux(int xcentre, int ycentre, int x, int y, int red, int green, int blue)
{
   if (x == 0)
     {
	this->plot( xcentre, ycentre + y, red, green, blue);
	this->plot( xcentre, ycentre - y, red, green, blue);
	this->plot( xcentre + y, ycentre, red, green, blue);
	this->plot( xcentre - y, ycentre, red, green, blue);
     }
   else
     if (x == y)
       {
	  this->plot( xcentre + x, ycentre + y, red, green, blue);
	  this->plot( xcentre - x, ycentre + y, red, green, blue);
	  this->plot( xcentre + x, ycentre - y, red, green, blue);
	  this->plot( xcentre - x, ycentre - y, red, green, blue);
       }
   else
     if (x < y)
       {
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

////////////////Reading routines/////////////////////
/////////////////////////////////////////////////

void pngwriter::readfromfile(char * name)
{
   FILE            *fp;
   png_structp     png_ptr;
   png_infop       info_ptr;
   unsigned char   **image;
   unsigned long   width, height;
   int bit_depth, color_type, interlace_type;
   //   png_uint_32     i;
   //
   fp = fopen (name,"rb");
   if (fp==NULL)
     {
	std::cerr << " PNGwriter::readfromfile - ERROR **: Error opening file \"" << std::flush;
	std::cerr << name <<std::flush;
	std::cerr << "\"." << std::endl << std::flush;
	perror(" PNGwriter::readfromfile - ERROR **");
	return;
     }

   if(!check_if_png(name, &fp))
     {
	std::cerr << " PNGwriter::readfromfile - ERROR **: Error opening file " << name << ". This may not be a valid png file. (check_if_png() failed)." << std::endl;
	// fp has been closed already if check_if_png() fails.
	return;
     }

   if(!read_png_info(fp, &png_ptr, &info_ptr))
     {
	std::cerr << " PNGwriter::readfromfile - ERROR **: Error opening file " << name << ". read_png_info() failed." << std::endl;
	// fp has been closed already if read_png_info() fails.
	return;
     }

   if(!read_png_image(fp, png_ptr, info_ptr, &image, &width, &height))
     {
	std::cerr << " PNGwriter::readfromfile - ERROR **: Error opening file " << name << ". read_png_image() failed." << std::endl;
	// fp has been closed already if read_png_image() fails.
	return;
     }

   //stuff should now be in image[][].

   if( image == NULL)
     {
	std::cerr << " PNGwriter::readfromfile - ERROR **: Error opening file " << name << ". Can't assign memory (after read_png_image(), image is NULL)." << std::endl;
	fclose(fp);
	return;
     }

   //First we must get rid of the image already there, and free the memory.
   int jjj;
   for (jjj = 0; jjj < height_; jjj++) free(graph_[jjj]);
   free(graph_);

   //Must reassign the new size of the read image
   width_ = width;
   height_ = height;

   //Graph now is the image.
   graph_ = image;

   rowbytes_ = png_get_rowbytes(png_ptr, info_ptr);

   png_get_IHDR(png_ptr, info_ptr, &width, &height, &bit_depth, &color_type, &interlace_type, NULL, NULL);
   bit_depth_ = bit_depth;
   colortype_ = color_type;

   if(color_type == PNG_COLOR_TYPE_PALETTE /*&& bit_depth<8*/)
     {
	png_set_expand(png_ptr);
     }

   if(color_type == PNG_COLOR_TYPE_GRAY && bit_depth<8)
     {
	png_set_expand(png_ptr);
     }

   if(color_type & PNG_COLOR_MASK_ALPHA)
     {
	png_set_strip_alpha(png_ptr);
     }

   if(color_type == PNG_COLOR_TYPE_GRAY || color_type == PNG_COLOR_TYPE_RGB_ALPHA)
     {
	png_set_gray_to_rgb(png_ptr);
     }

   if((bit_depth_ !=16)&&(bit_depth_ !=8))
     {
	std::cerr << " PNGwriter::readfromfile() - WARNING **: Input file is of unsupported type (bad bit_depth). Output will be unpredictable.\n";
     }

   if(colortype_ !=2)
     {
	std::cerr << " PNGwriter::readfromfile() - WARNING **: Input file is of unsupported type (bad color_type). Output will be unpredictable.\n";
     }

   screengamma_ = 2.2;
   double          file_gamma,screen_gamma;
   screen_gamma = screengamma_;
   if (png_get_gAMA(png_ptr, info_ptr, &file_gamma))
     {
	png_set_gamma(png_ptr,screen_gamma,file_gamma);
     }
   else
     {
	png_set_gamma(png_ptr, screen_gamma,0.45);
     }

   filegamma_ = file_gamma;

   fclose(fp);
}

///////////////////////////////////////////////////////

void pngwriter::readfromfile(const char * name)
{
   this->readfromfile((char *)(name));
}

/////////////////////////////////////////////////////////
int pngwriter::check_if_png(char *file_name, FILE **fp)
{
   char    sig[PNG_BYTES_TO_CHECK];

   if ( /*(*fp = fopen(file_name, "rb")) */  *fp == NULL) // Fixed 10 10 04
     {
	//   exit(EXIT_FAILURE);
	std::cerr << " PNGwriter::check_if_png - ERROR **: Could not open file  " << file_name << " to read." << std::endl;
	perror(" PNGwriter::check_if_png - ERROR **");
	return 0;
     }

   if (fread(sig, 1, PNG_BYTES_TO_CHECK, *fp) != PNG_BYTES_TO_CHECK)
     {
	//exit(EXIT_FAILURE);
	std::cerr << " PNGwriter::check_if_png - ERROR **: File " << file_name << " does not appear to be a valid PNG file." << std::endl;
	perror(" PNGwriter::check_if_png - ERROR **");
	fclose(*fp);
	return 0;
     }
   
   if (png_sig_cmp( (png_bytep) sig, (png_size_t)0, PNG_BYTES_TO_CHECK) /*png_check_sig((png_bytep) sig, PNG_BYTES_TO_CHECK)*/ ) 
     {
	std::cerr << " PNGwriter::check_if_png - ERROR **: File " << file_name << " does not appear to be a valid PNG file. png_check_sig() failed." << std::endl;
	fclose(*fp);
	return 0;
     }
   
   
   
   return 1; //Success
}

///////////////////////////////////////////////////////
int pngwriter::read_png_info(FILE *fp, png_structp *png_ptr, png_infop *info_ptr)
{
   *png_ptr = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
   if (*png_ptr == NULL)
     {
	std::cerr << " PNGwriter::read_png_info - ERROR **: Could not create read_struct." << std::endl;
	fclose(fp);
	return 0;
	//exit(EXIT_FAILURE);
     }
   *info_ptr = png_create_info_struct(*png_ptr);
   if (*info_ptr == NULL)
     {
	png_destroy_read_struct(png_ptr, (png_infopp)NULL, (png_infopp)NULL);
	std::cerr << " PNGwriter::read_png_info - ERROR **: Could not create info_struct." << std::endl;
	//exit(EXIT_FAILURE);
	fclose(fp);
	return 0;
     }
   if (setjmp((*png_ptr)->jmpbuf)) /*(setjmp(png_jmpbuf(*png_ptr)) )*//////////////////////////////////////
     {
	png_destroy_read_struct(png_ptr, info_ptr, (png_infopp)NULL);
	std::cerr << " PNGwriter::read_png_info - ERROR **: This file may be a corrupted PNG file. (setjmp(*png_ptr)->jmpbf) failed)." << std::endl;
	fclose(fp);
	return 0;
	//exit(EXIT_FAILURE);
     }
   png_init_io(*png_ptr, fp);
   png_set_sig_bytes(*png_ptr, PNG_BYTES_TO_CHECK);
   png_read_info(*png_ptr, *info_ptr);

   return 1;
}

////////////////////////////////////////////////////////////
int pngwriter::read_png_image(FILE *fp, png_structp png_ptr, png_infop info_ptr,
			      png_bytepp *image, png_uint_32 *width, png_uint_32 *height)
{
   unsigned int i,j;

   *width = png_get_image_width(png_ptr, info_ptr);
   *height = png_get_image_height(png_ptr, info_ptr);

   if( width == NULL)
     {
	std::cerr << " PNGwriter::read_png_image - ERROR **: png_get_image_width() returned NULL pointer." << std::endl;
	fclose(fp);
	return 0;
     }

   if( height == NULL)
     {
	std::cerr << " PNGwriter::read_png_image - ERROR **: png_get_image_height() returned NULL pointer." << std::endl;
	fclose(fp);
	return 0;
     }

   if ((*image = (png_bytepp)malloc(*height * sizeof(png_bytep))) == NULL)
     {
	std::cerr << " PNGwriter::read_png_image - ERROR **: Could not allocate memory for reading image." << std::endl;
	fclose(fp);
	return 0;
	//exit(EXIT_FAILURE);
     }
   for (i = 0; i < *height; i++)
     {
	(*image)[i] = (png_bytep)malloc(png_get_rowbytes(png_ptr, info_ptr));
	if ((*image)[i] == NULL)
	  {
	     for (j = 0; j < i; j++) free((*image)[j]);
	     free(*image);
	     fclose(fp);
	     std::cerr << " PNGwriter::read_png_image - ERROR **: Could not allocate memory for reading image." << std::endl;
	     return 0;
	     //exit(EXIT_FAILURE);
	  }
     }
   png_read_image(png_ptr, *image);

   return 1;
}

///////////////////////////////////
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

void pngwriter::resize(int width, int height)
{

   for (int jjj = 0; jjj < height_; jjj++) free(graph_[jjj]);
   free(graph_);

   width_ = width;
   height_ = height;
   backgroundcolour_ = 0;

   graph_ = (png_bytepp)malloc(height_ * sizeof(png_bytep));
   if(graph_ == NULL)
     {
	std::cerr << " PNGwriter::resize - ERROR **:  Not able to allocate memory for image." << std::endl;
     }

   for (int kkkk = 0; kkkk < height_; kkkk++)
     {
	graph_[kkkk] = (png_bytep)malloc(6*width_ * sizeof(png_byte));
	if(graph_[kkkk] == NULL)
	  {
	     std::cerr << " PNGwriter::resize - ERROR **:  Not able to allocate memory for image." << std::endl;
	  }
     }

   if(graph_ == NULL)
     {
	std::cerr << " PNGwriter::resize - ERROR **:  Not able to allocate memory for image." << std::endl;
     }

   int tempindex;
   for(int hhh = 0; hhh<width_;hhh++)
     {
	for(int vhhh = 0; vhhh<height_;vhhh++)
	  {
	     //graph_[vhhh][6*hhh + i] where i goes from 0 to 5
	     tempindex = 6*hhh;
	     graph_[vhhh][tempindex] = (char) floor(((double)backgroundcolour_)/256);
	     graph_[vhhh][tempindex+1] = (char)(backgroundcolour_%256);
	     graph_[vhhh][tempindex+2] = (char) floor(((double)backgroundcolour_)/256);
	     graph_[vhhh][tempindex+3] = (char)(backgroundcolour_%256);
	     graph_[vhhh][tempindex+4] = (char) floor(((double)backgroundcolour_)/256);
	     graph_[vhhh][tempindex+5] = (char)(backgroundcolour_%256);
	  }
     }
}


