//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: "APB agent responsible for generating transactions, driving signals, and monitoring bus activity."
//Date: 04/03/2026 to  20/04/2026.
//*************************************************//

`ifndef _APB_AGENT
`define _APB_AGENT
class apb_agent; 
   apb_generator gen;
   mailbox gen_drv;
   apb_driver drv;
   apb_monitor mon;
   mailbox mon_sb;
   virtual apb_interface vif;

   function new(virtual apb_interface vif,mailbox mon_sb);
     this.vif = vif;
     this.mon_sb=mon_sb;
     gen_drv = new();
     gen = new(gen_drv);
     drv = new(gen_drv,vif);
     mon = new(vif,mon_sb);
  endfunction
  
  task run();
     fork
        gen.run();
        drv.run();
        mon.run();
     join_any
     #500;
     disable fork;
  endtask
endclass
`endif
