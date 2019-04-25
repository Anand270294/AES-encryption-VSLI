module shiftRows_top(
input [127:0] ip,
input enable,
output [127:0] op
);
////enter your code here
wire [127:0]op_temp;
    
assign op_temp[127:120] = ip[127:120]; // First row of bits not shifted
assign op_temp[119:112] = ip[ 87: 80]; // Second row of bits shifted by 1
assign op_temp[111:104] = ip[ 47: 40]; // Third row of bits shifted by 2
assign op_temp[103: 96] = ip[  7:  0]; // Fourth row of bits shifted by 3
    
assign op_temp[ 95: 88] = ip[ 95: 88];
assign op_temp[ 87: 80] = ip[ 55: 48];
assign op_temp[ 79: 72] = ip[ 15:  8];
assign op_temp[ 71: 64] = ip[103: 96];
    
assign op_temp[ 63: 56] = ip[ 63: 56];
assign op_temp[ 55: 48] = ip[ 23: 16];
assign op_temp[ 47: 40] = ip[111:104];
assign op_temp[ 39: 32] = ip[ 71: 64];
    
assign op_temp[ 31: 24] = ip[ 31: 24];
assign op_temp[ 23: 16] = ip[119:112];
assign op_temp[ 15:  8] = ip[ 79: 72];
assign op_temp[  7:  0] = ip[ 39: 32];    

assign op = enable ? op_temp : ip;
endmodule
