/*

i2c_master.v - Verilog source for I2C module

Features:
- I2C Baud of 100Kbps or 400kbps
- ACK or NACK during READ is controlled via LSB of DataWr
- SCL handshake (slave pulls SCL low to suspend master)

Limitations:
- Only supports master mode
- no IRQ support but has a busy bit that can be polled to assure module is not busy

Copyright (C) 2007  Steven Yu

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

*/
`timescale 1ns / 1ps

`define BAUD400K  50 
`define BAUD100K  200

`define IDLE      0
`define START     1
`define STOP      2
`define READ      3
`define WRITE     4

module i2c_master(Addr, DataWr, DataRd, Sda, Scl, En, Rd, Wr, Clk);
input wire [2:0] Addr;
input wire [7:0] DataWr;
output reg [7:0] DataRd;
inout            Sda;
inout            Scl;
input wire       En;
input wire       Rd;
input wire       Wr;
input wire       Clk;

reg out_sda           = 1'b0;
reg out_scl           = 1'b0;

reg [7:0] in_buffer   = 8'b0;
reg [7:0] buffer      = 8'b0;

reg ack               = 1'b0;
reg speed             = 1'b0;

reg i2c_Clk           = 1'b0;
reg [7:0] Clk_count   = 8'b0;

reg [2:0] state	      = 3'b0;
reg [2:0] nextstate   = 3'b0;
reg [5:0] state_count = 6'b0;
reg [2:0] bit_count   = 3'b0;

wire busy;
wire held;

// I2C Clock
always@(posedge Clk)
begin
    Clk_count = Clk_count + 1;

    if(speed)
    begin
	if(Clk_count >= `BAUD400K)
	begin
	    Clk_count = 0;
	end

	// ~50/50 duty cycle
	if(Clk_count > (`BAUD400K / 2))
	begin
	    i2c_Clk <= 1'b0;
	end
	else
	begin
	    i2c_Clk <= 1'b1;
	end
    end
    else
    begin
	if(Clk_count >= `BAUD100K)
	begin
	    Clk_count = 0;
	end

	// ~50/50 duty cycle
	if(Clk_count > (`BAUD100K / 2))
	begin
	    i2c_Clk <= 1'b0;
	end
	else
	begin
	    i2c_Clk <= 1'b1;
	end
    end
end

