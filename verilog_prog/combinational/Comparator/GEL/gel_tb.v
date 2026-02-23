`include "gel.v"
module gel_tb();
reg [3:0]a,b;
wire gt,eq,lt;

gel gel_inst(.a(a),.b(b),.gt(gt),.eq(eq),.lt(lt));
initial begin 
   a=4'd2;b=4'd1;
   #10 a=4'd2;b=4'd2;
   #10 a=4'd1;b=4'd2;
   #10 $finish;
end
initial begin
   $monitor($time,"The Value Of a=%d b=%d gt=%b eq=%b lt=%b g3=%b g2=%b g1=%b g0=%b",a,b,gt,eq,lt,gel_inst.g3,gel_inst.g2,gel_inst.g1,gel_inst.g0);
end
endmodule
