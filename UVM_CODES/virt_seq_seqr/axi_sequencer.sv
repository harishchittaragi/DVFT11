class axi_sequencer extends uvm_sequencer #(axi_seq_item);
   `uvm_component_utils(axi_sequencer)

   function new(string name = "axi_sequencer", uvm_component parent = null);
      super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      //default arbitration is FIFO; switch to weighted if needed
         //set_arbitration(SEQ_ARB_WEIGHTED);
   endfunction:build_phase
endclass:axi_sequencer

