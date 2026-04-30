class packet;
   rand int a [15:0];
   rand bit [5:0] b;
   rand bit [3:0] c;
    rand   int y;
       constraint b_c {b inside {1,2,3,4,5,6,7};}
 constraint a_c{ foreach(a[i])
                      a[i]==mul(b);}
    function int mul( int y);
       int z;
       z=y+10;
       return y;
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
