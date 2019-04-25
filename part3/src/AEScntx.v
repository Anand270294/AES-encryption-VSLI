module AEScntx#(N=4)(
//from testbench
input clk,
input start,
input rstn,
//to AEScore
output accept,
output [3:0] rndNo,
output enbSB,
output enbSR,
output enbMC,
output enbAR,
output enbKS,
//to testbench
output done
);
////enter your code here
reg [N-1:0] regCounter = 0; 
reg [3:0] rnd = 0;
reg accept_temp = 0;
reg [4:0] enables = 0;
reg done_temp = 0;

always@(posedge clk) begin
    if(rstn) begin
        regCounter = 0;
        rnd = 0;
        accept_temp = 0;
        enables = 0;
        done_temp = 0;
    end else if(start)begin
        accept_temp = 1;
        regCounter = 1'b1;
     end else begin 
        if(regCounter[N-1] == 1)begin
            if(done == 1) begin
                done_temp = 0;
            end    
             if(rnd == 0 && accept == 1) begin
                rnd = 1'b1;
                accept_temp = 0;
            end else begin 
                rnd = rnd + 1;
            end
        end 
        if(rnd == 1) begin
            enables = 5'b00011;
            accept_temp = 0;
        end
        if(rnd > 1 && rnd <= 9)begin
            enables = 5'b11111;
        end   
        if(rnd == 10) begin
            enables = 5'b11011;
            done_temp = 1;
            rnd = 0;
        end
    regCounter = (regCounter[N-1] == 1) ? 1'b1 : regCounter << 1;      
  end
end

assign enbSB = enables[4];
assign enbSR = enables[3];
assign enbMC = enables[2];
assign enbAR = enables[1];
assign enbKS = enables[0];

assign accept = accept_temp;

assign rndNo = rnd;

assign done = done_temp;

endmodule
