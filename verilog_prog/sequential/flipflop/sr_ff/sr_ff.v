//module sr_ff(input s,r,
//             input clk,
//             output q,qb);
//wire w1,w2;
//nand n1 (w1,s,clk);
//nand n2 (w2,r,clk);
//nand n3 (q,w1,qb);//assign q=~(w1&qb);
//nand n4 (qb,w2,q);//assign qb=~(w2&q);
//endmodule

// Behavioral
module sr_ff(input s,r,
             input  clk,
             input  reset,
             output reg q,qb);
always @(posedge clk)begin
   if (reset==0) begin //reset is 0 then it is active low else active high that is reset==1;
      q=0;
      qb=1;
   end
   else
      if(s==0&&r==0) begin
         q=q;
         qb=qb;
      end
      else if(s==0&&r==1) begin
         q=0;
         qb=1;
      end
      else if (s==1&&r==0) begin
         q=1;
         qb=0;
      end
      else if (s==1&&r==1) begin
         q=1'bx;
         qb=1'bx;
      end
   end
endmodule
