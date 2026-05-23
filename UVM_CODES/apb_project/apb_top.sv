//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: This is Test_Bench File.
//Date: 04/03/2026 to  / /2026.
//*************************************************//
//`timescale 1ns/1ps
`ifndef _APB_TOP
`define _APB_TOP
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "apb_interface.sv"
`include "apb_sequence_item.sv"
`include "apb_error_seq.sv"
`include "apb_read_seq.sv"
`include "apb_write_seq.sv"
`include "apb_rw_seq.sv"
`include "apb_con_psel_seq.sv"
`include "apb_sequencer.sv"
`include "apb_driver.sv"
`include "apb_active_monitor.sv"
`include "apb_passive_monitor.sv"
`include "apb_active_agent.sv"
`include "apb_passive_agent.sv"
`include "apb_score_board.sv"
`include "apb_coverage.sv"
`include "apb_env.sv"
`include "apb_test.sv"
`include "apb_slave_design.sv"

module apb_top();
   reg pclk,presetn;
   apb_interface intf_h(pclk,presetn);
   apb_slave dut(intf_h);
   always #5 pclk=~pclk;
    initial begin
         pclk = 0;
         presetn = 0;
     #7  presetn = 1;
     #100  presetn = 0;
     #20  presetn = 1;
//     #12 presetn = 1;
end
initial begin
     run_test("apb_test");
   end
   initial begin
      uvm_config_db#(virtual apb_interface)::set(null,"*","vif",intf_h);
   end

endmodule:apb_top
`endif




//module apb_top();
//   reg pclk,presetn;
//   apb_interface intf_h(pclk,presetn);
//   apb_slave dut(intf_h);
//   apb_test test_h;
//   apb_read_seq read_test_h;
//   apb_write_seq write_test_h;
//   apb_error_seq error_test_h;
//   apb_rw_seq rw_h;
//
//
//   always #5 pclk = ~pclk;
//
//   initial begin
//           pclk = 0;
//           presetn = 1;
//     #3    presetn = 0;
//     #12   presetn = 1;
//  //   #20   presetn = 0;
//  //   #10   presetn = 1;
//  //   #40   presetn = 0;
//  //   #10   presetn = 1;
//  //   #40   presetn = 0;
//  //   #10   presetn = 1;
//  //   #140  presetn = 0;
//  //   #10   presetn = 1;
//     #2100 $finish;
//   end
//
//   initial begin
//// error_test
//   test_h=new(intf_h);
//   $display($time,"   entering error operation");
//   error_test_h=new(intf_h);
//   test_h=error_test_h;
//   test_h.run();
//
//// Write Test:
//   $display($time,"   entering write operation");
//   write_test_h=new(intf_h);
//   test_h=write_test_h;
//   test_h.run();
//   
//// Read Test
//   $display($time,"   entering read operation");
//   read_test_h=new(intf_h);
//   test_h=read_test_h;
//   test_h.run();
//
//// read_write_test:
//   $display($time,"  Entering rw operation");
//   rw_h=new(intf_h);
//   test_h=rw_h;
//   test_h.run();
//   end
//endmodule:apb_top
//`endif
