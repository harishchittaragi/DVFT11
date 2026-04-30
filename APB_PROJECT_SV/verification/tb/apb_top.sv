//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: Top-level APB testbench module responsible
//             for integrating DUT, interface, and test classes.
//             Provides clock/reset generation and executes
//             multiple test scenarios including read, write,
//             error injection, and mixed operations to ensure
//             comprehensive verification of APB protocol behavior.
//Date: 04/03/2026 to  20/04/2026.
//*************************************************//

`ifndef _APB_TOP
`define _APB_TOP
//`include "apb_interface.sv"
//`include "apb_transaction.sv"
//`include "apb_generator.sv"
//`include "apb_driver.sv"
//`include "apb_monitor.sv"
//`include "apb_score_board.sv"
//`include "apb_env.sv"
//`include "apb_test.sv"
//`include "apb_error_test.sv"
//`include "apb_read_test.sv"
//`include "apb_write_test.sv"
//`include "apb_slave_design.sv"

import apb_test_package::*;
module apb_top();
   reg pclk,presetn;
   apb_interface intf_h(pclk,presetn);
   apb_slave dut(intf_h);
   apb_test test_h;
   apb_read_test read_test_h;
   apb_write_test write_test_h;
   apb_error_test error_test_h;
   apb_rw_test rw_h;


   always #5 pclk = ~pclk;

   initial begin
           pclk = 0;
           presetn = 1;
     #3    presetn = 0;
     #12   presetn = 1;
  //   #20   presetn = 0;
  //   #10   presetn = 1;
  //   #40   presetn = 0;
  //   #10   presetn = 1;
  //   #40   presetn = 0;
  //   #10   presetn = 1;
  //   #140  presetn = 0;
  //   #10   presetn = 1;
     #2100 $finish;
   end

   initial begin
// error_test
   test_h=new(intf_h);
   $display($time,"   entering error operation");
   error_test_h=new(intf_h);
   test_h=error_test_h;
   test_h.run();

// Write Test:
   $display($time,"   entering write operation");
   write_test_h=new(intf_h);
   test_h=write_test_h;
   test_h.run();
   
// Read Test
   $display($time,"   entering read operation");
   read_test_h=new(intf_h);
   test_h=read_test_h;
   test_h.run();

// read_write_test:
   $display($time,"  Entering rw operation");
   rw_h=new(intf_h);
   test_h=rw_h;
   test_h.run();
   end
endmodule:apb_top
`endif
