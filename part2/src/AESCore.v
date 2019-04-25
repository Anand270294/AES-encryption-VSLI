module AESCore(
//from testbench
input clk,
input rstn,
input [127:0] plain_text,
input [127:0] cipher_key,
//from controller
input accept,
input [3:0] rndNo,
input enbSB,
input enbSR,
input enbMC,
input enbAR,
input enbKS,
//to testbench
output [127:0] cipher_text
);
////enter your code here
reg [127:0] reg1 = 0;
reg [127:0] reg2 =0;
wire [127:0] state;
wire [127:0] key;
wire [127:0] out;
wire [127:0] KStoAR;
wire [127:0] SBtoSR;
wire [127:0] SRtoMC;
wire [127:0] MCtoAR;
wire [127:0] temp;

always@(posedge clk) begin
    if(rstn)begin
        reg1 = 0;
        reg2 = 0;
    end else begin
        reg1 = (accept && rndNo == 1) ? plain_text : out;
        reg2 =  (rndNo == 0) ? cipher_key : KStoAR;
    end    
end

assign state = reg1;
assign key = reg2;

KeySchedule_top k0(key,enbKS,rndNo,KStoAR);
subBytes_top sB0(state, enbSB, SBtoSR);
shiftRows_top sR0(SBtoSR, enbSR, SRtoMC);
MixCol_top m0(SRtoMC, enbMC, MCtoAR);
AddRndKey_top a0(MCtoAR,KStoAR, enbAR, out);

assign cipher_text = out;
endmodule
