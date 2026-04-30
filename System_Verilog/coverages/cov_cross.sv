module tb();
bit a;
bit b;

covergroup cg;
   //*****Task 1****  implicit declaration//
 /* cov_impl_a: coverpoint a;
  cov_impl_b: coverpoint b;
  cov_crs: cross cov_impl_a,cov_impl_b;
*/

 //exlicit declaration-task 2//
 cov_exp_a: coverpoint a{bins a_b1={2'd0,2'd1};}
 cov_exp_b: coverpoint b{bins b_b1={2'd0,2'd1};}
 cov_crs: cross cov_exp_a,cov_exp_b{bins cr_a=binsof(cov_exp_a.a_b1)&&binsof(cov_exp_b.b_b1);}

endgroup

initial begin
   cg cg_h=new();
//*********task 1*****//

     a=0;b=0;  cg_h.sample();
 #10 a=0;b=1;  cg_h.sample();
 #10 a=1;b=0;  cg_h.sample();
 #10 a=1;b=1;  cg_h.sample();

 end
 endmodule

   
