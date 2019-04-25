module AES_top #(N = 100)(
//from testbench
input clk,
input start,
input rstn,
input [128*N-1:0] plain_text,
input [128*N-1:0] cipher_key,
//to testbench
output done,
output [9:0] completed_round,
output [128*N-1:0] cipher_text
);
////enter your code here
parameter bitCount = 128;
integer prev = 128 * N;
reg [127:0] text = 0;
wire [3:0] rndNo;
wire accept,enbSB,enbSR,enbMC,enbAR,enbKS;

AEScntx c0(clk,start,rstn,accept,rndNo,enbSB,enbSR,enbMC,enbAR,enbKS,done,completed_round);

genvar i;
generate 
   for(i = 1 ; i <= N ; i = i + 1) begin
        AESCore cr0(clk,rstn,plain_text[i*bitCount -1 : (i - 1)* bitCount ],cipher_key[i*bitCount - 1: (i - 1)* bitCount ],
                    accept,rndNo,enbSB,enbSR,enbMC,enbAR,enbKS,cipher_text[i*bitCount -1 : (i - 1)* bitCount ]);
   end
endgenerate   

endmodule
