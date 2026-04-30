/* In this Abstarct class we have to write virtual keyword for the class and
* pure virtual keyword for the methods present inside that class and no need
* to write any endfunction/task and no need to create memory for this abstract
* class but we can create handle for this type class because there is no
* instantiaon or any type declaration of that class methods hence no need of
* memory creation.
* then it should be instantiated in its extended class is mandatory like how
* many functions/tasks in abstract, that many methods should instantiate in its
* child class. */

virtual class parent;
  pure virtual function int display1(int a);
  pure virtual function void display2();
  //endfuction   // this line gives error.
endclass

class child extends parent;
   int a;
   function int display1(int a);
      a=a*a;
      $display("a=%0d",a);// it should be written before return statement line.
      return a;
   endfunction
   
   function void display2();
      $display("This is parent class abstract ");
   endfunction
endclass

module abs_class();
parent p_h;
child c_h;
initial begin
   c_h =new();
  // p_h=new();// this line gives error
   c_h.display1(2);
   c_h.display2();
end 
endmodule
