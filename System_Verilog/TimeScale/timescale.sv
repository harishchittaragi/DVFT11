`timescale 1ns/100ps
module timescale();
int a=10,b=5,c;

//always #5 clk=~clk;
initial begin 
   $timeformat(-9,2,"ns",4);// it should be always in procedural block.
   c=a*b;
  #5 c=a+b;
  #3.5 c=a%b;
  #2 c=a/b;
  end
  initial begin
     $monitor("[%0t] c=%0d ", $realtime,c);
  end
  endmodule
