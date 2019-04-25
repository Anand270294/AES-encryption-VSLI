module subBytes_top(
input [1271:0] ip,
input enable,
output [127:0] op
);
////enter your code here
// SubBytes replaces the bytes based on the aes_sbox lookup table. 
wire [127:0]op_temp;
 
    aes_sbox q0( .ip(ip[127:120]), .op(op_temp[127:120]) );
    aes_sbox q1( .ip(ip[119:112]), .op(op_temp[119:112]) );
    aes_sbox q2( .ip(ip[111:104]), .op(op_temp[111:104]) );
    aes_sbox q3( .ip(ip[103:96]),  .op(op_temp[103:96])  );

    aes_sbox q4( .ip(ip[95:88]),   .op(op_temp[95:88])   );
    aes_sbox q5( .ip(ip[87:80]),   .op(op_temp[87:80])   );
    aes_sbox q6( .ip(ip[79:72]),   .op(op_temp[79:72])   );
    aes_sbox q7( .ip(ip[71:64]),   .op(op_temp[71:64])   );

    aes_sbox q8( .ip(ip[63:56]),   .op(op_temp[63:56])   );
    aes_sbox q9( .ip(ip[55:48]),   .op(op_temp[55:48])   );
    aes_sbox q10(.ip(ip[47:40]),   .op(op_temp[47:40])   );
    aes_sbox q11(.ip(ip[39:32]),   .op(op_temp[39:32])   );

    aes_sbox q12(.ip(ip[31:24]),  .op(op_temp[31:24])    );
    aes_sbox q13(.ip(ip[23:16]),  .op(op_temp[23:16])    );
    aes_sbox q14(.ip(ip[15: 8]),  .op(op_temp[15: 8])    );
    aes_sbox q15(.ip(ip[ 7: 0]),  .op(op_temp[ 7: 0])    );

    assign op = enable ? op_temp : ip;
endmodule
