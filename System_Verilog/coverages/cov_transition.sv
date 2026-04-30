/*This is transition coverage we can use these methods in FSM mostly*/
module tb();
bit [3:0] a;

covergroup cg;
  // coverpoint a;
   coverpoint a {bins tc1 =(1=>2=>3); //specifies the transition 1=>2=>3;
                bins tc2 =(1,2=>2,3);// 1=>2 or 1=>3 or 2=>2 or 2=>3;
                bins tc3 =(1=>2[*2]=>3);// 1=>2=>2=>3 consecutive repetation;
                bins tc4 =(1=>2[*2:3]=>4);//1=>2=>2=>4  or 1=>2=>2=>2=>4; consecutive repetation;
                bins tc5 =(1=>2[=2]=>3);//1...=>2...=>2...=>3 non consecutive repetation;
                bins tc6 =(2[->3]);// go to repetation ..=>2..=>2...=>2;
                bins tc7 =(1=>2[->3]=>4);} //1..=>2...=>2...=>2=>4;
endgroup
initial begin 
   cg cg_h=new();
   //tc1
       a=4'd0; cg_h.sample();
   #10 a=4'd1; cg_h.sample();
   #10 a=4'd2; cg_h.sample();
   #10 a=4'd3; cg_h.sample();

   //tc2
   #10 a=4'd1; cg_h.sample();
   #10 a=4'd2; cg_h.sample();
   #10 a=4'd2; cg_h.sample();
   #10 a=4'd3; cg_h.sample();
   #10 a=4'd1; cg_h.sample();
   #10 a=4'd3; cg_h.sample();

   //tc3
   #10 a=4'd1;cg_h.sample();
   #10 a=4'd2;cg_h.sample();
   #10 a=4'd2;cg_h.sample();
   #10 a=4'd3;cg_h.sample();
   
   //tc4
   #10 a=4'd1;cg_h.sample();
   #10 a=4'd2;cg_h.sample();
   #10 a=4'd2;cg_h.sample();
   #10 a=4'd2;cg_h.sample();
   #10 a=4'd4;cg_h.sample();
   
   //tc5
   #10 a=4'd1;cg_h.sample();
   #10 a=4'd3;cg_h.sample();
   #10 a=4'd2;cg_h.sample();
   #10 a=4'd4;cg_h.sample();
   #10 a=4'd5;cg_h.sample();
   #10 a=4'd2;cg_h.sample();
   #10 a=4'd1;cg_h.sample();
   #10 a=4'd3;cg_h.sample();
   
   //tc6
   #10 a=4'd2;cg_h.sample();
   #10 a=4'd1;cg_h.sample();
   #10 a=4'd2;cg_h.sample();
   #10 a=4'd1;cg_h.sample();
   #10 a=4'd2;cg_h.sample();
   
   //tc7
   #10 a=4'd1;cg_h.sample();
   #10 a=4'd1;cg_h.sample();
   #10 a=4'd2;cg_h.sample();
   #10 a=4'd1;cg_h.sample();
   #10 a=4'd2;cg_h.sample();
   #10 a=4'd4;cg_h.sample();
end
endmodule
