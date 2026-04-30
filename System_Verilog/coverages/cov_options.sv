module cov_options();
bit [15:0] a;
bit [15:0] b;
covergroup cg;
   option.per_instance=1;
   //option.at_least=2;
   //option.goal=50; 
   //option.weight=4;
   //option.comment="This is Covergroup"; 
   //option.auto_bin_max=128;
   //option.detect_overlap=1;  //the value should be boolean always
   //option.cross_auto_bin_max=256;
   //option.cross_num_print_missing=156;  //in missing column
   coverpoint a{bins a_b1={[1:3]};
                bins a_b2={[4:8]};}
   coverpoint b{bins b_b1={[3:6]};
                bins b_b2={[7:10]};}
endgroup

initial begin
   cg cg_h1=new();
   cg cg_h2=new();
      a=2; b=4; cg_h1.sample();
   #5 a=5; b=7; cg_h1.sample();
      $display("The coverage of cg_h1=%e",cg_h1.get_coverage());
   #5 a=4; b=9; cg_h2.sample();
   #5 a=5; b=3; cg_h2.sample();
   #5 a=1; b=7; cg_h2.sample();
      $display("The coverage of cg_h2=%e",cg_h2.get_coverage());
end
endmodule


/*
The coverage of cg_h1=1.000000e+02  this means 100% ((e+02) e=10 its 10 power 2  then 100x1.000)
The coverage of cg_h2=1.000000e+02
  */ 
