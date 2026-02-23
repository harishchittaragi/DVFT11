`include "mux21.v"
module mux21_tb();
 reg in0,in1,sel;
 wire out;
mux21 mux_inst(in0,in1,sel,out);
initial begin
       sel=0;in0=0;in1=0;
   #10 sel=0;in0=1;in1=0;
   #10 sel=1;in0=0;in1=0;
   #10 sel=1;in0=0;in1=1;
   #10 $finish;
end
initial begin
   $monitor($time,"The value of in0=%d in1=%d sel=%d out=%d",in0,in1,sel,out);
end
endmodule
