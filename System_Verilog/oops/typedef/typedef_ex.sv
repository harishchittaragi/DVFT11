module typedef_ex();

//typedef bit[4:0] a;// now "a" becomes   5 bit variable.
//a a_v_t; //a is a newdatatype  and a_v_t is a variable.
//initial begin
//   a_v_t=5'd5;
//   $display("the value of a_v_tis =%0d",a_v_t);
//end

typedef bit[7:0] a [7:0];
a mem[2:0];

initial begin
   mem[0][0]=8'd2;
   $display("mem=%p",mem);
   $display("mem=%b",mem[0][0][0]);
   $display("mem=%b",mem[0][0][1]);
   $display("mem=%b",mem[0][1][0]);
   $display("mem=%b",mem[0][1][1]);
   //$display("mem=%b",mem[1][0][1]);
   //$display("mem=%b",mem[1][1][0]);
end

//string s="a";
//int i;
//initial begin
//   i=bit'(s);
//   $display(i);
//end
endmodule

