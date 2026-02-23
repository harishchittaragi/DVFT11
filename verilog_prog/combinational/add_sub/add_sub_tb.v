`include "add_sub.v"
module add_sub_tb();
reg [3:0]a,b;
reg cin;
wire [3:0]sum;
wire carry;

add_sub AS (.a(a),.b(b),.cin(cin),.sum(sum),.carry(carry));
initial begin
   a=4'h5;b=4'h2;cin=1;
end
initial begin
   $monitor($time,"The Value of a=%d b=%d cin=%d sum=%d carry=%d",a,b,cin,sum,carry);
end
endmodule
