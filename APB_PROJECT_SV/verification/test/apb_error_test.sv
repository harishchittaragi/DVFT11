//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: APB Error Test designed to validate DUT
//             response to erroneous transactions.
//             Configures generator for error injection,
//             runs the environment, and verifies that
//             the DUT correctly asserts error signals
//             and handles invalid accesses as per APB protocol.
//Date: 04/03/2026 to  20/04/2026.
//*************************************************//

`ifndef _APB_ERROR_TEST
`define _APB_ERROR_TEST
class apb_error_test extends apb_test;

   apb_env env;
   virtual apb_interface vif;
   
   function new(virtual apb_interface vif);
      super.new(vif);
       this.vif = vif;
   endfunction

   task run();
      env = new(vif);
      env.agent_h.gen.count = 20;
      env.agent_h.gen.error = 1'b1;
      env.run();
   endtask
endclass:apb_error_test
`endif
