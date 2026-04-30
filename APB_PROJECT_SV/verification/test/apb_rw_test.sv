//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: APB Read-Write Test designed to validate
//             mixed transaction scenarios by generating
//             sequential read and write operations.
//             Ensures proper data flow, memory consistency,
//             and protocol compliance under continuous
//             and varied transaction patterns.
//Date: 04/03/2026 to  20/04/2026.
//*************************************************//

class apb_rw_test extends apb_test;

   apb_env env;
   virtual apb_interface vif;
   
   function new(virtual apb_interface vif);
      super.new(vif);
      this.vif = vif;
   endfunction

   task run();
      env = new(vif);
      env.agent_h.gen.count=500;
      env.agent_h.gen.write=2'b10;
      env.run();
   endtask
endclass

