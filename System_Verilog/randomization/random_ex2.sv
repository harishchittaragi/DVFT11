class packet;
   rand bit [7:0] a;
   rand bit [3:0] b;
   //randc bit [2:0] b; /* it will cyclically generate new random numbers untill generating all the s                           euence of defined length it will not repeat any number in previous length                            sequence*/
    rand bit [3:0] c;

/* pre randomize and post randomize 
  - by default this two function will be called by .randomize() method only we no need to call this t    wo function separately in module*/

  function void pre_randomize();
     $display("Before Randomizing a=%0d b=%0d c=%0d",a,b,c);
//     a=a+1;
     $display("Before Randomizing upadeted new value  a=%0d b=%0d c=%0d",a,b,c);
  endfunction
  function void post_randomize();
     $display("after Randomizing a=%0d b=%0d c=%0d",a,b,c);
//     b=b+1;
     $display("after Randomizing updated new value a=%0d b=%0d c=%0d",a,b,c);
  endfunction
endclass

module tb();
packet p_h;

initial begin
   p_h=new();
   repeat(10) begin
      p_h.randomize();
      //p_h.randomize(c,a,b); //this method is like only selected variable will be randomized.
      $display("a=%0d  b=%0d  c=%0d", p_h.a,p_h.b,p_h.c);
   end 
end 
endmodule
