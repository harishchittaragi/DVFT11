//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: This is Environment_file.
//Date: 04/03/2026 to  / /2026.
//*************************************************//
`ifndef _APB_ENV
`define _APB_ENV

class apb_env extends uvm_env;
   apb_active_agent act_agent_h;
   apb_passive_agent pas_agent_h;
   apb_score_board sb_h;
   apb_coverage cov_h;
   `uvm_component_utils(apb_env)

   function new(string name = "apb_env",uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      uvm_config_db#(uvm_active_passive_enum)::set(this,"act_agent_h","is_active",UVM_ACTIVE);
      uvm_config_db#(uvm_active_passive_enum)::set(this,"pas_agent_h","is_active",UVM_PASSIVE);
      act_agent_h=apb_active_agent::type_id::create("act_agent_h",this);
      pas_agent_h=apb_passive_agent::type_id::create("pas_agent_h",this);
      sb_h=apb_score_board::type_id::create("sb_h",this);
      cov_h=apb_coverage::type_id::create("cov_h",this);
   endfunction:build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      act_agent_h.act_mon_h.ap.connect(sb_h.act_imp);
      pas_agent_h.pas_mon_h.ap.connect(sb_h.pas_imp);
      act_agent_h.act_mon_h.ap.connect(cov_h.cov_act_imp);
      pas_agent_h.pas_mon_h.ap.connect(cov_h.cov_pas_imp);
   endfunction:connect_phase
endclass:apb_env
`endif


//class apb_env;
//   mailbox mon_sb;
//   apb_score_board sb;
//   apb_active_agent act_agent_h;
//   virtual apb_interface vif;
//
//   function new(virtual apb_interface vif);
//     this.vif = vif;
//     mon_sb=new();
//     act_agent_h=new(vif,mon_sb);
//     sb=new(mon_sb);
//  endfunction
//
//  task run();
//     fork
//        act_agent_h.run();
//        sb.run();
//     join_any
//     # 1;
//     disable fork;
//  endtask
//endclass:apb_env
//`endif
