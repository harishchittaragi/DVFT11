`include "mux41.v"
module full_adder41(input a,b,cin,
                    output sum, cout);
mux41 sum_mux(.a0(cin),.a1(~cin),.a2(~cin),.a3(cin),.s0(b),.s1(a),.out(sum));

mux41 carry_mux(.a0(1'b0),.a1(cin),.a2(cin),.a3(1'b1),.s0(b),.s1(a),.out(cout));
endmodule
