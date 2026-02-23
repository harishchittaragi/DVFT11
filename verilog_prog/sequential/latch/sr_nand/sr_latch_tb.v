`include "sr_latch.v"
module sr_latch_tb();
reg s_bar,r_bar;
wire q,q_bar;
sr_latch sr_latch_inst(.s_bar(s_bar),.r_bar(r_bar),.q(q),.q_bar(q_bar));
initial begin
        s_bar=0;r_bar=0;
   #10  s_bar=0;r_bar=1; 
   #10  s_bar=1;r_bar=0;  
   #10  s_bar=1;r_bar=1;
   #10 $finish;
end
initial begin
   $monitor($time,"s_bar=%b r_bar=%b q=%b q_bar=%b",s_bar,r_bar,q,q_bar);
end
endmodule

//module sr_latch_tb();
//reg r,s;
//wire q,q_bar;
//sr_latch sr_inst (.r(r),.s(s),.q(q),.q_bar(q_bar));
//initial begin
//  r=1;s=1;
//  #10 r=1;s=0;
//  #10 r=0;s=1;
//  #10 r=0;s=0;
//  #10 $finish;
//  end 
//initial begin
//   $monitor($time,"__r=%b s=%b q=%b q_bar=%b",r,s,q,q_bar);
//end
//endmodule
