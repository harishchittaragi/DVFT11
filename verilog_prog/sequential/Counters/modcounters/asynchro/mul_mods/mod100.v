`include "mod10.v"
module mod100(input clk,reset,output [7:0]q,qb);

wire [3:0]q0,qb0;
wire [3:0]q1,qb1;

wire rst0,rst1;

mod10 M1 (.clk(clk),.reset(reset),.q(q0),.qb(qb0));
//assign rst0=reset|(q0==4'd9);
//assign rst1=reset|(q1==4'd9);

mod10 M2 (.clk(q0[3]),.reset(reset),.q(q1),.qb(qb1));

assign q={q1,q0};
assign qb={qb1,qb0};
endmodule
