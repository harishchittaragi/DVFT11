//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: APB active agent responsible for
//             creating, connecting and managing
//             driver, sequencer and monitor.
//Date: 08/05/2026 to  15/05/2026.
//*************************************************//
`ifndef _APB_ACTIVE_AGENT
`define _APB_ACTIVE_AGENT
class apb_active_agent extends uvm_agent;
//   handle assigning for apb_sequencer,apb_driver and apb_active_monitor
   apb_sequencer seqr_h;
   apb_driver drv_h;
   apb_active_monitor act_mon_h;
   
//   factory registration
   `uvm_component_utils(apb_active_agent)

   function new(string name = "apb_active_agent",uvm_component parent =null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
//      creating driver and sequencer and monitor only in active mode
      if(get_is_active()==UVM_ACTIVE) begin
         seqr_h=apb_sequencer::type_id::create("seqr_h",this);
         drv_h=apb_driver::type_id::create("drv_h",this);
         act_mon_h=apb_active_monitor::type_id::create("act_mon_h",this);
         `uvm_info("[ACTIVE_AGNET]","Memory created for [DRV] [SEQR] [ACT_MON]",UVM_HIGH);
      end
      else
         `uvm_error("[ACTIVE_AGNET]","Memorynot created for [DRV] [SEQR] [ACT_MON]");
   endfunction:build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
//      driver-sequencer port connection
//      seq_item_port is inbuilt port name from uvm_driver class
//      seq_item_export is inbuilt export from uvm_sequencer
      drv_h.seq_item_port.connect(seqr_h.seq_item_export);
   endfunction:connect_phase
endclass:apb_active_agent
`endif
