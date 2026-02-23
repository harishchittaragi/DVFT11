`include "t_ff.v"
module counter3(input clk,reset,
                output [2:0]q,qb);
t_ff T1 (.t(1'b1),.clk(clk),.reset(reset),.q(q[0]),.qb(qb[0]));
t_ff T2 (.t(1'b1),.clk(qb[0]),.reset(reset),.q(q[1]),.qb(qb[1]));
t_ff T3 (.t(1'b1),.clk(qb[1]),.reset(reset),.q(q[2]),.qb(qb[2]));

endmodule
