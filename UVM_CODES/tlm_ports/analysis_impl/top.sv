import uvm_pkg ::*;
`include "uvm_macros.svh"
`include "transaction.sv"
`include "consumer_b.sv"
`include "consumer_a.sv"
`include "producer.sv"
`include "env.sv"
`include "test.sv"
module top();
initial begin
   run_test("test");
end
endmodule

