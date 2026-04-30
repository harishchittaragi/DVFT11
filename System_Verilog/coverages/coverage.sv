module tb();
int a;
bit clk;

always #5 clk=~clk;
initial begin
   a=0;clk=0;
   #5 a=1;
   #5 a=29;
   #5 a=3;
   #5 a=46;
   #5 a=5;
   #5 a=64;
   #5 a=7;
   #5 a=8;
   #5 a=90;
   #5 a=22;
   #5 a=33;
   #50 $finish;
end

covergroup cg @(posedge clk);
   coverpoint a;
   /*coverpoint a { bins a_name ={1};
                  bins b_name ={2};
                  bins c_name ={3};
                  bins d_name ={4};
                  bins e_name ={5};}*/
 endgroup     

 initial begin
    cg cg_h;
    cg_h =new();
 end
endmodule

