class one ;
   extern function int calci();
   extern function int calci1();
   extern function int calci2();
endclass

class two ;
   extern function int calci3();
   extern function int calci4();
   extern function int calci5();
endclass

module extern_class();
one o_h;
two t_h;

initial begin 
   o_h=new();
   t_h=new();
   o_h.calci();
  #10 o_h.calci1();
  #10 o_h.calci2();
  #10 t_h.calci3();
  #10 t_h.calci4();
  #10 t_h.calci5();

end
endmodule

function int one :: calci;
   $display("This is calci Block");
endfunction
function int one :: calci1;
   $display("This is calci1 Block");
endfunction
function int one :: calci2;
   $display("This is calci2 Block");
endfunction
function int two :: calci3;
   $display("This is calci3 Block");
endfunction
function int two :: calci4;
   $display("This is calci4 Block");
endfunction
function int two :: calci5;
   $display("This is calci5 Block");
endfunction



