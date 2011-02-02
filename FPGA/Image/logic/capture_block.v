`timescale 1ns / 1ps
//`include "gamma.v"
module capture_block(
    // Control signals
    clk, reset, c_trigg, c_done,
    // Memory Interface
    mem_data, in_mem_data, mem_addr, mem_we, crst,
   // Camera Interface
    mclk, vclk, hsync, vsync, pixel_data
);
  parameter  DW   = 15;  // Data bus Width 
  parameter  AW   = 11;  // Address bus Width
  parameter  MC   = 4;  // Memory Capacity: Number of rows that can be stored in internal RAM

  input clk, reset;

  // Capture triggering
  input  c_trigg;
  output c_done;
  output mem_we;
  output wire [AW:0] mem_addr;
  output wire [DW:0] mem_data;
  input  wire [DW:0] in_mem_data;
  output reg mclk;
	 
  // Data inputs
  input vclk;
  input hsync;
  input vsync;
  input [7:0] pixel_data;



  // Data Outputs 
  output crst; 
  // First we convert all external async signals into our own domain
  reg hs_sync;
  reg vs_sync;
  reg vclk_sync;
  reg reset_sync;
  reg c_trigg_sync;

  reg inc_mem;
  reg rst_mem;
  reg load_mem;
  reg read_mem;
  reg togg_row;
  reg mem_full;
  reg e_mclk;
  reg crst = 1;
  reg c_done;
  reg mem_we;

  // state machine internal signals
  reg [7:0] pixdata_sync;

always @(posedge clk) begin
  hs_sync      <= hsync;
  vs_sync      <= vsync;
  vclk_sync    <= vclk;
  pixdata_sync <= pixel_data;
  reset_sync   <= reset;
  c_trigg_sync <= c_trigg;
end

  reg [9:0]  row_count;       // Current row.

   parameter init       = 4'b0000;
   parameter start      = 4'b0001;
   parameter new_row    = 4'b0010;
   parameter new_pixel  = 4'b0011;
   parameter wr_bytes   = 4'b0100;
   parameter wr_mem     = 4'b0110;
   parameter up_mem     = 4'b0111;
   parameter resume     = 4'b0101;
   parameter resume2    = 4'b1101;
   parameter inc_row    = 4'b1110;
   parameter new_frame  = 4'b1111;
   reg [3:0] state = init;

   //load_mem ; inc_mem ; rst_mem; mem_we; e_mclk; c_done; togg_row;
   parameter RESET_ALL = 8'b0011100;
   parameter RESET_MEM = 8'b0011100;
   parameter ENAB_MCLK = 8'b0001100;
   parameter LD_MEM    = 8'b1001100;
   parameter WRITE_MEM = 8'b0000100;
   parameter INCR_MEM  = 8'b0101100;
   parameter DONE_ROW  = 8'b0011110;
   parameter DIS_MCLK  = 8'b0011010;
   parameter INCR_ROW  = 8'b0011101;
   reg [7:0] dp_ctrl;

