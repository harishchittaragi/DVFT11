import uvm_pkg::*;
`include "uvm_macros.svh"
`include "apb_seq_item.sv"
`include "axi_seq_item.sv"
`include "apb_seq1.sv"
`include "axi_seq1.sv"
`include "apb_seq2.sv"
`include "axi_seq2.sv"
`include "apb_sequencer.sv"
`include "axi_sequencer.sv"
`include "apb_driver.sv"
`include "axi_driver.sv"
`include "apb_agent.sv"
`include "axi_agent.sv"
`include "virtual_sequencer.sv"
`include "env.sv"
`include "virtual_sequence.sv"
`include "test.sv"

module top();
initial begin 
   run_test("test");
end
endmodule:top
