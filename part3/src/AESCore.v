module AESCore#(N=4)(
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
wire  [127:0] state;
wire [127:0] key;
wire [127:0] out;
wire [127:0] KStoAR;
wire [127:0] SBtoSR;
wire [127:0] SRtoMC;
wire [127:0] MCtoAR;
wire [127:0] cipher [N:0];
wire [127:0] text [N:0];
wire [127:0] text_choice;
wire [127:0] cipher_choice;

parameter Q = N/4;
parameter H = N/2;

assign text_choice = (rndNo == 0 && accept ==1) ? plain_text : out;
assign  cipher_choice = (rndNo == 0 && accept == 1) ? cipher_key : cipher[N];

assign text[0] = text_choice;

genvar i;
generate 
    for(i = 1; i < Q; i = i+1)begin
        regn n0(clk,rstn,text[i-1],text[i]);
    end
endgenerate

assign state = text[Q-1];    

subBytes_top sB0(state, enbSB, SBtoSR);

assign text[Q] = SBtoSR;

generate 
    for(i = Q + 1; i < N - (Q*2); i = i+1)begin
        regn n0(clk,rstn,text[i-1],text[i]);
    end
endgenerate

shiftRows_top sR0(text[(Q*2) - 1], enbSR, SRtoMC);

assign text[2*Q] = SRtoMC;

generate 
    for(i = (2*Q) + 1; i < 3*Q; i = i+1)begin
        regn n0(clk,rstn,text[i-1],text[i]);
    end
endgenerate

MixCol_top m0(text[(3*Q) - 1], enbMC, MCtoAR);

assign text[3*Q] = MCtoAR;

generate 
    for(i = (3*Q) + 1; i <= N; i = i+1)begin
        regn n0(clk,rstn,text[i-1],text[i]);
    end
endgenerate

AddRndKey_top a0(text[N],cipher[N], enbAR, out);

assign cipher_text = out;

assign cipher[0] = cipher_choice; //N-slowing the cipher keys to match the text

generate 
    for(i = 1; i < H; i = i+1)begin
        regn n0(clk,rstn,cipher[i-1],cipher[i]);
    end
endgenerate

KeySchedule_top k0(cipher[H-1],enbKS,rndNo,KStoAR);

assign cipher[H] = KStoAR;

generate 
    for(i = H + 1; i <= N ;i = i+1)begin
        regn n1(clk,rstn,cipher[i-1],cipher[i]);
    end
endgenerate    

endmodule
