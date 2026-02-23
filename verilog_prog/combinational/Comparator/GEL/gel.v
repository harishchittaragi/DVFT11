module gel(input [3:0]a,b,
           output reg gt,eq,lt);
wire g3,g2,g1,g0;
assign g3=a[3]~^b[3];
assign g2=a[2]~^b[2];
assign g1=a[1]~^b[1];
assign g0=a[0]~^b[0];
//
//assign eq=g3&g2&g1&g0;
//assign gt=(a[3]&~b[3])|(g3&(a[2]&~b[2]))|(g3&g2&(a[1]&~b[1]))|(g3&g2&g1&(a[0]&~b[0]));
//assign lt=(~a[3]&b[3])|(g3&(~a[2]&b[2]))|(g3&g2&(~a[1]&b[1]))|(g3&g2&g1&(~a[0]&b[0]));

always @(*) begin
  if (a>b) begin 
    gt=1'b1;
    eq=1'b0; 
    lt=1'b0;
    end
  else if (a==b) begin
    eq=1'b1; 
    gt=1'b0; 
    lt=1'b0;
    end
  else begin
    lt=1'b1;  
    gt=1'b0;
    eq=1'b0;
    end
end
endmodule
