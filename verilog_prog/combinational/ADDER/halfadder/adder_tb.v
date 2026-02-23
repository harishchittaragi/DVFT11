`include "adder.v"
module adder_tb;
reg a,b;
wire s,c;
adder adder_inst (.m(a),
                  .n(b),
                  .p(s),
                  .q(c));
initial begin
   $monitor("The Time=%0t value of a=%d b=%d s=%d c=%d",$time,a,b,s,c);
   a=0;b=0;
   #10
   a=0;b=1;
   #10
   a=1;b=0;
   #10
   a=1;b=1;
   #10
   $finish;
end
endmodule
