`include "fulladder.v"
module add_sub (a,b,cin,sum,carry);
input [3:0] a,b;
input cin;
output [3:0]sum;
output carry;
wire [3:1]c;
wire [3:0]w;

xor x1 (w[0],b[0],cin);
xor x2 (w[1],b[1],cin);
xor x3 (w[2],b[2],cin);
xor x4 (w[3],b[3],cin);

fulladder FA1 (.a(a[0]), .b(w[0]), .c(cin),  .sum(sum[0]), .carry(c[1]));
fulladder FA2 (.a(a[1]), .b(w[1]), .c(c[1]), .sum(sum[1]), .carry(c[2]));
fulladder FA3 (.a(a[2]), .b(w[2]), .c(c[2]), .sum(sum[2]), .carry(c[3]));
fulladder FA4 (.a(a[3]), .b(w[3]), .c(c[3]), .sum(sum[3]), .carry(carry));
endmodule

