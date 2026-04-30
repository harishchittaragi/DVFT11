module tb();
bit a;
bit [3:0] sel;
bit b;
bit c;
bit d;
bit clk;

//covergroup cg @(posedge clk);
covergroup cg; // instead of writing @(posedge clk) we can use .sample() method in initial begin end                    block.
   /*  These are automatic bins */
 
//  coverpoint sel;
   coverpoint a;
   coverpoint b;
   coverpoint c;
   coverpoint d;

  /* Explicit Bins */
 /* coverpoint sel {bins sel0_b={0,1,2,3};
                  ignore_bins sel1_b={0,1,2,3};
                  illegal_bins sel2_b= {3};}
*/

 /*  Array of bins*/
// coverpoint sel{bins sel[]={0,1,2,3};}
 //coverpoint sel{bins sel[4]={0,1,2,3,4,5,6};}
 coverpoint sel{bins sel[4]={3'b000,3'b001,3'b010,3'b011,3'b100,3'b101,3'b110};}
 endgroup 

always #5 clk=~clk;

/* For .sample() method the object and sample sholud be in same intial begin block
   - object.sample()  can work with coverage where it will snample at particular unit of time only*/
initial begin
   cg cg_h;
   cg_h = new();
       a=0; clk=0;
   #5  a=0; sel=00;
   cg_h.sample();
   #10 a=1; sel=00;
   cg_h.sample();
   #10 b=1; sel=01;
  cg_h.sample();
   #10 c=1; sel=2'b10;
  cg_h.sample();
   #10 d=1; sel=2'b11;
   cg_h.sample();
   #50 $finish;
end

endmodule

