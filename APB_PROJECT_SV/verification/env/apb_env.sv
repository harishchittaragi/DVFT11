//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: APB Environment that integrates all verification
//             components including agent and scoreboard.
//             Responsible for connecting monitor-to-scoreboard
//             communication and managing parallel execution
//             of testbench components to ensure complete
//             functional verification of the APB protocol.
//Date: 04/03/2026 to  20/04/2026.
//*************************************************//
`ifndef _APB_ENV
`define _APB_ENV
class apb_env;
   mailbox mon_sb;
   apb_score_board sb;
   apb_agent agent_h;
   virtual apb_interface vif;

   function new(virtual apb_interface vif);
     this.vif = vif;
     mon_sb=new();
     agent_h=new(vif,mon_sb);
     sb=new(mon_sb);
  endfunction

  task run();
     fork
        agent_h.run();
        sb.run();
     join_any
     # 1;
     disable fork;
  endtask
endclass:apb_env
`endif