// Output Block
always@(Addr or En or Rd or buffer or speed or ack or held or busy)
begin
    DataRd = 8'bz;

    if(En && Rd)
    begin
	case(Addr)
	    // Data (read)
	    3'b011:
	    begin
		DataRd = buffer;
	    end

	    // Status
	    3'b100:
	    begin
		DataRd = {4'b0, speed, ack, held, busy};
	    end
	endcase
    end
end

// Input Block
always@(posedge Clk)
begin
    nextstate <= nextstate;

    case(state)
	`IDLE:
	begin
	    if(En && Wr && !busy)
	    begin
		case(Addr)

		    // Start
		    3'b000:
		    begin
			nextstate <= `START;
		    end

		    // Stop
		    3'b001:
		    begin
			nextstate <= `STOP;
		    end

		    // Read
		    3'b010:
		    begin
			in_buffer = {7'b0, DataWr[0]};
			nextstate <= `READ;
		    end

		    // Data (write)
		    3'b011:
		    begin
			in_buffer = DataWr;
			nextstate <= `WRITE;
		    end

		    // Speed
		    3'b100:
		    begin
			speed = DataWr[0];
			nextstate <= `IDLE;
		    end
		endcase
	    end
	end

	`START:
	begin
	    if(state_count >= 6)
	    begin
		nextstate <= `IDLE;
	    end
	end

	`STOP:
	begin
	    if(state_count >= 6)
	    begin
		nextstate <= `IDLE;
	    end
	end

	`READ:
	begin
	    if(state_count >= 44)
	    begin
		nextstate <= `IDLE;
	    end
	end

	`WRITE:
	begin
	    if(state_count >= 44)
	    begin
		nextstate <= `IDLE;
	    end
	end
    endcase
end

// state_count and bit_count
always@(posedge i2c_Clk)
begin
    state <= nextstate;

    case(state)
	`START:
	begin
	    if(state_count >= 6)
	    begin
		state_count <= 0;
	    end
	    else
	    begin
		state_count <= state_count + 1;
	    end
	end

	`STOP:
	begin
	    if(state_count >= 6)
	    begin
		state_count <= 0;
	    end
	    else
	    begin
		state_count <= state_count + 1;
	    end
	end

	`READ:
	begin
	    if(state_count >= 44)
	    begin
		state_count <= 0;
	    end
	    else
	    begin
		if(out_scl == Scl)
		begin
		    state_count <= state_count + 1;
		end

	    end

	    if(bit_count >= 4)
	    begin
		bit_count <= 0;
	    end
	    else
	    begin
		if(out_scl == Scl)
		begin
		    bit_count <= bit_count + 1;
		end
	    end
	end

	`WRITE:
	begin
	    if(state_count >= 44)
	    begin
		state_count <= 0;
	    end
	    else
	    begin
		if(out_scl == Scl)
		begin
		    state_count <= state_count + 1;
		end
	    end

	    if(bit_count >= 4)
	    begin
		bit_count <= 0;
	    end
	    else
	    begin
		if(out_scl == Scl)
		begin
		    bit_count <= bit_count + 1;
		end
	    end
	end

    endcase        
end

// SDA and SCL
always@(posedge i2c_Clk)
begin
    out_sda = out_sda;
    out_scl = out_scl;

    case(state)
	`START:
	begin
	    case(state_count)
		0:
		begin
		    out_sda = 1'b1;
		    out_scl = 1'b1;
		end

		1:
		begin
		    out_sda = 1'b1;
		    out_scl = 1'b1;
		end

		2:
		begin
		    out_sda = 1'b1;
		    out_scl = 1'b1;
		end

		3:
		begin
		    out_sda = 1'b0;
		    out_scl = 1'b1;
		end

		4:
		begin
		    out_sda = 1'b0;
		    out_scl = 1'b1;
		end

		5:
		begin
		    out_sda = 1'b0;
		    out_scl = 1'b0;
		end

		6:
		begin
		    out_sda = 1'b0;
		    out_scl = 1'b0;
		end
	    endcase
	end

	`STOP:
	begin
	    case(state_count)
		0:
		begin
		    out_sda = 1'b0;
		    out_scl = 1'b0;
		end

		1:
		begin
		    out_sda = 1'b0;
		    out_scl = 1'b1;
		end

		2:
		begin
		    out_sda = 1'b0;
		    out_scl = 1'b1;
		end

		3:
		begin
		    out_sda = 1'b1;
		    out_scl = 1'b1;
		end

		4:
		begin
		    out_sda = 1'b1;
		    out_scl = 1'b1;
		end

		5:
		begin
		    out_sda = 1'b1;
		    out_scl = 1'b1;
		end

		6:
		begin
		    out_sda = 1'b1;
		    out_scl = 1'b1;
		end
	    endcase
	end

	`READ:
	begin
	    if(state_count >= 40)
	    begin
		case(bit_count)

		    0:
		    begin
			out_sda = ~in_buffer[0];
			out_scl = 1'b0;
		    end

		    1:
		    begin
			out_sda = ~in_buffer[0];
			out_scl = 1'b0;
		    end

		    2:
		    begin
			out_sda = ~in_buffer[0];
			out_scl = 1'b1;
		    end

		    3:
		    begin
			out_sda = ~in_buffer[0];
			out_scl = 1'b1;
		    end

		    4:
		    begin
			out_sda = ~in_buffer[0];
			out_scl = 1'b0;
		    end

		endcase
	    end
	    else
	    begin
		case(bit_count)

		    0:
		    begin
			out_sda = 1'b1;
			out_scl = 1'b0;

			buffer = buffer << 1;
		    end

		    1:
		    begin
			out_sda = 1'b1;
			out_scl = 1'b0;
		    end

		    2:
		    begin
			out_sda = 1'b1;
			out_scl = 1'b1;
		    end

		    3:
		    begin
			out_sda = 1'b1;
			out_scl = 1'b1;

			buffer[0] = Sda;
		    end

		    4:
		    begin
			out_sda = 1'b1;
			out_scl = 1'b0;
		    end

		endcase
	    end
	end

	`WRITE:
	begin
	    if(state_count == 0)
	    begin
		buffer = in_buffer;
	    end

	    if(state_count >= 40)
	    begin
		case(bit_count)

		    0:
		    begin
			out_sda = 1'b1;
			out_scl = 1'b0;
		    end

		    1:
		    begin
			out_sda = 1'b1;
			out_scl = 1'b0;
		    end

		    2:
		    begin
			out_sda = 1'b1;
			out_scl = 1'b1;
		    end

		    3:
		    begin
			out_sda = 1'b1;
			out_scl = 1'b1;

			ack = Sda;
		    end

		    4:
		    begin
			out_sda = 1'b1;
			out_scl = 1'b0;
		    end

		endcase
	    end
	    else
	    begin
		case(bit_count)

		    0:
		    begin
			out_sda = buffer[7];
			out_scl = 1'b0;
		    end

		    1:
		    begin
			out_sda = buffer[7];
			out_scl = 1'b0;
		    end

		    2:
		    begin
			out_sda = buffer[7];
			out_scl = 1'b1;
		    end

		    3:
		    begin
			out_sda = buffer[7];
			out_scl = 1'b1;
		    end

		    4:
		    begin
			out_sda = buffer[7];
			out_scl = 1'b0;

			buffer = buffer << 1;
		    end

		endcase
	    end
	end
    endcase
end

assign Sda = out_sda ? 1'bz : 1'b0;
assign Scl = out_scl ? 1'bz : 1'b0;

assign busy = (state != `IDLE || nextstate != `IDLE) ? 1 : 0;
assign held = out_scl != Scl;

endmodule


