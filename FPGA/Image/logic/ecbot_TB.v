`timescale 1ns / 1ps

module camera_TB_v;

	// Inputs
   reg clk;
   reg [11:0] addr;
   reg nwe;
   reg ncs;
   reg noe;
   reg reset;

   reg cvclk = 0;
   reg capture_trigger = 0;
   reg cvsync = 0;
   reg chsync = 0;
   reg [7:0] ycbcr  = 0;

	// Bidirs
    reg [15:0] sram_data$inout$reg ;
    wire [15:0] sram_data = sram_data$inout$reg;	



   // Instantiate the Unit Under Test (UUT)
   ECBot uut ( .clk(clk), .reset(reset),
       .sram_data(sram_data), .addr(addr), .nwe(nwe), .ncs(ncs), .noe(noe),
       .capture_trigger(capture_trigger), .capture_done(capture_done), 
       .crst(crst), .cvsync(cvsync), .chsync(chsync), .cvclk(cvclk),
       .cmclk(cmclk), .ycbcr(ycbcr), .snap(snap), .P(P)
				  );
   parameter PERIOD  = 20;
   parameter real DUTY_CYCLE = 0.5;
   parameter OFFSET  = 0;
   parameter TSET    = 3;
   parameter THLD    = 3;
   parameter NWS     = 3;
   parameter CAM_OFF = 4000;
	 
	 reg [15:0] i;
	 reg [15:0] j;
	 reg [15:0] k;
	 reg [15:0] data_tx;	 


	event reset_trigger;
	event reset_done_trigger;

    initial begin // Reset the system, Start the image capture process
      forever begin 
        @ (reset_trigger);
        @ (negedge clk);
        reset = 1;
        @ (negedge clk);
        reset = 0;
        -> reset_done_trigger;
        repeat (250) begin 
          @ (posedge clk);
        end
        capture_trigger <= 1;
        repeat (250) begin 
          @ (posedge clk);
        end
        capture_trigger <= 0;
      end
    end
	 
    initial begin  // Initialize Inputs
      clk = 0; addr = 0; nwe = 1; ncs = 1; noe = 1;
    end

   initial  begin  // Process for clk
     #OFFSET;
     forever
     begin
       clk = 1'b0;
       #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
       #(PERIOD*DUTY_CYCLE);
     end
   end

 initial begin: TEST_CASE	
     #10 -> reset_trigger;
     @ (reset_done_trigger); 
     // Write data to SRAM
   for(i=0; i<10; i=i+1) begin
     @ (posedge clk);
     ncs <= 0;
     addr <= i[9:0];
     repeat (TSET) begin
       @ (posedge clk);
     end	 
     nwe <= 0;
     sram_data$inout$reg 	<= i*2;
     repeat (NWS) begin
       @ (posedge clk);
     end
     nwe <= 1;
     repeat (THLD) begin
       @ (posedge clk);
     end
     ncs <= 1;
     sram_data$inout$reg = {16{1'bz}};
   end
   nwe = 1;

   //Read Data
   for(i=0; i<10; i=i+1) begin
     @ (posedge clk);
     ncs <= 0;
     addr <= i[9:0];
     repeat (TSET) begin
       @ (posedge clk);
     end	 
     noe <= 0;
     sram_data$inout$reg 	<= i;
     repeat (NWS) begin
       @ (posedge clk);
     end
     noe <= 1;
     repeat (THLD) begin
      @ (posedge clk);
     end
     ncs <= 1;
     sram_data$inout$reg = {16{1'bz}};
   end
 end

 // pixel CLK generation   !!!! FIXME generate this cvclk only when e_mclk = 1 !!!!!!
 initial begin
   #CAM_OFF;
   forever begin
     cvclk <= 1'b0;
     repeat ((PERIOD-(PERIOD*DUTY_CYCLE))/2) begin
       @ (posedge cmclk);
     end
     cvclk = 1'b1;
     repeat (PERIOD*DUTY_CYCLE/2) begin
       @ (posedge cmclk);
     end
   end
 end


 //generate start_capture	  
 initial begin: CAPTURE_TRIGGER
   for(j=0; j<3; j=j+1) begin
     @ (posedge capture_done);  
     repeat (10000000) begin
       @ (posedge clk);
     end     
     capture_trigger <= 1;
     repeat (10000) begin
       @ (posedge clk);
     end     
     capture_trigger <= 0;
   end
 end
	
 initial begin: FRAME                //generate frame signals
   for(j=0; j<3; j=j+1) begin
     repeat (TSET) begin
       @ (posedge cvclk);
     end
     cvsync <=1;
     chsync <= 1;
     for(k=0; k<96; k=k+1) begin     // Generate 96 rows
       for(i=0; i<255; i=i+1) begin  // Generate an horizontal hs pulse of 255 cvclk
         @ (posedge cvclk);
         chsync <= 1;
         ycbcr <= i;
       end;
       for(i=0; i<116; i=i+1) begin  // simulate a blanking of 116 cvclk pulses
         @ (posedge cvclk);
         chsync <= 0;
         ycbcr <= 0;
       end;
     end;
     @ (posedge cvclk);
     cvsync <= 0;
   end
 end

endmodule

