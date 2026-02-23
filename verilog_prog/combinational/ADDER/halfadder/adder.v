module adder (
	input m,n,
	output p,q);

assign p = m^n;
assign q = m&n;

endmodule
