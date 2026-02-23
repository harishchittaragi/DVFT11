module t_ff (input t, input clk,reset, output reg q,qb);
 always @ (negedge clk or posedge reset) begin
    if (reset) begin
       q=1'b0;
       qb=1'b1;
    end
    else begin
       if (t)begin
        q<=~q;
        qb<=~qb;
       end
       else begin
        q<=q;
        qb<=qb;
       end
    end
 end
endmodule
