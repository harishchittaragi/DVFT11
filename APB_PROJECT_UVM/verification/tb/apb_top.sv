//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: APB top module that instantiates
//             DUT and interface, generates clock
//             and reset signals, and starts UVM
//             test by configuring virtual interface.
//Date: 08/05/2026 to 15/05/2026.
//*************************************************//

`ifndef _APB_TOP
`define _APB_TOP
import uvm_pkg::*;
`include "uvm_macros.svh"
//importing test package here
import apb_test_package::*;

module apb_top();
   reg pclk,presetn;
   apb_interface intf_h(pclk,presetn);
   apb_slave dut(intf_h);

   always #5 pclk=~pclk;
   initial begin
           pclk = 0;
           presetn = 0;
     #7    presetn = 1;
    // #100  presetn = 0;
    // #20   presetn = 1;
    // #700  presetn = 0;
    // #20   presetn = 1;
    // #300  presetn = 0;
    // #20   presetn = 1;
   end
   initial begin
      `uvm_info("APB_TOP","Before run test",UVM_NONE);
      run_test("apb_test");
   end
   initial begin
      uvm_config_db#(virtual apb_interface)::set(null,"*","vif",intf_h);
   end
endmodule:apb_top
`endif
