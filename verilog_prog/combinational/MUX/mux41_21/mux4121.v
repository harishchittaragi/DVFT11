`include "mux21.v"
module mux4121(input a0,a1,a2,a3,s0,s1,
               output out);
wire out1,out2;
mux21 mux1 (.in0(a0),
            .in1(a1),
            .sel(s0),
            .out(out1));
mux21 mux2 (.in0(a2),
            .in1(a3),
            .sel(s0),
            .out(out2));
mux21 mux3 (.in0(out1),
            .in1(out2),
            .sel(s1),
            .out(out));
endmodule