always@(negedge clk or posedge reset_sync) begin
  if (reset_sync) begin     //  Start the process, in this state the camera config (using I2C interface) must be done 
    state     <= init;
    load_mem  <= 0; crst <= 1; inc_mem <= 0; rst_mem <= 1; mem_we <= 0; e_mclk <= 1; c_done <= 0; togg_row <= 0; read_mem <= 0;
  end
  else
    case (state)

      init : begin          // When reset_sync = 0, the controller wait until the current frame finish (vs = hs = 0)
        if (~vs_sync & ~hs_sync) begin    // When vs = hs = 0, disable camera clock
          state    <= start;
          load_mem <= 0; crst <= 1; inc_mem <= 0; rst_mem <= 0; mem_we <= 0; e_mclk <= 0; c_done <= 0; togg_row <= 0; read_mem <= 0;
        end
        else begin 
          state    <= init;
          load_mem <= 0; crst <= 1; inc_mem <= 0; rst_mem <= 0; mem_we <= 0; e_mclk <= 1; c_done <= 0; togg_row <= 0; read_mem <= 0;
        end
      end

      start : begin            // wait for new capture request from processor
        if (~c_trigg_sync) begin
          state    <= start;
          load_mem <= 0; crst <= 1; inc_mem <= 0; rst_mem <= 1; mem_we <= 0; e_mclk <= 0; c_done <= 0; togg_row <= 0; read_mem <= 0;
        end
        else begin             // When the processor init the capture process, the camera clock is enabled.
          state    <= new_frame;
          load_mem <= 0; crst <= 1; inc_mem <= 0; rst_mem <= 1; mem_we <= 0; e_mclk <= 1; c_done <= 0; togg_row <= 0; read_mem <= 0;
        end
      end

      new_frame : begin
        if (vs_sync & hs_sync) begin     // wait for new frame (vs = hs = 1)
          state     <= new_row;
        end
        else begin 
          state  <= new_frame;
        end
        load_mem <= 0; crst <= 1; inc_mem <= 0; rst_mem <= 0; mem_we <= 0; e_mclk <= 1; c_done <= 0; togg_row <= 0; read_mem <= 0;
      end

    new_row : begin
      if (vs_sync) begin
        if (~vclk_sync & vs_sync) begin
          state   <= new_pixel;
        end
        else begin
          state   <= new_row;
        end
      end
      else  begin
        state   <= init;
      end
      load_mem <= 0; crst <= 1; inc_mem <= 0; rst_mem <= 0; mem_we <= 0; e_mclk <= 1; c_done <= 0; togg_row <= 0; read_mem <= 0;
    end

    new_pixel : begin
      if (vs_sync) begin
        if (hs_sync) begin
          if(vclk_sync) begin                        // Read pixel info on Rising edge, store this value
            state  <= wr_bytes;        
          end
          else begin
            state  <= new_pixel;                     // Waiting for rising edge on vclk_sync
          end
        end
        else begin
          state  <= inc_row;                          // hs_sync = 0 Blanking (no image information) waiting for new row
        end
      end
      else begin
        state  <= init;                              // Image frame transfer was done, so waiting for another frame
      end
      load_mem <= 0; crst <= 1; inc_mem <= 0; rst_mem <= 0; mem_we <= 0; e_mclk <= 1; c_done <= 0; togg_row <= 0; read_mem <= 1;
    end

    wr_bytes : begin    // Pixel data is 8 bit width, Memory has 16 bits, here we set the load_mem flag.
      if (vs_sync)
        state    <= wr_mem;
      else
        state    <= init;
      load_mem <= 1; crst <= 1; inc_mem <= 0; rst_mem <= 0; mem_we <= 0; e_mclk <= 1; c_done <= 0; togg_row <= 0; read_mem <= 0;
    end

    wr_mem : begin      // Write pixel data to memory pixel_count address
      if (vs_sync)
        state    <= up_mem;
      else
        state    <= init;
      load_mem <= 0; crst <= 1; inc_mem <= 0; rst_mem <= 0; mem_we <= 1; e_mclk <= 1; c_done <= 0; togg_row <= 0; read_mem <= 0;
    end

    up_mem : begin   // increase memory address in 1
      if (vs_sync)
        state    <= new_row;
      else
        state    <= init;
      load_mem <= 0; crst <= 1; inc_mem <= 1; rst_mem <= 0; mem_we <= 0; e_mclk <= 1; c_done <= 0; togg_row <= 0; read_mem <= 0;
    end

    inc_row : begin
      if (vs_sync)
        state    <= resume;
      else
        state    <= init;
      load_mem <= 0; crst <= 1; inc_mem <= 0; rst_mem <= 0; mem_we <= 0; e_mclk <= 1; c_done <= 0; togg_row <= 1; read_mem <= 0;
    end

