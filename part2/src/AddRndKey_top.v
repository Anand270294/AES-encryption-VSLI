module AddRndKey_top(
input [127:0] ip,
input [127:0] ip_key,
input enable,
output [127:0] op
);
////enter your code here
// XOR bitwise for key and input
wire [127:0]op_temp;

assign op_temp = ip ^ ip_key;

assign op = enable ? op_temp : ip;
endmodule
