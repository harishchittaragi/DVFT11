class virtual_sequence extends uvm_sequence;
   `uvm_object_utils(virtual_sequence)
   apb_seq1 apb_seq1_h;
   apb_seq2 apb_seq2_h;
   axi_seq1 axi_seq1_h;
   axi_seq2 axi_seq2_h;
   `uvm_declare_p_sequencer(virtual_sequencer)

   function new(string name= "virtual_sequence");
      super.new(name);
   endfunction:new

   task body();
      apb_seq1_h=apb_seq1::type_id::create("apb_seq1_h");
      apb_seq2_h=apb_seq2::type_id::create("apb_seq2_h");
      axi_seq1_h=axi_seq1::type_id::create("axi_seq1_h");
      axi_seq2_h=axi_seq2::type_id::create("axi_seq2_h");

      apb_seq1_h.start(p_sequencer.apb_seqr_h);
      #10;
      apb_seq2_h.start(p_sequencer.apb_seqr_h);
      #20;
      axi_seq1_h.start(p_sequencer.axi_seqr_h);
      #10;
      axi_seq2_h.start(p_sequencer.axi_seqr_h);

   endtask:body
endclass:virtual_sequence
      
