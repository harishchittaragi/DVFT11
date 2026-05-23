//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: APB passive agent that monitors
//             bus transactions using passive
//             monitor and provides observation
//             without driving the interface. 
//Date: 08/05/2026 to  15/05/2026.
//*************************************************//

`ifndef _APB_PASSIVE_AGENT
`define _APB_PASSIVE_AGENT
class apb_passive_agent extends uvm_agent;
//  handle declaration for passive_monitor
   apb_passive_monitor pas_mon_h;
//  factory ragistration   
   `uvm_component_utils(apb_passive_agent)

   function new(string name = "apb_passive_agent",uvm_component parent =null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
//      if not uvm_active then only create memory for pas_monitor.
      if(get_is_active() != UVM_ACTIVE) begin
         pas_mon_h=apb_passive_monitor::type_id::create("pas_mon_h",this);
         `uvm_info("[PASSIVE_AGNET]","memory created for [PAS_MON]",UVM_HIGH);
      end
      else begin
         `uvm_error("[PASSIVE_AGNET]","memory is not created for [PAS_MON]");
      end
   endfunction:build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      //NO connections
   endfunction:connect_phase
endclass:apb_passive_agent
`endif

