`include "fulladder.v"
module rca_tb ();
reg [3:0]a,b;
reg cin;
wire [3:0]sum;
wire carry;
wire [3:1]c;

fulladder FA1 (.a(a[0]), .b(b[0]), .c(cin), .sum(sum[0]), .carry(c[1]));
fulladder FA2 (.a(a[1]), .b(b[1]), .c(c[1]), .sum(sum[1]), .carry(c[2]));
fulladder FA3 (.a(a[2]), .b(b[2]), .c(c[2]), .sum(sum[2]), .carry(c[3]));
fulladder FA4 (.a(a[3]), .b(b[3]), .c(c[3]), .sum(sum[3]), .carry(carry));

initial begin 
   a=4'h3;b=4'h4;cin=0;
   #10 a=4'hA;b=4'h2;cin=1;
   #10 a=4'hB;b=-4'h5;cin=0;
   #10 a=0;b=1;cin=1;
   #10 a=1;b=0;cin=0;
   #10 a=1;b=0;cin=1;
   #10 a=1;b=1;cin=0;
   #10 a=1;b=1;cin=1;
   #10 $finish;
end
initial begin
   $monitor($time,"The value of a=%d b=%d cin=%d sum=%d carry=%d",a,b,cin,sum,carry);
end
endmodule
