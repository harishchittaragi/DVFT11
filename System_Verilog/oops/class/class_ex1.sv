 class my_class;
    int a;
    function void show();
       $display("a=%0d",a);
    endfunction
 endclass

 module test();
 initial begin
    my_class my_class_h;// handler
    my_class_h=new();// handler become object when we assign memory to the handler.
    my_class_h.a=10;
    my_class_h.show();
 end 
 endmodule
