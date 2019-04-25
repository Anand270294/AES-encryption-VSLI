module AEScntx(
//from testbench
input  clk,
input  start,
input  rstn,
//to AEScore
output  accept,
output  [3:0] rndNo,
output  enbSB,
output  enbSR,
output  enbMC,
output  enbAR,
output  enbKS,
//to testbench
output  done,
output  [9:0] completed_round
);
////enter your code here
reg [9:0] reg_completed = 1'b1;         //always set initial round to 1 
reg [3:0] rnd = 0;
reg [3:0] nextRnd = 0;
reg accept_temp = 0;
reg [4:0] enables = 0;
reg done_temp = 0;

always@(posedge clk) begin
    if(rstn)begin                       //When rstn is 1 fluhes all values to be 0
        rnd = 0;                        // except for completed rounds.
        nextRnd = 0;
        accept_temp = 0;
        enables = 0;
        done_temp = 0;
        reg_completed = 1'b1;
    end
    else if(start)begin                    //start of the enctyption process
        rnd = 1;
        accept_temp = 1;
        enables = 5'b00011;                //enables decides which operation should be enabled for a partiulcar round
        reg_completed = reg_completed << 1;//since it is first round only keySchedule and AddRndKey is activated
    end
    else if( rnd >= 1 && rnd < 9)begin     //for rounds 2 to 9 
        enables = 5'b11111;                // all of the operations are enabled 
        nextRnd = rnd + 1;
        rnd <= nextRnd; 
        accept_temp = 0;
        reg_completed = reg_completed << 1;
    end 
    else if(rnd == 9) begin                //Final Round only does not require MixCol
        enables = 5'b11011;                // so only MixCol is not being  enabled
        nextRnd = rnd + 1;
        rnd <= nextRnd; 
        done_temp = 1;
        reg_completed = reg_completed << 1;
    end 
    else if(rnd == 10) begin              // Indication that 10 rounds are completed so 
        done_temp = 0;                    //everything has to be set to 0 again
        rnd = 0;
        nextRnd = 0;
        enables = 0;
        reg_completed  = 1'b1;
    end 
end

assign enbSB = enables[4];
assign enbSR = enables[3];
assign enbMC = enables[2];
assign enbAR = enables[1];
assign enbKS = enables[0];

assign accept = accept_temp;

assign completed_round = reg_completed;
assign rndNo = rnd;

assign done = done_temp;

endmodule