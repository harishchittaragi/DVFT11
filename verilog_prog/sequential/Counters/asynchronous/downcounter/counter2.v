`include "t_ff.v"
module counter2(input clk ,reset,output[1:0]q,qb);
 wire q0,q1;
 wire qbo,qb1;
 wire t=1'b1;

t_ff T1 (.t(t),.clk(clk),.reset(reset),.q(q0),.qb(qb0));
t_ff T2 (.t(t),.clk(qb0),.reset(reset),.q(q1),.qb(qb1));
assign q={q0,q1};
assign qb={qb1,qb0};

endmodule
