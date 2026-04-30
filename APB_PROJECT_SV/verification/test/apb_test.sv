//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: Base APB Test class that defines a reusable
//             framework for creating different test scenarios.
//             Enables test customization through inheritance
//             and polymorphism by providing a virtual run()
//             method to configure and execute the environment.
//Date: 04/03/2026 to  20/04/2026.
//*************************************************//
`ifndef _APB_TEST
`define _APB_TEST
class apb_test;
   apb_env env;
   virtual apb_interface vif;
   
   function new(virtual apb_interface vif);
      this.vif = vif;
   endfunction

   virtual task run();
//       env = new(vif);
//       env.gen.count=20;
//       env.gen.write = 0;
//       env.run();
   endtask
endclass:apb_test
`endif
