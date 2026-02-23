`include "mux21.v"
module mux8121 (input [7:0]a,
                input[2:0]s,
                output y);
wire y1,y2,y3,y4,y5,y6;

mux21 m1(.a0(a[0]),.a1(a[1]),.sel(s[0]),.out(y1));
mux21 m2(.a0(a[2]),.a1(a[3]),.sel(s[0]),.out(y2));
mux21 m3(.a0(a[4]),.a1(a[5]),.sel(s[0]),.out(y3));
mux21 m4(.a0(a[6]),.a1(a[7]),.sel(s[0]),.out(y4));
mux21 m5(.a0(y1),.a1(y2),.sel(s[1]),.out(y5));
mux21 m6(.a0(y3),.a1(y4),.sel(s[1]),.out(y6));
mux21 m7(.a0(y5),.a1(y6),.sel(s[2]),.out(y));

endmodule
