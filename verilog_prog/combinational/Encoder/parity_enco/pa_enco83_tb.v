`include "pa_enco83.v"
module pa_enco83_tb();
reg [7:0]d;
wire [2:0]y;
pa_enco83 enco_inst(.d(d),.y(y));
initial begin
       d=8'bxxxxxxx1;
   #10 d=8'bxxxxxx10;
   #10 d=8'bxxxxx100;
   #10 d=8'bxxxx1000;
   #10 d=8'bxxx10000;
   #10 d=8'bxx100000;
   #10 d=8'bx1000000;
   #10 d=8'b10000000;
   #10 $finish;
end
initial begin
   $monitor ($time,"The value of d=%b y=%b",d,y);
end
endmodule
