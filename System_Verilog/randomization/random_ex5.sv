/* Using Constarints*/

class packet;
   rand int a [15:0];
   rand bit [5:0] b;
   rand bit [3:0] c;
   /*  constraint a_c { foreach (a[i])
                        if (i%2==0)
                           a[i]==1;
                        else 
                           a[i]==0;} // this will assign 1 for even position and 0 for odd position.
      */
     /* same as above code but reduced with % operation */
     /*  constraint a_c { foreach (a[i])
                          if(i[0]==0)
                             a[i]==1;
                          else
                             a[i]==0;} */
    // constraint a_c { foreach (a[i]) a[i] inside {[100:500]};}
    //constraint a_cc{ foreach (a[i]) a[i] dist {[101:200]:/10,[301:350]:/100};}
    //constraint a_cc{ foreach (a[i]) a[i] dist {[101:200]:=10,[301:350]:=100};} 


/* Seeding method of command
  -vcs -full64 -sverilog -R debug_access+all file_name.sv +ntb_random_seed=10,
  -vcs -full64 -sverilog -R debug_access+all file_name.sv +ntb_random_seed_automatic,
  */
endclass

module packet_ex();
packet p_h;

/* Turn on or Turn off of randomization and constraints */ 
initial begin
   p_h=new();
   p_h.rand_mode(0);
   #10
   p_h.rand_mode(1);
end

initial begin
   repeat(15) begin
     // p_h.srandom(1);  //seeding method.
      p_h.randomize();
      $display($time,"a=%0p",p_h.a);
      #2;
      //$display("a=%0p  b=%0d  c=%0d",p_h.a,p_h.b,p_h.c);
   end
end
endmodule
