class parent;
protected int a=5;
task display();
   $display(a);
   $display("This is parent property");
endtask
endclass

class child extends parent;
int a1=10;
task display();
   super.display();
   $display(a);
   $display(a1);
   $display("This is child built property");
endtask
endclass

class grand_child extends child;
int a2=15;
task display();
   super.display();
   $display(a);
   $display(a1);
   $display(a2);
   $display("This is Grand child built property");
endtask
endclass

class grand_grand_child extends grand_child;
  int a3=20;
  task display();
   super.display();
   $display(a);
   $display(a1);
   $display(a2);
   $display(a3);
   $display("This is GGC field");
  endtask
endclass

module encap();
parent p;
child c;
grand_child gc;
grand_grand_child ggc;

initial begin
//p=new();
//c=new();
//gc=new();
ggc= new();
//p.display();
//c.display();
//gc.display();
ggc.display();

end
endmodule
//NOTE: protected members we can access through its extended classes but not
      //not through modules.
