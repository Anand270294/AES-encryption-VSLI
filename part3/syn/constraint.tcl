#create a clock with given constrained clock period

create_clock -period 0.5 [get_ports clk]

#create input delay on all inputs except clock

set_input_delay 0.1 -clock clk -max [remove_from_collection [all_inputs] [get_ports clk]]

#create output delay on all outputs

set_output_delay 0.1 -max -clock clk [all_outputs]

#set given load capacitance on all output pins

set_load 5 [all_outputs]
