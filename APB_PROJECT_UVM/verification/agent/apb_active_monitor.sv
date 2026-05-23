//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: APB active monitor that tracks bus
//             activity, captures protocol phases,
//             and forwards transactions to
//             scoreboard via analysis port. 
//Date: 08/05/2026 to  15/05/2026.
//*************************************************//

`ifndef _APB_ACTIVE_MONITOR
`define _APB_ACTIVE_MONITOR

class apb_active_monitor extends uvm_monitor;
//  declaring handle for virtual interface.
   virtual apb_interface vif;

//  declaring handle for seq_item.   
   apb_sequence_item seq_h;

//  declaring analysis port.
   uvm_analysis_port#(apb_sequence_item) ap;

//  factory registration   
   `uvm_component_utils(apb_active_monitor)

   function new(string name = "apb_active_monitor",uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
//      checking config_db get() method for vif signlas.
      if(!uvm_config_db#(virtual apb_interface)::get(this,"","vif",vif))
         `uvm_fatal("No_VIF","Virtual interface not found in config_db of [APB_ACTIVE_MONITOR]");

//      memory creation for analysis port
      ap=new("ap",this);
   endfunction:build_phase

   task run_phase (uvm_phase phase);
    forever begin
      @(vif.monitor_cb);
      if(!vif.presetn || $isunknown(vif.presetn))
         continue;
      if(!vif.monitor_cb.psel || vif.monitor_cb.penable)
         continue;
       seq_h=apb_sequence_item::type_id::create("seq_h");

       seq_h.apb_state = IDLE;
       ap.write(seq_h);

//      all vif signals from dut assigned to seq_item.
       seq_h.psel     = vif.monitor_cb.psel;
       seq_h.penable  = vif.monitor_cb.penable;
       seq_h.pready   = vif.monitor_cb.pready;
       seq_h.paddr    = vif.monitor_cb.paddr;
       seq_h.pwrite   = vif.monitor_cb.pwrite;
       seq_h.pwdata   = vif.monitor_cb.pwdata;
       `uvm_info("[ACTIVE_MON]",$sformatf("setup detected:::::- %0s",seq_h.sprint()),UVM_NONE);
       seq_h.apb_state = SETUP;
       ap.write(seq_h);//writing into the seq_item 

       @(vif.monitor_cb);
       if(!vif.presetn || $isunknown(vif.presetn)) begin
          `uvm_info("[ACTIVE_MON]"," Reset during Access Phase --droping transaction",UVM_NONE);
          continue;
       end
       if(!vif.monitor_cb.penable) begin
          `uvm_error("[ACTIVE_MON]",$sformatf("%0t :penable is not asserted after SETUP",$time));
          continue;
       end
       seq_h.apb_state = ACCESS;
       ap.write(seq_h);

//      waiting for pready
       while(!vif.monitor_cb.pready) begin
          @(vif.monitor_cb);
          if(!vif.presetn || $isunknown(vif.presetn)) begin
             `uvm_info("[ACTIVE_MON]","Reset while waiting for pready --droping transaction",UVM_NONE);
             break;
          end
       end
       seq_h.penable  = vif.monitor_cb.penable;
       seq_h.prdata   = vif.monitor_cb.prdata;
       seq_h.pslverr  = vif.monitor_cb.pslverr;
       ap.write(seq_h);
       `uvm_info("[ACTIVE_MON]"," Transaction sent to scoreboard",UVM_NONE);
    end      
 endtask:run_phase
endclass:apb_active_monitor
`endif
