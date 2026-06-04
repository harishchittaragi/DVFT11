//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: UVM Sequencer for AXI4-Lite that
//             controls the flow of sequence items
//             from sequences to the driver. It acts
//             as an interface between stimulus
//             generation and execution without
//             adding protocol-specific behavior.
//Date: 25/05/2026 to  29/05/2026.
//*************************************************//

`ifndef AXI4_LITE_SEQUENCER_
`define AXI4_LITE_SEQUENCER_
class axi4_lite_sequencer extends uvm_sequencer #(axi4_lite_seq_item);
   `uvm_component_utils(axi4_lite_sequencer)

   function new(string name = "axi4_lite_sequencer", uvm_component parent = null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
   endfunction:build_phase

endclass:axi4_lite_sequencer
`endif