// We have 72  kbits  available on XC3S50  FPGA so, we can store 36 rows (1/3 + 4 ) image
// We have 216 kbits  available on XC3S200 FPGA so, we can store 98 rows complete subQCIF image
// We store 32 rows in memory, the we signal to CPU that this info is available, the CPU decides if read this info or not
// we will waiting for c_trigg_sync signal to repeat the process.
    resume : begin // Waiting for the next row or signaling to CPU for reading data 
      if (~mem_full) begin   // Continue save pixel information on memory
        if (vs_sync) begin
          if (~hs_sync) begin    // Skiping blanking
            load_mem <= 0; crst <= 1; inc_mem <= 0; rst_mem <= 0; mem_we <= 0; e_mclk <= 1; c_done <= 0; togg_row <= 0; read_mem <= 0;
            state   <= resume;
          end
          else begin            // New row pixel information
            load_mem <= 0; crst <= 1; inc_mem <= 0; rst_mem <= 0; mem_we <= 0; e_mclk <= 1; c_done <= 0; togg_row <= 0; read_mem <= 0;
            state   <= new_row;
          end
        end
        else begin           // End of frame transmission, waiting new frame, This is not possible!!
          load_mem <= 0; crst <= 1; inc_mem <= 0; rst_mem <= 1; mem_we <= 0; e_mclk <= 1; c_done <= 0; togg_row <= 0; read_mem <= 0;
          state   <= init;
        end
      end
      else begin  // Memory full signal CPU for reading image information
        load_mem <= 0; crst <= 1; inc_mem <= 0; rst_mem <= 1; mem_we <= 0; e_mclk <= 0; c_done <= 1; togg_row <= 0; read_mem <= 0;
        state <= resume2;
      end
    end

    resume2 : begin  // waiting for CPU reading
      if(vs_sync) begin
        if (c_trigg_sync) begin
          state    <= new_frame;
          load_mem <= 0; crst <= 1; inc_mem <= 0; rst_mem <= 0; mem_we <= 0; e_mclk <= 1; c_done <= 1; togg_row <= 0; read_mem <= 0;
        end
        else begin    // Waiting for CPU finish read image info
          state    <= resume2;
          load_mem <= 0; crst <= 1; inc_mem <= 0; rst_mem <= 0; mem_we <= 0; e_mclk <= 0; c_done <= 1; togg_row <= 0; read_mem <= 0;
        end
      end
      else begin
        state    <= init;
        load_mem <= 0; crst <= 1; inc_mem <= 0; rst_mem <= 0; mem_we <= 0; e_mclk <= 0; c_done <= 0; togg_row <= 0; read_mem <= 0;
      end
    end

  endcase
