`include "half_adder.v"
module full_adder(input a,b,cin,
                  output sum,carry);
wire sum1,carry1,carry2;
half_adder HA1 (.a(a),
                .b(b),
                .sum(sum1),
                .carry(carry1));
half_adder HA2 (.a(sum1),
                .b(cin),
                .sum(sum),
                .carry(carry2));
assign carry=carry1|carry2;
endmodule
