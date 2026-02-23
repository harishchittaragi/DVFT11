module jk_ff(input j,k, input clk,reset, output reg q,output qb);

assign qb=~q;

always @ (posedge clk) begin
   if (reset==0) begin
      q=0;
     // qb=1;
     end
   else 
   case ({j,k})
      2'b00 :begin
         q=q;
        // qb=qb;
      end
      2'b01: begin
         q=0;
        // qb=1;
      end
      2'b10: begin
         q=1;
        // qb=0;
      end
      2'b11: begin
         q=~q;
        // qb=~qb;
      end 
   endcase
end
endmodule
