#enter the files to be analyzed
read_verilog src/AES_top.v
read_verilog src/AESCore.v
read_verilog src/AEScntx.v
read_verilog src/subBtyes_top.v
read_verilog src/shiftRows_top.v
read_verilog src/MixCol_top.v
read_verilog src/AddRndKey_top.v
read_verilog src/aes_sbox.v
read_verilog src/matrix_mult.v
read_verilog src/regn.v

#elaborate top
current_design AES_top
#source constraint file
source syn/constraint.tcl
#compile the top module
compile
#report critical path
report_timing
#report area
report_area









