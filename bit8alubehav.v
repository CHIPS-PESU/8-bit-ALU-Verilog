`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.08.2021 19:20:08
// Design Name: 
// Module Name: bit8alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bit8alu(a,b,s,acc,mulh,flag);

parameter width = 8,
				w = width - 1;

input [w:0] a;
input [w:0] b;
input [2:0] s;
output reg [w:0] acc;
output reg [w:0] mulh;
output reg [7:0] flag;

always @(*)
begin
    flag = 8'b0;
	case (s)
	3'b000 : acc = a & b;
	3'b001 : acc = a | b;
	3'b010 : acc = ~a;
	3'b011 : acc = a << 1;
	3'b100 : acc = acc >> 1;
	3'b101 : {flag[4] , acc} = a + b;
	3'b110 : {flag[5] , acc} = a - b;
	3'b111 : {mulh , acc} = a * b;
	endcase
	if( a == 8'b00000000)
	begin
		flag[0] = 1'b1;
	end
	else
	begin
		flag[0] = 1'b0;
	end
	if( a == 8'b11111111)
	begin
		flag[1] = 1'b1;
	end
	else
	begin
		flag[1] = 1'b0;
	end
	flag[2] = a[w];
	flag[3] = a[0];
	if( acc == 8'b00000000)
	begin
		flag[6] = 1'b1;
	end
	else
	begin
		flag[6] = 1'b0;
	end
	if( acc == 8'b11111111)
	begin
		flag[7] = 1'b1;
	end
	else
	begin
		flag[7] = 1'b0;
	end
end

endmodule
