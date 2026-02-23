`include "encoder83.v"
module encoder83_tb ();
reg [7:0]d;
wire [2:0]y;
encoder83 encoder_inst(.d(d),.y(y));
initial begin
    d=8'b00000001;
   #10 d=8'b00000010;
   #10 d=8'b00000100;
   #10 d=8'b00001000;
   #10 d=8'b00010000;
   #10 d=8'b00100000;
   #10 d=8'b01000000;
   #10 d=8'b10000000;
end
initial begin
   $monitor($time,"The Value d=%b y=%b",d,y);
end
endmodule
