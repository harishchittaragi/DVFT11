module t_ff (input t, input clk,reset, output reg q,qb);

 //assign qb=~q;

 //always @ (posedge clk) begin
 //   if (reset==0) begin
 //      q=0;
 //   end

 //   case(t)
 //      1'b0:q=q;
 //      1'b1:q=~q;
 //      default:q=1'bx;
 //   endcase
 //end
 always @(posedge clk) begin
    if (reset==0) begin
       q<=0;
       qb<=1;
    end
    else if (t) begin
       q<=~q;
       qb<=~qb;
    end 
    else begin
       q<=q;
       qb<=qb;
    end
 end
 endmodule
