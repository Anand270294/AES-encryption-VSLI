module AES_top#(N=4)(
//from testbench
input clk,
input start,
input rstn,
input [127:0] plain_text,
input [127:0] cipher_key,
//to testbench
output done,
output [127:0] cipher_text
);
////enter your code here
wire accept,enbSB,enbSR,enbMC,enbAR,enbKS;
wire [3:0] rndNo;

AEScntx#(.N(N)) c0(clk,start,rstn,accept,rndNo,enbSB,enbSR,enbMC,enbAR,enbKS,done);
AESCore#(.N(N)) cr0(clk,rstn,plain_text,cipher_key,accept,rndNo,enbSB,enbSR,enbMC,enbAR,enbKS,cipher_text);

endmodule
