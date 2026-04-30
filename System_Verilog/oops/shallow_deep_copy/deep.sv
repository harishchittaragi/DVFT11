class ab;
 int a;
 int b;
 function ab display1();
  display1=new();
  display1.a=this.a;
  display1.b=this.b;
 return display1;
 endfunction
endclass

class cd;
 int c;
 int d;
 ab ab_h;

 function new ();
    ab_h=new();
 endfunction 

 function cd display2();
  display2=new();
  display2.c=this.c;
  display2.d=this.d;
  display2.ab_h=ab_h.display1();// function calling of class ab.
  return display2;
 endfunction
endclass

module deep();
cd cd_h1,cd_h2;
initial begin
   cd_h1=new();
   cd_h1.c=1;
   cd_h1.d=2;
   cd_h1.ab_h.a=3;
   cd_h1.ab_h.b=4;
   $display("c=%0d  d=%0d  a=%0d  b=%0d",cd_h1.c,cd_h1.d,cd_h1.ab_h.a,cd_h1.ab_h.b);
  // cd_h2=new cd_h1;
   cd_h2=cd_h1.display2();// we have call this function insude module then only separate memory will                            created.
   //cd_h2.ab_h=new cd_h1.ab_h; // this
   cd_h2.c=11;
   cd_h2.d=22;
   cd_h2.ab_h.a=33;
   cd_h2.ab_h.b=44;
   $display("c=%0d  d=%0d  a=%0d  b=%0d",cd_h2.c,cd_h2.d,cd_h2.ab_h.a,cd_h2.ab_h.b);
   $display("c=%0d  d=%0d  a=%0d  b=%0d",cd_h1.c,cd_h1.d,cd_h1.ab_h.a,cd_h1.ab_h.b);
end
endmodule
