`include "encoder42.v"
module encoder42_tb();
reg [3:0]d;
wire [1:0]y;

encoder42 encoder_dut(.d(d),.y(y));
initial begin
   d=4'b0000;
   #10 d=4'b0001;
   #10 d=4'b0010;
   #10 d=4'b0100;
   #10 d=4'b1000;
   #10 $finish;
end
initial begin
   $monitor($time,"The value of d=%b y=%b",d,y);
end
endmodule
