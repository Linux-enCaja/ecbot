/*
  gamma.cxx Generates the LUT for gamma memory
*/

#include <fstream>
#include <iostream>
#include <iomanip>
#include <cmath>

using namespace std;

int main()
{
   int gamma[256], tmp;
   ofstream ofs("gamma.v");

  ofs << setbase (16);

  for(int i = 0; i < 256; i++){
    gamma[i] = (unsigned char)(pow((double)i/255.0,(1/1.8))*255.0 +.5 );
  }

  ofs << "module gamma (clk, addr, data);"<< "\n";
  ofs << "  input  clk;" << "\n";
  ofs << "  input  [7:0] addr;"<< "\n";
  ofs << "  output reg [7:0] data;"<< "\n";
  ofs << "  always @(posedge clk) begin"<< "\n";
  ofs << "    case(addr)"<< "\n";
  ofs << "      ";
  for(int i = 0; i < 256; i++){
    ofs << "8'h"<< i <<": data <= 8'h"<< gamma[i] << ";" << "\n";
    ofs << "      ";
  }
  ofs << "endcase"<< "\n";
  ofs << "  end"<< "\n";
  ofs << "endmodule" << "\n";
}
