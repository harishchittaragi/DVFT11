//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: APB Write Test designed to validate
//             write functionality of the DUT by
//             generating multiple write transactions.
//             Ensures correct data transfer to memory,
//             proper protocol compliance, and verifies
//             behavior under continuous write operations.
//Date: 04/03/2026 to  20/04/2026.
//*************************************************//

`ifndef _APB_WRITE_TEST
`define _APB_WRITE_TEST
class apb_write_test extends apb_test;
   apb_env env;
   virtual apb_interface vif;
   
   function new(virtual apb_interface vif);
      super.new(vif);
      this.vif = vif;
   endfunction

   task run();
      env = new(vif);
      env.agent_h.gen.count = 200;
      env.agent_h.gen.write = 2'b01;
      env.agent_h.gen.error = 1'b0;
      env.run();
   endtask
endclass:apb_write_test
`endif
