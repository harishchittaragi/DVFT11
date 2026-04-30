//module full_add(input a,b,cin,
//                output sum,carry);
//
//assign sum=a^b^cin;
//assign carry= (a&b) | (b&cin) | (cin&a);
////{carry,sum}= a+b+cin;
//endmodule



/*`include "interface.sv"// if one time we declared in testbecnh means no
need to declare it again here.*/

module full_add(full_add_inter intf);// here we can wirte interface module name and handle in argumen                                        ts section.

/*  all the variables must be start with handle names  */
assign intf.sum=intf.a^intf.b^intf.cin;
assign intf.carry= (intf.a&intf.b) | (intf.b&intf.cin) | (intf.cin&intf.a); 

endmodule

