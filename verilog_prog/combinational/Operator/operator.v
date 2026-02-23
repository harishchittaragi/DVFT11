module operator(input [3:0]a,b,
   output reg[7:0]y);
always @ (*)begin
//Arithmatic Operations 
  y<=a+b;
#10  y<=a-b;
#10 y<=a*b;
#10  y<=a/b;
#10  y<=a%b;
#10  y<=a**b; 

//Relational Operator
 #10 y<=a>b;
 #10 y<=a<b;
 #10 y<=a>=b;
 #10 y<=a<=b; 

//Logical Operator
 #10 y<=!a;
 #10 y<=a&&b;
 #10 y<=a||b; 

//Equality Operator
 #10 y<=a==b; 
 #10 y<=a!=b; 
 #10 y<=a===b; 
 #10 y<=a!==b; 

//Bitwise Operator
 #10 y<=~a; 
 #10 y<=a&b; 
 #10 y<=a|b; 
 #10 y<=a^b; 
 #10 y<=a~^b; 

//Unary Reduction Operators
 #10 y<=&b; 
 #10 y<=~&b; 
 #10 y<=|b; 
 #10 y<=~|b; 
 #10 y<=^b; 
 #10 y<=~^b; 

//Shift Operator
 #10 y<=a>>1; 
 #10 y<=a<<1; 
 #10 y<=a>>>1; 
 #10 y<=a<<<1; 
// concatination
 #10 y={a,b}; // acts as y[7:4]=a and y[3:0]=b
 
// Replication 
 #10 y={2{a}};
 #10 y={4{2'b01}};
end
endmodule
