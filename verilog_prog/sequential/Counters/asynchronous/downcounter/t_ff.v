module t_ff (input t, input clk,reset, output reg q, qb);
 always @ (posedge clk or posedge reset) begin

    if (reset) begin
       q=0;
       qb=1;  
    end

    else if(t) begin
       q=~q;
       qb=~qb;
       end
       else begin
          q=q;
          qb=qb;
       end
end
endmodule
