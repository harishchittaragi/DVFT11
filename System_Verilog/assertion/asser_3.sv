module assert_3;

//Checking signal should never be X or Z
//logic a;
//initial begin
//      a=1'b0;
//   #5 a=1'b1;
//   #5 a=1'bx;
//   #5 a=1'bz;
//end
//always @ (*) begin
//   assert (!$isunknown(a))
//   else $error("[%0t]  The value of a is unknown",$time);
//end

//Signal should be high after reset
reg a;
reg b;
bit clk;

always #5 clk=~clk;

initial begin
   clk=0;
   repeat(30) begin
      
      a=$random;
      //#5 a=1'bx;
      //#5 b=1'bx;
       b=$random;
      $display("[%0t] a= %0d b=%0d",$time,a,b);
      @(posedge clk);
   end
   #10 $finish;
end
//sequence s1;
//   a&b;
//endsequence
//
//property p1;
//   @(posedge clk)
//   s1;
//endproperty
//assert property (p1);
//
//assert property (@(posedge clk) a&b); //else $error("a and values are low only");

//assert property(@ (posedge clk) $rose(a));
//assert property(@ (posedge clk) $rose(a)& $fell(b));
//assert property(@ (posedge clk) $stable(a));
//assert property(@(posedge clk) $past(a,3));
//assert property(@(posedge clk) $changed(b));
//assert property(@(posedge clk) $isunknown(a));
//assert property(@(posedge clk) $countones(a));
//assert property(@(posedge clk) $onehot(b));
//assert property(@(posedge clk) $onehot0(a));
sequence s2;
   a ##2 b;
endsequence

sequence s3;
   b ##2 a;
endsequence

property p1;
   @(posedge clk)
   s2|=>s3;
endproperty

property p2;
   @(posedge clk)
   s3|->s2;
endproperty

label1: assert property(p1);
label2: assert property(p2);

endmodule
    
