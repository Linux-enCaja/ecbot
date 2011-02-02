#include <iostream>
#include <ostream>
#include <fstream>
#include <stdio.h>

using namespace std;

#include <png.hpp>

// inline png::uint_16
// to_png_order(png::uint_16 x)
// {
//     return ((x & 0xff) << 8) | (x >> 8);
// }

int
main(int argc, char* argv[])
try
{
   unsigned char buff[166*126*3];
   ifstream ifs("test.bin");
   ifs.read((char*)buff,166*126*3);
   

//   png::image< png::rgb_pixel > image;
   png::image< png::gray_pixel > image;
   image.resize(166,125);

   for (size_t y = 0; y < image.get_height(); ++y)
   {
     for (size_t x = 0; x < image.get_width(); ++x)
     {
         //(16*b + 11*g + 5*r) >> 5;
       png::gray_pixel tmp_buff = (16*buff[3*x+2+166*y*3] + 11*buff[3*x+1+166*y*3] + 5*buff[3*x+166*y*3]) >> 5;
       image.set_pixel(x, y, tmp_buff);
     }  
   }
image.write("rgb.png");

//image.write("palette.png");
}
catch (std::exception const& error)
{
    std::cerr << "dump: " << error.what() << std::endl;
    return EXIT_FAILURE;
}
