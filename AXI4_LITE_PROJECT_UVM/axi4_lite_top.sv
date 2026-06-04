//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: Top module for AXI4-Lite UVM testbench
//             that instantiates DUT, interface, and
//             connects them. It generates clock and
//             reset signals, configures virtual
//             interface using config_db, and starts
//             the UVM test to run the verification
//             environment.
//Date: 25/05/2026 to  29/05/2026.
//*************************************************//

`ifndef AXI4_LITE_TOP_
`define AXI4_LITE_TOP_
// importing uvm_packages & all files including:
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "axi4_lite_interface.sv"
`include "axi4_lite_seq_item.sv"
`include "write_seq.sv"
`include "read_seq.sv"
`include "wr_rd_seq.sv"
`include "slverr_seq.sv"
`include "axi4_lite_sequencer.sv"
`include "axi4_lite_driver.sv"
`include "axi4_lite_act_monitor.sv"
`include "axi4_lite_active_agent.sv"
`include "axi4_lite_sb.sv"
`include "axi4_lite_coverage.sv"
`include "axi4_lite_env.sv"
`include "axi4_lite_test.sv"
`include "design.sv"

module axi4_lite_top();
    reg ACLK,ARESETn;
    axi4_lite_interface intf_h(ACLK,ARESETn);
    // DUT & Interface port connection
    axi4_lite_slave DUT(
       .aclk     (ACLK),
       .aresetn  (ARESETn),
       .awaddr   (intf_h.awaddr),
       .awvalid  (intf_h.awvalid),
       .awready  (intf_h.awready),
       .wdata    (intf_h.wdata),
       .wvalid   (intf_h.wvalid),
       .wready   (intf_h.wready),
       .wstrb    (intf_h.wstrb),
       .bresp    (intf_h.bresp),
       .bvalid   (intf_h.bvalid),
       .bready   (intf_h.bready),
       .araddr   (intf_h.araddr),
       .arvalid  (intf_h.arvalid),
       .arready  (intf_h.arready),
       .rdata    (intf_h.rdata),
       .rresp    (intf_h.rresp),
       .rvalid   (intf_h.rvalid),
       .rready   (intf_h.rready)
    );
    always #5 ACLK = ~ACLK;

    initial begin
             ACLK    = 0;
             ARESETn = 0;
       #7    ARESETn = 1;
       #98   ARESETn = 0;
       #20   ARESETn = 1;
       #750  ARESETn = 0;
       #20   ARESETn = 1;
       #250  ARESETn = 0;
       #20   ARESETn = 1;
       #1180 ARESETn = 0;
       #20   ARESETn = 1;
    end
    initial begin
       run_test("axi4_lite_test");
    end
    initial begin
       uvm_config_db#(virtual axi4_lite_interface)::set(null,"*","vif",intf_h);
    end
endmodule:axi4_lite_top
`endif
