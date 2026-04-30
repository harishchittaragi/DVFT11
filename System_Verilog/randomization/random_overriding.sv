class packet;
   bit [3:0]b;
   int a;

   constraint a_c { soft a==5;}

endclass

module tb();
 packet p;

 initial begin 
    p=new();
    p.randomize()with {a==6;};
    $display("a=%0d",p.a);
 end
 endmodule
