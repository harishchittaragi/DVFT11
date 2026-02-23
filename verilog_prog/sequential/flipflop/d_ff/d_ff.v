module d_ff(input d,input clk,reset, output reg q,qb);

//assign qb=~q;
//
//always @(posedge clk) begin
//   if (reset==0) begin
//      q=0;
//      
//   end
//   else begin
//      case(d)
//         1'b0:q=0;
//         1'b1:q=1;
//         default:q=1'bx;
//      endcase
//   end
//end 
always @(posedge clk)
   if (reset==0) begin
      q<=0;
      qb<=1;
   end
   else if (d) begin
      q<=1;
      qb<=0;
   end
   else begin
      q<=q;
      qb<=qb;
   end
endmodule

