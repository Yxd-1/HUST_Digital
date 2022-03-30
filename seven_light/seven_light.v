`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:18:59 03/14/2022 
// Design Name: 
// Module Name:    seven_light 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module seven_light(
    input clk,
    input en,
    output [7:0] led,
    output [7:0] choose
    );
	
	reg [7:0] led;
	reg [7:0] choose;
	reg [26:0] counter=0;
	reg [2:0] temp=0;
	
	//choose:AN7-AN0
	//led:CA-CG+DP

	always @(posedge clk,posedge en)
	begin
		if(en)
		begin
		counter <= 0;
		end
		else
		begin
		counter <= counter+1;
		end
	end
	
	always @(posedge clk)
	begin
			case(counter[20:18])
				3'b000:choose=8'b01111111;
				
				3'b001:choose=8'b10111111;
				
				3'b010:choose=8'b11011111;
				
				3'b011:choose=8'b11101111;
				
				3'b100:choose=8'b11110111;
				
				3'b101:choose=8'b11111011;
				
				3'b110:choose=8'b11111101;
				
				3'b111:choose=8'b11111110;
				
			endcase
	end
	
	always @(posedge counter[25])
	begin
		temp=temp+1;
	end
	
	always @(posedge clk)
	begin
			case(counter[20:18]-temp)
				3'b000:led=8'b11111111;
						 
				3'b001:led=8'b11111111;
						 
				3'b010:led=8'b11111111;
						 
				3'b011:led=8'b10010001;
						 
				3'b100:led=8'b01100001;
						 
				3'b101:led=8'b11100011;
						 
				3'b110:led=8'b11100011;
						 
				3'b111:led=8'b00000011;
						 
			endcase
	end
endmodule
