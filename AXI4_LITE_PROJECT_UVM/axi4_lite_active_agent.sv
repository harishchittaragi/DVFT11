//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: UVM Active Agent for AXI4-Lite that
//             instantiates and connects sequencer,
//             driver, and monitor components.
//             It drives stimulus to the DUT via
//             the driver and captures transactions
//             through the monitor for analysis.
//Date: 25/05/2026 to  29/05/2026.
//*************************************************//

`ifndef AXI4_LITE_ACTIVE_AGENT_
`define AXI4_LITE_ACTIVE_AGENT_
class axi4_lite_active_agent extends uvm_agent;
   // handle declaration for components inside agent
   axi4_lite_sequencer seqr_h;
   axi4_lite_driver drv_h;
   axi4_lite_act_monitor mon_h;
   
   //factory registration
   `uvm_component_utils(axi4_lite_active_agent)

   function new(string name = "axi4_lite_active_agent",uvm_component parent= null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      // memory declaration for components
      seqr_h = axi4_lite_sequencer :: type_id :: create("seqr_h",this);
      drv_h =  axi4_lite_driver :: type_id :: create("drv_h",this);
      mon_h = axi4_lite_act_monitor::type_id::create("mon_h",this);
   endfunction:build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      // Driverv and Sequencer port connection.
      drv_h.seq_item_port.connect(seqr_h.seq_item_export);
   endfunction:connect_phase
endclass:axi4_lite_active_agent
`endif
