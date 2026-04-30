/*- The main Points to remember here are:
    1. There is one parent clas & more than 2 / 3 child classes with same extends from parent 
    2. OVERRIDING 
        -   we have same function name in all classes with equal number of arguments that must match
    3. it should of inheritance type
    4. include Handle Assignments(dynamic_casting also possible).
    5. virtual Keyword
        - if write this virtual key word in in parent class method only then
           :- always last virtual method will execute.
           :- by default all other extended class methods become virtual type. 
           :- first non virtual method execute everytime.      */

class parent ;
  // virtual  function void display();
     function void display();
        $display("This is Parent class");
     endfunction
  endclass

  class child extends parent;
     function void display();
        $display("This is Child class");
     endfunction
  endclass

  class grand_child extends child;
     function void display();
        $display("This is Grand Child class");
     endfunction
  endclass

  class grand_grand_child extends grand_child;
     function void display();
        $display("This is GGC class");
     endfunction
  endclass

module dynamic_casting();
parent p;
child c;
grand_child gc;
grand_grand_child ggc;

initial begin
   ggc=new();

   //gc=new();
   // $cast(gc,ggc);// same as gc=ggc;

   gc=ggc; // Handle assignment with inheritance type,($cast(gc,ggc)
   c=ggc;
   p=ggc;
   /*  ggc=gc is impossible untill defining some memory for gc externally as
       gc=new()  */
   ggc.display();
   gc.display();
   c.display();
   p.display();
end
endmodule

