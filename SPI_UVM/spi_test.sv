`ifndef SPI_TEST_
`define SPI_TEST_
class spi_test extends uvm_test;
   `uvm_component_utils(spi_test)
   spi_seq1 seq1_h;
   spi_seq2 seq2_h;
   spi_env env_h;

   // CONSTRUCTOR
   function new (string name = "spi_test", uvm_component parent= null);
       super.new(name,parent);
   endfunction:new

   // BUILD_PHASE
   function void build_phase(uvm_phase phase);
       super.build_phase(phase);
       seq1_h = spi_seq1 :: type_id :: create ("seq1_h");
       seq2_h = spi_seq2 :: type_id :: create ("seq2_h");
       env_h = spi_env :: type_id :: create("env_h",this);
   endfunction:build_phase
   
   // RUN_PHASE
   task run_phase(uvm_phase phase);
       phase.raise_objection(this);
       seq1_h.start(env_h.agent_h.seqr_h);
       seq2_h.start(env_h.agent_h.seqr_h);
       phase.drop_objection(this);
   endtask:run_phase
endclass:spi_test
`endif