end  // end always
//
// subQCIF = 128x96; QCIF = 176x144;  QVGA = 320x240; CIF = 352x288; VGA =  640x480; XGA = 1024x768  Pixels
// subQCIF = 256x96; QCIF = 352x144;  QVGA = 640x240; CIF = 704x288; VGA = 1280x480; XGA = 2048x768  Bytes
// D00 D01 D02 D03 D04 D05 D06 D07 | D10 D11 D12 D13 D14 D15 D16 D17 RGB 565
//  B0  B1  B2  B3  B4  G0  G1  G2 |  G3  G4  G5  R0  R1  R2  R3  R4  
// ************************************************************************************************************************
// 0x04; /* Register Address */
// DOUTOFF JPEGON PICMODE[1:0] | SELRGB PICSIZ[2:0] | PICMODE 0 4VGA, 1 SXGA  |  PICSIZ 0: FULL  1: VGA 2: QVGA 2: QQVGA
//    1       0        11      |    1      110                                   PICSIZ 3: QQVGA 4: CIF 5: QCIF 6: subQCIF
// 0x26; /* Enable Output @ 128x96 in RGB565 */
// 0x02 [6] SRST        Reset command 0h [0x00]: Active 1h [0x40]: Reset
// ************************************************************************************************************************
// 0x05; /* Register Address */
// FRM_SPD[1:0] [7:6] 0: Quarter  1: Half  2: Max
// 0x00;    /*Frame Rate Quarter*/
// ************************************************************************************************************************
// 0x1A; /* Register Address H_COUNT [7:0]*/
// 0xFF;    /* HCOUNT = 0x3FF (1023) */
// ************************************************************************************************************************
// 0x1B; /* Register Address V_COUNT[3:0] H_COUNT [9:8]*/
// 0xB3;    /* HCOUNT = 0x3FF V_COUNT= 21B*/
// ************************************************************************************************************************
// 0x1C; /* Register Address V_COUNT[9:4]*/
// 0x21; /* V_COUNT= 21B*/
// ************************************************************************************************************************
// i2c 0x3d wb 0x05 0x80
// i2c 0x3d wb 0x1a 0xff 
// i2c 0x3d wb 0x1b 0xb3
// i2c 0x3d wb 0x04 0x0c
// i2c 0x3d wb 0x1f 0x0b
// i2c 0x3d wb 0x1e 0xc3 
// i2c 0x3d wb 0x0e 0xac
// i2c 0x3d wb 0x11 0x4a
// i2c 0x3d wb 0x14 0x33
// ************************************************************************************************************************

  // General purpose Registers
  reg [14:0] pixel_count;     // Current Pixel captured or processed.

always @(posedge clk)
begin
    if(reset_sync | rst_mem) begin
      pixel_count   = 0;
    end
    else begin
      if(inc_mem) begin
       pixel_count = pixel_count + 1;
      end
    end
end

always @(posedge clk)
begin
    if(rst_mem) begin
      row_count = 0;
      mem_full  = 0;
    end
    else begin
      if(togg_row) begin
        if (row_count == MC) begin
          row_count = 0;
          mem_full  = 1;
        end
        else  begin
          row_count = row_count + 1;
          mem_full  = 0;
        end
      end
    end
end


reg [DW:0]  mem_data_buf;
reg [DW:0]  mem_in_buf;

always @(posedge clk)
begin
  if (read_mem)
    mem_in_buf <= in_mem_data;
  else
    mem_in_buf <= mem_in_buf;
end



reg [(AW+1):0]   mem_addr_buf;

always @(pixel_count) begin
   mem_addr_buf = pixel_count;
end
    assign mem_addr = {mem_addr_buf[(AW+1):1]};

//  wire [7:0] from_gamma;
//  gamma GAMMA_LUT (clk, pixdata_sync, from_gamma);


// byte to word pixel register
always @(posedge clk)
begin
  if(reset_sync) begin
    mem_data_buf <= 0;
  end
  else begin
    case ({load_mem, mem_addr_buf[0]})
      2'b10: mem_data_buf <= {mem_in_buf[15:8],pixdata_sync};
      2'b11: mem_data_buf <= {pixdata_sync,mem_in_buf[7:0]};
      2'b01: mem_data_buf <= mem_data_buf;
      2'b00: mem_data_buf <= mem_data_buf;
    endcase
  end
end

assign mem_data = mem_data_buf;

    // MCLK generator
/*
always @(posedge clk)
begin
  if(reset_sync) begin
    mclk         <= 0;
  end
  else begin
    if(e_mclk)
      mclk <= ~mclk;
    else
      mclk <= 0;
  end
end
*/


    // MCLK generator
  reg [7:0]  mclk_counter;
always @(posedge clk)
begin
//  if(reset_sync) begin
//    mclk_counter <= {7{1'b0}};
    mclk         <= 0;
//  end
//  else begin
    if(e_mclk) begin
      mclk_counter  <= mclk_counter +1;
      mclk          <= mclk_counter[1];
    end
//    else
//      mclk <= 0;
//  end
end


endmodule



