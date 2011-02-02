`timescale 1ns / 1ps
// *******************************************************************
//                       AT91 <-> FPGA INTERFACE
//        _______      ____________      _______
//       |       |    |            |    |       |
//       |     D |----|       rdBus|----|DOut   |
//       |     A |----|       weBus|----|DIn    |
//       |     WE|----| buffer_addr|----|A      |
//       |     RD|----|         nRW|----|RW     |
//       |     CS|----|            |    |       |
//       |       |    |            |    |       |
//       |_______|    |____________|    |_______|
//       AT91' BUS   AT91/FPGA Iface   Peripheric1
//

module ECBot(
  // Common signal
  clk,  reset, led,
  // FPGA to CPU interfaz
  sram_data, addr, nwe, ncs, noe,
  // Camera Interfaz
  capture_trigger, capture_done, 
  crst, cvsync, chsync, cvclk, cmclk, ycbcr, snap,
  P
  //General IO Port
  //FIO0, FIO1, FIO2, FIO3, FIO4, FIO5, FIO6, FIO7, FIO8, FIO9
  );//, cscl, csda);
  parameter  DW = 15;
  parameter  AW = 11;
  input      clk, addr, nwe, ncs, noe, reset;
  inout      [DW:0] sram_data;
  output     led;
  
  //Camera Signals
  input   capture_trigger;
  output  crst, cmclk;
  output  capture_done;
  output  snap;
  input   cvsync, chsync, cvclk;//, cscl, csda;
  input   [7:0]     ycbcr;

  //Servo Outputs
  output [9:0] P;

  //General purpose I/Os
  //output FIO0, FIO1, FIO2, FIO3, FIO4, FIO5, FIO6, FIO7, FIO8, FIO9; 
// Internal conection
  wire    led;

  // synchronize signals                               
  reg    sncs, snwe, sncap_trig;
  reg    [AW:0] buffer_addr;   // A22 .. A11
  reg    [DW:0] buffer_data;

  // interfaz fpga signals
  wire   [AW:0] addr;

  // bram interfaz signals
  reg    we;
  reg    w_st;

  // Capture Camera interfaz
  reg    c_st;
  reg    cap_trig;

  reg    [DW:0] wdBus;
  wire   [DW:0] rdBus;

  //Camera Interfaz signals
  wire cam_we;
  wire [AW:0] cam_addr;
  wire [DW:0] cam_data;
  wire [DW:0] in_cam_data;


  // interefaz signals assignments
  wire         T = ~nwe | noe | ncs;
  assign       sram_data = T?16'bZ:rdBus;

  // Bus Signals


  // FIXME: Dismiss the mux and address decoder pheripherals. !!!
wire csP0;
wire csP1;
wire csP2;
wire csP3;
wire CSPIC;

wire [DW:0] dP0;
wire [DW:0] dP1;
wire [DW:0] dP2;
wire [DW:0] dP3;

wire [DW:0] DICONS;
wire [DW:0] DIPIC;
  //--------------------------------------------------------------------------

  // synchronize assignment
  always  @(negedge clk)
  begin
    sncs       <= ncs;
    snwe       <= nwe;
    sncap_trig <= capture_trigger;

    buffer_data <= sram_data;
    buffer_addr <= addr;
  end


	// write access CPU to bram
  always @(posedge clk)
	if(reset) {w_st, we, wdBus} <= 0;
	else begin
		wdBus <= buffer_data;
		case (w_st)
			0: begin
				we <= 0;
				if(sncs | snwe) w_st <= 1;
			end
			1: begin
				if(~(sncs | snwe)) begin
					we    <= 1;
					w_st  <= 0;
				end	
				else we <= 0;
			end
		endcase
	end


	// write access CPU to bram
  always @(posedge clk)
	if(reset) {c_st, cap_trig} <= 0;
	else begin
		case (c_st)
			0: begin
				cap_trig <= 0;
				if(sncap_trig) c_st <= 1;
                                else          c_st <= 0;
			end
			1: begin
				if(~sncap_trig) begin
					cap_trig  <= 1;
					c_st      <= 0;
				end	
				else cap_trig <= 0;
			end
		endcase
	end

//crst, cscl, csda,

// assign FIO0 = ycbcr[9];
// assign FIO1 = ycbcr[8];
// assign FIO2 = ycbcr[7];
// assign FIO3 = ycbcr[6];
// assign FIO4 = ycbcr[5];
// assign FIO5 = ycbcr[4];
// assign FIO6 = ycbcr[3];
// assign FIO7 = ycbcr[2];
// assign FIO8 = ycbcr[1];
// assign FIO9 = cvclk;
 

// Bus Multiplexer:  The XC3S don't has internal tri-states, if you have more than two
//                   Peripherics you must Multiplex its output Data Buses.
// dp0 = sram

capture_block camera ( clk, reset, cap_trig, capture_done,
                         cam_data, in_cam_data, cam_addr, cam_we, crst, 
                         cmclk, cvclk, chsync, cvsync, ycbcr 
);

// The XCS350E have 72k bits distributed in 4 block RAM (18 kbits each one), i.e. 2 kBytes from block
// We use the 4 banks of RAMB16 (16384 bits = 16kb = 2kB), each block use only four bits D15:D12, D11:D8, D7:D4, D3:D0
// We need 12 Address lines to address each 2kB bank.

RAMB16_S4_S4 ba3( .CLKA(~clk), .ENA(1'b1), .SSRA(1'b0), .ADDRA(buffer_addr),
                    .WEA(we), .DIA(wdBus[15:12]), .DOA(rdBus[15:12]),
                    .CLKB(~clk), .ENB(1'b1), .SSRB(1'b0), .ADDRB(cam_addr),
                    .WEB(cam_we), .DIB(cam_data[15:12]) , .DOB(in_cam_data[15:12])
);

RAMB16_S4_S4 ba2( .CLKA(~clk), .ENA(1'b1), .SSRA(1'b0), .ADDRA(buffer_addr),
                    .WEA(we), .DIA(wdBus[11:8]), .DOA(rdBus[11:8]),
                    .CLKB(~clk), .ENB(1'b1), .SSRB(1'b0), .ADDRB(cam_addr),
                    .WEB(cam_we), .DIB(cam_data[11:8]) , .DOB(in_cam_data[11:8])
);

RAMB16_S4_S4 ba1( .CLKA(~clk), .ENA(1'b1), .SSRA(1'b0), .ADDRA(buffer_addr),
                    .WEA(we), .DIA(wdBus[7:4]), .DOA(rdBus[7:4]),
                    .CLKB(~clk), .ENB(1'b1), .SSRB(1'b0), .ADDRB(cam_addr),
                    .WEB(cam_we), .DIB(cam_data[7:4]) , .DOB(in_cam_data[7:4])
);

RAMB16_S4_S4 ba0( .CLKA(~clk), .ENA(1'b1), .SSRA(1'b0), .ADDRA(buffer_addr),
                    .WEA(we), .DIA(wdBus[3:0]), .DOA(rdBus[3:0]),
                    .CLKB(~clk), .ENB(1'b1), .SSRB(1'b0), .ADDRB(cam_addr),
                    .WEB(cam_we), .DIB(cam_data[3:0]) , .DOB(in_cam_data[3:0])
);

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RCServo servo1 (buffer_addr[4:0], dP1, wdBus, csP1, we, P, clk);

	reg [24:0]  counter;
	always @(posedge clk) begin
	  if (reset)
	    counter <= {32{1'b0}};
	  else
	    counter <= counter + 1;
	end 
	assign led = counter[24];

        assign snap = 1;

endmodule
