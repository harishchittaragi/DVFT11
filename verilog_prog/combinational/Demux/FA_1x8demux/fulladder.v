`include "demux18.v"
module fulladder(input a,b,cin,
   output sum, cout);

wire [7:0]y;
demux18 dm1 (.d(1'b1),.s0(cin),.s1(b),.s2(a),.y(y));
assign sum=y[1]|y[2]|y[4]|y[7];
assign cout=y[3]|y[5]|y[6]|y[7];
endmodule
