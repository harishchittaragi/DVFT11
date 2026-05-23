class virtual_sequencer extends uvm_sequencer;

   `uvm_component_utils(virtual_sequencer)

   apb_sequencer apb_seqr_h;
   axi_sequencer axi_seqr_h;
   function new(string name = "virtual_sequencer",uvm_component parent= null);
      super.new(name,parent);
   endfunction:new
endclass:virtual_sequencer
