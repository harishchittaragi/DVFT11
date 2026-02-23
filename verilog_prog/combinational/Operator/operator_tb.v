`include "operator.v"
module operator_tb();
 reg [3:0]a,b;
 wire [7:0]y;
 operator op_dut(.a(a),.b(b),.y(y));
 initial begin 
    a=4'd5;b=4'd3;
 end 
 initial begin
    $monitor($time,"The Value of a=%b b=%b y=%b",a,b,y);
 end
 endmodule
