/*-this Dynamic casting is used for classes where as static casting is not
   possible for classes.
  -Dynamic casting is possible for classes of same family and also for different classes.*/

  class parent ;
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
   //gc=ggc;
   if ($cast(gc,ggc)) /* -here $cast(target,source)is dynamic casting.
                         - here child assigned to parent i.e parent can acts as child with any handle                           or object type is possible but not parent assigned to child whereas child                            acting like a parent is impossible  */
      $display("Pass");
   else
      $display("Fail");
   ggc.display();
   gc.display();
end 
endmodule

