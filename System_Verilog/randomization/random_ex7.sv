/*Even Number Generation using function */
class packet;
   rand int a;
   constraint c1{a==make_even();}
   function int make_even();
      int x;
      x=$urandom_range(1,20);
      $display("x=%0d",x);
      return x*2;// we can get anything that is multiplication of this 2 or 3 or 4 ....
   endfunction
endclass
 module tb();
 packet p;
 initial begin
    p=new();
    repeat(25) begin
       p.srandom(12);
    p.randomize();
    $display ("a=%p",p.a);
 end
 end
 endmodule


/* Array Values using Function */
/*class packet;
   rand int a[16];
   constraint c1{foreach (a[i])
                   a[i]==value(i);}

 function int value(int i);
    return i+20;
 endfunction
 endclass

 module tb();
 packet p;
 initial begin
    p=new();
    p.randomize();
    $display("a=%p",p.a);
 end
 endmodule
*/

/* Function with condition*/
/*class packet;
   rand int a;
   rand bit [5:0]s;
   constraint c1 {s==func();}

   function int func();
      int x=5;
      if (x>3)
         return 20;
      else
         return 10;
   endfunction
endclass
module tb();
packet p;
initial begin
   p=new();
   p.randomize();
   p.a=int'(p.s);
   $display("a=%0d",p.a);
end
endmodule
*/
