//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: This is Test_file.
//Date: 07/05/2026 to  / /2026.
//*************************************************//
`ifndef _APB_TEST
`define _APB_TEST

class apb_test extends uvm_test;
   apb_error_seq error_h;
   apb_read_seq read_h;
   apb_write_seq write_h;
   apb_rw_seq rw_h;
   apb_con_psel_seq con_psel_h;
   apb_env env_h;
   virtual apb_interface vif;
   `uvm_component_utils(apb_test)

   function new(string name= "apb_test",uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db #(virtual apb_interface):: get(this,"","vif",vif))
        `uvm_fatal("No_VIF","Virtual interface not found in config_db of [APB_TEST]");
      env_h=apb_env::type_id::create("env_h",this);
   endfunction:build_phase

   task run_phase(uvm_phase phase);

      phase.raise_objection(this);
      error_h = apb_error_seq::type_id::create("error_h");
      read_h  = apb_read_seq::type_id::create("read_h");
      write_h = apb_write_seq::type_id::create("write_h");
      rw_h    = apb_rw_seq::type_id::create("rw_h");
      con_psel_h = apb_con_psel_seq::type_id::create("con_psel_h");

      error_h.start(env_h.act_agent_h.seqr_h);
      #10;
      write_h.start(env_h.act_agent_h.seqr_h);
      #10;
      rw_h.start(env_h.act_agent_h.seqr_h);
      #10;
      con_psel_h.start(env_h.act_agent_h.seqr_h);
      #10;
      read_h.start(env_h.act_agent_h.seqr_h);
  //    phase.phase_done.set_drain_time(this,10);
      phase.drop_objection(this);
   endtask:run_phase
endclass:apb_test
`endif
   
//   virtual apb_interface vif;
//   
//   function new(virtual apb_interface vif);
//      this.vif = vif;
//   endfunction
//
//   virtual task run();
////       env = new(vif);
////       env.gen.count=20;
////       env.gen.write = 0;
////       env.run();
//   endtask
//endclass:apb_test
