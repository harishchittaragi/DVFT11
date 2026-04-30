class parent;
   int a=2;
  // logic l;
   function int display();
     // $display("This is Parent Class");
      a=a+a;
      return a;
   endfunction
endclass

class child extends parent;
   int a=10;
   logic l;
   int b;

   function int display(int a);
      //b=super.display();
       b=super.a*this.a*a;// here super.a value assigned from parent class,this.a is from child class                           int a=10 line, and normal "a" from function calling from module.
      //$display("This is Child class");
      b=b*b;
      return b;
   endfunction
endclass

class grandchild extends child;
   int a;
   logic l;
   function void display();
      $display("This is Garndchild Class");
   endfunction 
endclass

module inheritance();
int a;
child child_h;
parent parent_h;

initial begin
   child_h=new();
   parent_h=new();
  //a= child_h.display();
  a= child_h.display(2);

  // child_h.a=17;
  // child_h.l=1'bx;
   $display("a=%0d",a);

end 
endmodule

