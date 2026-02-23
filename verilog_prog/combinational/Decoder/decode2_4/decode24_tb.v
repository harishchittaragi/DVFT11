`include "decode24.v"
module decode24_tb();
reg [1:0]d;
wire [3:0]y;

decode24 decode_inst (.d(d),.y(y));
initial begin 
   d=2'b00;
   #10 d=2'b01;
   #10 d=2'b10;
   #10 d=2'b11;
   #10 $finish;
end 
initial begin
   $monitor($time,"The value of d=%b y=%b",d,y);
end
endmodule
