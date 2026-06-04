//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: UVM Environment for AXI4-Lite that
//             integrates active agent, scoreboard,
//             and coverage components. It connects
//             monitor analysis ports to scoreboard
//             and coverage for functional checking
//             and coverage collection.
//Date: 25/05/2026 to  29/05/2026.
//*************************************************//

`ifndef AXI4_LITE_ENV_
`define AXI4_LITE_ENV_
class axi4_lite_env extends uvm_env;
   // handle declaration for components under env:
   axi4_lite_active_agent act_agent_h;
   axi4_lite_scoreboard sb_h;
   axi4_lite_coverage cov_h;

   // factory registration
   `uvm_component_utils(axi4_lite_env)

   function new(string name = "axi4_lite_env",uvm_component parent= null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      // memory declaration for components
      act_agent_h = axi4_lite_active_agent :: type_id :: create("act_agent_h",this);
      sb_h = axi4_lite_scoreboard :: type_id :: create("sb_h",this);
      cov_h = axi4_lite_coverage :: type_id :: create("cov_h",this);
   endfunction:build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      // port connection for monitorto SB and coverage:
      act_agent_h.mon_h.act_ap.connect(sb_h.act_imp);
      act_agent_h.mon_h.act_ap.connect(cov_h.act_imp);
   endfunction:connect_phase
endclass:axi4_lite_env
`endif
