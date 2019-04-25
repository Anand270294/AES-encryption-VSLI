`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2019 22:39:11
// Design Name: 
// Module Name: regn
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


module regn(
    input clk,
    input rstn,
    input [127:0] data_in,
    output reg [127:0] data_out
    );
    
    reg [127:0] regs = 0;
    wire [127:0] out;
    
    always@(posedge clk) begin
        data_out <= data_in; 
    end
    
endmodule
