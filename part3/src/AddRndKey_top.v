module AddRndKey_top(
input [127:0] ip,
input [127:0] ip_key,
input enable,
output [127:0] op
);
////enter your code here
wire [127:0]op_temp;

assign op_temp[127:0] = ip[127:0] ^ ip_key[127:0];

assign op = enable ? op_temp : ip;

endmodule
