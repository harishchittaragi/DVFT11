class cov_class;
   bit [31:0] a;
   bit [31:0] b;
   covergroup cg;
      coverpoint a{ bins a_b1 ={[1:20]};}
      coverpoint b{ bins b_b1 ={[12:22]};}
   endgroup

   function new();
      cg= new();
   endfunction

   task run();
      cg.sample();
   endtask
endclass

module cover_tb();
cov_class cg_h1;
cov_class cg_h2;

initial begin 
  cg_h1= new();
   cg_h2=new();
   cg_h1.a=10; cg_h2.a=12;
   cg_h1.run();
   cg_h2.run();
   #10 cg_h1.b=15; cg_h2.b=20;
   cg_h1.run();
   cg_h2.run();
end 
endmodule

