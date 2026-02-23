`include "mux21.v" 
`include "mux41.v"
module mux8141 (
   input [7:0]d,
   input [2:0]s,
   output  y);
wire y1,y2;
//mux41 m41(.a[0](d[0]),.a[1](d[1]),.a[2](d[2]),.a[3](d[3]),.s[0](s[0]),.s[1](s[1]),.out(y1));
//mux41 m42(.a[0](d[4]),.a[1](d[5]),.a[2](d[6]),.a[3](d[7]),.s[0](s[0]),.s[1](s[1]),.out(y2));
//mux21 m21 (.in0(y1),.in1(y2),.sel(s[3]),.out(y));
mux41 m1 (.a(d[3:0]),.s(s[1:0]),.out(y1));
mux41 m2 (.a(d[7:4]),.s(s[1:0]),.out(y2));
mux21 m3 (.in0(y1),.in1(y2),.sel(s[2]),.out(y));


endmodule
