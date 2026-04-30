module mixed_array();
bit [4:0][3:0] a[2:0][1:0];
 
initial begin
   a[0][1][0][1]='d5;
   //$display("a[0][0][0][0]=%d",a[0][1][0][1]);
   foreach (a[i,j,k,l])
   $display("a[%0d][%0d][%0d][%0d]=%0d",i,j,k,l,a[i][j][k][l]);
   
end
endmodule
