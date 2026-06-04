//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: UVM Test for AXI4-Lite that builds
//             the verification environment and
//             executes multiple sequences such as
//             write, read, combined write-read,
//             and slave error scenarios. It controls
//             simulation flow using objection
//             mechanism and drives stimulus through
//             the sequencer.
//Date: 25/05/2026 to  29/05/2026.
//*************************************************//

`ifndef AXI4_LITE_TEST_
`define AXI4_LITE_TEST_
class axi4_lite_test extends uvm_test;
   // handle declaration for all the sequences & env component:
   write_seq write_seq_h;
   read_seq  read_seq_h;
   wr_rd_seq  wr_rd_seq_h;
   slverr_seq slverr_seq_h;
   axi4_lite_env env_h;
   //factory registration
   `uvm_component_utils(axi4_lite_test)

   function new(string name = "axi4_lite_test",uvm_component parent= null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      // memory declaration for all sequences & env component
      write_seq_h = write_seq :: type_id :: create("write_seq_h");
      read_seq_h = read_seq :: type_id :: create("read_seq_h");
      wr_rd_seq_h = wr_rd_seq :: type_id :: create("wr_rd_seq_h");
      slverr_seq_h = slverr_seq :: type_id :: create("slverr_seq_h");
      env_h = axi4_lite_env :: type_id :: create("env_h",this);
   endfunction:build_phase

   task run_phase(uvm_phase phase);
      //all the  sequences will start one after one using .start() method.
      phase.raise_objection(this);
      write_seq_h.start(env_h.act_agent_h.seqr_h);
     #10;
      read_seq_h.start(env_h.act_agent_h.seqr_h);
     #10;
      wr_rd_seq_h.start(env_h.act_agent_h.seqr_h);
     #10;
      slverr_seq_h.start(env_h.act_agent_h.seqr_h);
      phase.drop_objection(this);
   endtask:run_phase
endclass:axi4_lite_test
`endif
