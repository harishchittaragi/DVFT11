//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: UVM Monitor for AXI4-Lite protocol
//             that passively observes DUT signals,
//             captures AW, W, B, AR, and R channel
//             handshakes, reconstructs complete
//             read and write transactions, and
//             sends them via analysis port for
//             checking and coverage collection.
//Date: 25/05/2026 to  29/05/2026.
//*************************************************//

`ifndef AXI4_LITE_ACT_MONITOR_
`define AXI4_LITE_ACT_MONITOR_
class axi4_lite_act_monitor extends uvm_monitor;
   // factory registration:
   `uvm_component_utils(axi4_lite_act_monitor)
   
   // Virtual interface handle declaration
   virtual axi4_lite_interface vif;

   // Analysis Port declaration
   uvm_analysis_port #(axi4_lite_seq_item) act_ap;

   //Queues for write reconstruction
   bit[31:0] aw_q[$];
   bit[31:0] dw_q[$];

   //Queue for read reconstruction
   bit[31:0] ar_q[$];

   function new(string name ="axi4_lite_act_monitor", uvm_component parent = null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db #(virtual axi4_lite_interface)::get(this,"","vif",vif))
         `uvm_fatal("NO_VIF","Virtual interface not found in config_db of [ACT_MON]");
      act_ap=new("act_ap",this);
   endfunction:build_phase

   task run_phase(uvm_phase phase);
      fork
         monitor_write();
         monitor_read();
      join_none
   endtask:run_phase

   
//-------------WRITE MONITOR----------//
task monitor_write();
   axi4_lite_seq_item wr_tx;
   forever begin
      @(vif.mon_cb);
      if(!vif.ARESETn || $isunknown(vif.ARESETn)) begin
         aw_q.delete();
         dw_q.delete();
         continue;
      end
      //---------AW channel--------//
      if(vif.mon_cb.awvalid && vif.mon_cb.awready) begin
         aw_q.push_back(vif.mon_cb.awaddr);
         `uvm_info("MON_AW",$sformatf("AW Captured : waddr 0x%0h", vif.mon_cb.awaddr),UVM_NONE);
      end

      //---------DW Channel--------//
      if(vif.mon_cb.wvalid && vif.mon_cb.wready) begin
         dw_q.push_back(vif.mon_cb.wdata);
         `uvm_info("MON_AW",$sformatf("DW Captured : wdata 0x%0h", vif.mon_cb.wdata),UVM_NONE);
      end

      //--------B channel--------//
      if(vif.mon_cb.bvalid && vif.mon_cb.bready) begin
         wr_tx = axi4_lite_seq_item::type_id::create("wr_tx");
         wr_tx.is_write = 1;
         if(aw_q.size()>0)
            wr_tx.awaddr = aw_q.pop_front();
         if(dw_q.size()>0)
            wr_tx.wdata = dw_q.pop_front();
         wr_tx.bresp= vif.mon_cb.bresp;
         `uvm_info("MON_WRITE_TX",
            $sformatf("WRITE_TX : awaddr = 0x%0h, wdata= 0x%0h, bresp =%0h",
            wr_tx.awaddr,wr_tx.wdata,wr_tx.bresp),UVM_NONE);
         act_ap.write(wr_tx);
      end
   end
endtask:monitor_write

//-----Read Monitor--------//
task monitor_read();
   axi4_lite_seq_item rd_tx;
   forever begin
      @(vif.mon_cb);
      if(!vif.ARESETn || $isunknown(vif.ARESETn)) begin
         ar_q.delete();
         continue;
      end
      //---------AR channel--------//
      if(vif.mon_cb.arvalid && vif.mon_cb.arready) begin
         ar_q.push_back(vif.mon_cb.araddr);
         `uvm_info("MON_AR",$sformatf("AR Captured araddr= 0x%0h",vif.mon_cb.araddr),UVM_NONE);
      end
      //-----------R channel-------//
      if(vif.mon_cb.rvalid && vif.mon_cb.rready) begin
         rd_tx = axi4_lite_seq_item::type_id::create("rd_tx");
         if(ar_q.size()>0) begin
            rd_tx.araddr = ar_q.pop_front();
            rd_tx.is_write = 0;
            rd_tx.rdata = vif.mon_cb.rdata;
            rd_tx.rresp = vif.mon_cb.rresp;
            `uvm_info("MON_RD_TX",
               $sformatf("READ_TX : araddr=0x%0h, rdata=0x%0h rresp=%0h",
               vif.mon_cb.araddr,vif.mon_cb.rdata,vif.mon_cb.rresp),UVM_NONE);
            act_ap.write(rd_tx);
         end
      end
   end
endtask:monitor_read
endclass:axi4_lite_act_monitor
`endif
