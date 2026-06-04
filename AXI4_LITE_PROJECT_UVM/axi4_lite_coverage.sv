//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: UVM Coverage Component for AXI4-Lite
//             that collects functional coverage for
//             read and write transactions. It samples
//             address, data, response, and alignment
//             using covergroups and receives
//             transactions via analysis port.
//Date: 25/05/2026 to  29/05/2026.
//*************************************************//

`ifndef AXI4_LITE_COVERAGE_
`define AXI4_LITE_COVERAGE_

class axi4_lite_coverage extends uvm_subscriber #(axi4_lite_seq_item);
   // Factory registration
   `uvm_component_utils(axi4_lite_coverage)

   // Analysis Import declaration:
   uvm_analysis_imp #(axi4_lite_seq_item,axi4_lite_coverage) act_imp;

   // handle declaration for seq_item:
   axi4_lite_seq_item tx;

   //--------------- WRITE CHANNEL COVERGROUP------------------//
   covergroup wr_covergroup;

      // write address range bins
      cp_awaddr : coverpoint tx.awaddr {
         bins low_addr     = {[32'h0000_0000 : 32'h0000_003C]};
         bins mid_addr     = {[32'h0000_0040 : 32'h0000_00BC]};
         bins high_addr    = {[32'h0000_00C0 : 32'h0000_00FF]};
      }

      // write data range bins
      cp_wdata : coverpoint tx.wdata {
         bins low_data     = {[32'h0000_0000 : 32'h7FFF_FFFF]};
         bins high_data    = {[32'h8000_0000 : 32'hFFFE_FFFF]};
      }

      // write response
      cp_bresp : coverpoint tx.bresp {
         bins OKAY         = {2'b00};
      }

      // address alignment check
      cp_awaddr_align : coverpoint tx.awaddr[1:0] {
         bins aligned      = {2'b00};
      }
   endgroup : wr_covergroup

   //---------------READ CHANNEL COVERGROUP---------------//
   covergroup rd_covergroup;

      // read address range bins
      cp_araddr : coverpoint tx.araddr {
         bins low_addr     = {[32'h0000_0000 : 32'h0000_003C]};
         bins mid_addr     = {[32'h0000_0040 : 32'h0000_00BC]};
         bins high_addr    = {[32'h0000_00C0 : 32'h0000_00FF]};
      }

      // read data range bins
      cp_rdata : coverpoint tx.rdata {
         bins low_data     = {[32'h0000_0000 : 32'h7FFF_FFFF]};
         bins high_data    = {[32'h8000_0000 : 32'hFFFF_FFFF]};
      }

      // read response
      cp_rresp : coverpoint tx.rresp {
         bins OKAY         = {2'b00};
      }

      // read address alignment
      cp_araddr_align : coverpoint tx.araddr[1:0] {
         bins aligned      = {2'b00};
      }
   endgroup : rd_covergroup

// FUNCTION NEW BLOCK   
   function new(string name = "axi4_lite_coverage", uvm_component parent = null);
      super.new(name, parent);
      wr_covergroup  = new();
      rd_covergroup  = new();
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      act_imp = new("act_imp",this);
   endfunction:build_phase

   //-------------- WRITE FUNCTION — called by analysis port automatically-------//
   function void write(axi4_lite_seq_item t);
      tx = t;
      if(tx.is_write)
         wr_covergroup.sample();
      else 
         rd_covergroup.sample();
   endfunction : write
endclass : axi4_lite_coverage
`endif
