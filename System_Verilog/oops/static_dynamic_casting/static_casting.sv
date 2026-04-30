module static_cast();
//int a=65;
//string s;
//initial begin
// //Warning-[ICTA-SI] Incompatible complex type
// //static_casting.sv, 5
// //static_cast
// //  Incompatible complex type assignment
// //  Type of source expression is incompatible with type of target expression. 
// //  Mismatching types cannot be used in assignments, initializations and 
// //  instantiations. The type of the target is 'string', while the type of the 
// //  source is 'int'.
// //  Source Expression: a
// //  Please use string cast while assigning an integral type to a string 
// //  variable.
// s=a;
// $display(s);
//end

// Therefore we using static casting like below.
int a=65;
string s;
initial begin
   s=string'(a);//  static casting.
   $display(s);
end
endmodule
