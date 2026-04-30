//module packed_array();
//bit [3:0][4:0]a ;// here we can do anytype of slicing using bit data type 
//initial begin
//   a[2][0]=5;
//   //$display("a=%b",a);
// foreach (a[i,j])
//   $display("a[i=%0d][j=%0d]=%0d",i,j,a[i][j]);
//end
//endmodule

module packed_array();
byte a; //here we cant be able to do slicing as byte is paked data type.
initial begin
   a[2]=5; //here we cant assign any value in 2d location
   $display("a=%b",a);
 //foreach (a[i,j])
  // $display("a[i=%0d][j=%0d]=%0d",i,j,a[i][j]);
end
endmodule
// in similar for int, shortint and longint also not possible for slicing
