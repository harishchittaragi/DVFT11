//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: UVM Scoreboard for AXI4-Lite that
//             receives transactions from monitor,
//             performs write and read checks on
//             response and address alignment,
//             stores transactions, and executes
//             cross-checking between write and
//             read data to verify data integrity.
//             It also reports pass/fail statistics.
//Date: 25/05/2026 to  29/05/2026.
//*************************************************//

`ifndef AXI4_LITE_SCOREBOARD_
`define AXI4_LITE_SCOREBOARD_

class axi4_lite_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(axi4_lite_scoreboard)

   // analysis imp to receive from monitor
   uvm_analysis_imp #(axi4_lite_seq_item, axi4_lite_scoreboard) act_imp;

   // internal queues to store write and read transactions
   axi4_lite_seq_item wr_q[$];
   axi4_lite_seq_item rd_q[$];

   // counters
   int wr_pass, wr_fail;
   int rd_pass, rd_fail;
   int total_pass, total_fail;

   function new(string name = "axi4_lite_scoreboard", uvm_component parent = null);
      super.new(name, parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      act_imp = new("act_imp", this);
   endfunction:build_phase

   // called everytime monitor writes to analysis port
   function void write(axi4_lite_seq_item tx);
      if(tx.is_write)
         check_write(tx);
      else
         check_read(tx);
   endfunction:write

   //----------WRITE CHECK----------//
   function void check_write(axi4_lite_seq_item tx);
      `uvm_info("[SB]", $sformatf("WRITE TX received : awaddr=0x%0h wdata=0x%0h bresp=%0b",
                tx.awaddr, tx.wdata, tx.bresp), UVM_NONE);

      // check1:bresp
      if(tx.bresp == 2'b00) begin
         `uvm_info("[SB]", $sformatf("WRITE PASS : awaddr=0x%0h wdata=0x%0h bresp=OKAY",
                   tx.awaddr, tx.wdata), UVM_NONE);
         wr_pass++;
      end
      else begin
         `uvm_error("[SB]", $sformatf("WRITE FAIL : awaddr=0x%0h wdata=0x%0h bresp=0x%0b EXPECTED=2'b00",tx.awaddr, tx.wdata, tx.bresp));
         wr_fail++;
      end

      // check 2:address (here adsress alignment checking)
      if(tx.awaddr[1:0] != 2'b00) begin
         `uvm_error("[SB]", $sformatf("WRITE ADDR ALIGN FAIL : awaddr=0x%0h is not 4-byte aligned",
                    tx.awaddr));
         wr_fail++;
      end
      else begin
         `uvm_info("[SB]", $sformatf("WRITE ADDR ALIGN PASS : awaddr=0x%0h is 4-byte aligned",
                   tx.awaddr), UVM_NONE);
      end

      // storing transaction for reference
      wr_q.push_back(tx);
   endfunction:check_write

   //----------READ CHECK----------//
   function void check_read(axi4_lite_seq_item tx);
      `uvm_info("[SB]", $sformatf("READ TX received : araddr=0x%0h rdata=0x%0h rresp=%0b",
                tx.araddr, tx.rdata, tx.rresp), UVM_NONE);

      // check 1 — rresp must be OKAY (2'b00)
      if(tx.rresp == 2'b00) begin
         `uvm_info("[SB]", $sformatf("READ PASS : araddr=0x%0h rdata=0x%0h rresp=OKAY",
                   tx.araddr, tx.rdata), UVM_NONE);
         rd_pass++;
      end
      else begin
         `uvm_error("[SB]", $sformatf("READ FAIL : araddr=0x%0h rdata=0x%0h rresp=0x%0b EXPECTED=2'b00",
                    tx.araddr, tx.rdata, tx.rresp));
         rd_fail++;
      end

      // check 2 — address must be 4 byte aligned
      if(tx.araddr[1:0] != 2'b00) begin
         `uvm_error("[SB]", $sformatf("READ ADDR ALIGN FAIL : araddr=0x%0h is not 4-byte aligned",
                    tx.araddr));
         rd_fail++;
      end
      else begin
         `uvm_info("[SB]", $sformatf("READ ADDR ALIGN PASS : araddr=0x%0h is 4-byte aligned",
                   tx.araddr), UVM_NONE);
      end

      // store transaction for reference
      rd_q.push_back(tx);
   endfunction:check_read

   //----------WRITE vs READ CROSS CHECK----------//
   function void cross_check();
      axi4_lite_seq_item wr_tx, rd_tx;
      `uvm_info("[SB]","Starting Write vs Read cross check",UVM_NONE);

      foreach(rd_q[i]) begin
         rd_tx = rd_q[i];
         foreach(wr_q[j]) begin
            wr_tx = wr_q[j];
            // find matching address
            if(rd_tx.araddr == wr_tx.awaddr) begin
               if(rd_tx.rdata == wr_tx.wdata) begin
                  `uvm_info("[SB]", $sformatf(
                     "CROSS CHECK PASS : addr=0x%0h wdata=0x%0h rdata=0x%0h MATCH",
                     wr_tx.awaddr, wr_tx.wdata, rd_tx.rdata), UVM_NONE);
                  total_pass++;
               end
               else begin
                  `uvm_info("[SB]", $sformatf(
                     "CROSS CHECK FAIL : addr=0x%0h wdata=0x%0h rdata=0x%0h MISMATCH",
                     wr_tx.awaddr, wr_tx.wdata, rd_tx.rdata),UVM_HIGH);
                  total_fail++;
               end
               break;
            end
         end
      end
   endfunction:cross_check

   //----------REPORT PHASE----------//
   function void report_phase(uvm_phase phase);
      cross_check();
      `uvm_info("[SB]","===============================================",UVM_NONE);
      `uvm_info("[SB]","            SCOREBOARD REPORT                 ",UVM_NONE);
      `uvm_info("[SB]","===============================================",UVM_NONE);
      `uvm_info("[SB]",$sformatf("WRITE  : PASS = %0d  FAIL = %0d", wr_pass, wr_fail),  UVM_NONE);
      `uvm_info("[SB]",$sformatf("READ   : PASS = %0d  FAIL = %0d", rd_pass, rd_fail),  UVM_NONE);
      `uvm_info("[SB]",$sformatf("CROSS  : PASS = %0d  FAIL = %0d", total_pass, total_fail), UVM_NONE);
      `uvm_info("[SB]","===============================================",UVM_NONE);
   endfunction:report_phase
endclass:axi4_lite_scoreboard
`endif
