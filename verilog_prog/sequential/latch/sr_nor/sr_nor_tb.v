`include "sr_nor.v"
module sr_nor_tb();
reg s,r;
wire q,q_bar;
sr_nor sr_nor_inst(.r(r),.s(s),.q(q),.q_bar(q_bar));
initial begin 
       s=0;r=0;
   #10 s=0;r=1;
   #10 s=1;r=0;
   #10 s=1;r=1;
   #10 $finish;
end 
initial begin
   $monitor ($time,"s=%b r=%b q=%b q_bar=%b",s,r,q,q_bar);
end 
endmodule
