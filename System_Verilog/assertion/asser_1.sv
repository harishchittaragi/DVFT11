module assertion_ex();
 reg a,b,c,d;
 reg clk;
 always #5 clk=~clk;

 sequence s1;
    a ##1 b;
 endsequence

 sequence s2;
    a; 
 endsequence

 property p1;
    @(posedge clk)
    s1;
 endproperty

 property p2;
    @(posedge clk)
     s2 |=> b;
  endproperty

 label1: assert property(p1);
 label2: assert property(p2);
 initial begin 
    clk=0;
    a=0;
    b=0;
    @(posedge clk);
    a=1;
    b=0;
    @ (posedge clk);
    a=1;
    b=1;
    @(posedge clk);
    a=1;
    b=0;
    @(posedge clk);
    a=1;
    b=0;
    @(posedge clk);
    a=1;
    b=1;
    @(posedge clk);
    a=1;
    b=1;
    @(posedge clk);
    a=1;
    b=1;
    @(posedge clk);
    a=1;
    b=0;
    @(posedge clk);
    a=1;
    b=0;
    @(posedge clk);
    #10 $finish;
 end
 endmodule
    
