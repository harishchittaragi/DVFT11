module unpacked_array();
bit a [3:0][4:0];
initial begin
   a[2][1]='d5;
   //$display("a=%0p",a);
foreach (a[i,j])
  $display("a[i=%0d][j=%0d]=%0d",i,j,a[i][j]);
end
endmodule

