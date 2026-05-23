class test extends uvm_test;
//   apb_seq1 apb_seq1_h;
//   apb_seq2 apb_seq2_h;
//   axi_seq1 axi_seq1_h;
//   axi_seq2 axi_seq2_h;
   virtual_sequence v_seq_h;   
   env env_h;
   `uvm_component_utils(test)

   function new(string name = "test",uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
//      apb_seq1_h=apb_seq1::type_id::create("apb_seq1_h");
//      apb_seq2_h=apb_seq2::type_id::create("apb_seq2_h");
//      axi_seq1_h=axi_seq1::type_id::create("axi_seq1_h");
//      axi_seq2_h=axi_seq2::type_id::create("axi_seq2_h");
      v_seq_h=virtual_sequence::type_id::create("v_seq_h");      
      env_h=env::type_id::create("env_h",this);
   endfunction:build_phase

   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      v_seq_h.start(env_h.v_seqr_h);
      #100;
//       apb_seq1_h.start(env_h.apb_agent_h.apb_seqr_h);
//       #10;
//       apb_seq2_h.start(env_h.apb_agent_h.apb_seqr_h);
//       #20;
//       axi_seq1_h.start(env_h.axi_agent_h.axi_seqr_h);
//       #10;
//       axi_seq2_h.start(env_h.axi_agent_h.axi_seqr_h);
      phase.drop_objection(this);
   endtask:run_phase
endclass:test


