#include <iostream>
#include <ostream>
#include <fstream>

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
   unsigned char buff[332*251*3];
   ifstream ifs("test.bin");
   ifs.read((char*)buff,332*251*3);

   png::image< png::rgb_pixel > image;

   image.resize(332,251);

   for (size_t y = 0; y < image.get_height(); ++y)
   {
     for (size_t x = 0; x < image.get_width(); ++x)
     {
//       image[y][x] = png::rgb_pixel(buff[3*x+332*y*3], buff[3*x+1+332*y*3], buff[3*x+2+332*y*3]);
         image[y][x] = png::rgb_pixel(3*x+332*y*3, 3*x+1+332*y*3, 3*x+2+332*y*3);
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
