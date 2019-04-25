module KeySchedule_top(
input  [127:0] ip_key,
input  enable,
input  [3:0] rndNo,
output  [127:0] op_key
);
////enter your code here
wire [31:0] w0;
wire [31:0] w1;
wire [31:0] w2;
wire [31:0] w3;
wire [127:0] op_temp;
wire [31:0] tem;

assign w0 = ip_key[127:96];
assign w1 = ip_key[ 85:64];
assign w2 = ip_key[ 63:32];
assign w3 = ip_key[ 31: 0];

    
aes_sbox a0(.ip(w3[23:16]),.op(tem[31:24])); //Sub the bytes using s-box 
aes_sbox a1(.ip(w3[15: 8]),.op(tem[23:16]));
aes_sbox a2(.ip(w3[7:0])  ,.op(tem[15:8]) );
aes_sbox a3(.ip(w3[31:24]),.op(tem[7:0])  );

assign op_temp[127:96] = w0 ^ tem ^ rcon(rndNo);  //XOR each part with the previous Columns and the RCon values 
assign op_temp[95:64]  = w0 ^ tem ^ rcon(rndNo) ^ w1;
assign op_temp[63:32]  = w0 ^ tem ^ rcon(rndNo) ^ w1 ^ w2;
assign op_temp[31:0]   = w0 ^ tem ^ rcon(rndNo) ^ w1 ^ w2 ^ w3;

assign op_key = enable ? op_temp : ip_key;
	
//A function to obtain RCon value (LUT)
function [31:0] rcon;
 input [3:0] rndCm;

 case(rndCm)
   4'h0 : rcon = 32'h01_00_00_00;
   4'h1 : rcon = 32'h02_00_00_00;
   4'h2 : rcon = 32'h04_00_00_00;
   4'h3 : rcon = 32'h08_00_00_00;
   4'h4 : rcon = 32'h10_00_00_00;
   4'h5 : rcon = 32'h20_00_00_00;
   4'h6 : rcon = 32'h40_00_00_00;
   4'h7 : rcon = 32'h80_00_00_00;
   4'h8 : rcon = 32'h1b_00_00_00;
   4'h9 : rcon = 32'h36_00_00_00;	
   default : rcon = 32'h00_00_00_00;
endcase

endfunction

endmodule
