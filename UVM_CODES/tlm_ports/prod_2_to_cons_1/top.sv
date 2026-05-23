import uvm_pkg ::*;
`include "uvm_macros.svh"
`include "transaction.sv"
`include "consumer.sv"
`include "producer_a.sv"
`include "producer_b.sv"
`include "env.sv"
`include "test.sv"
module top();
initial begin
   run_test("test");
end
endmodule

