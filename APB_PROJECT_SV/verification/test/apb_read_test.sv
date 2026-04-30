//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: APB Read Test designed to validate
//             read functionality of the DUT by
//             generating multiple read transactions.
//             Ensures correct data retrieval from
//             memory, proper protocol behavior,
//             and accurate handling of read operations.
//Date: 04/03/2026 to  20/04/2026.
//*************************************************//

`ifndef _APB_READ_TEST
`define _APB_READ_TEST
class apb_read_test extends apb_test;
  apb_env env;
  virtual apb_interface vif;
   
  function new(virtual apb_interface vif);
     super.new(vif);
    this.vif = vif;
  endfunction

  task run();
    env = new(vif);
    env.agent_h.gen.count =200;
    env.agent_h.gen.error = 1'b0;
    env.agent_h.gen.write = 2'b00;
    env.run();
  endtask
endclass:apb_read_test
`endif
