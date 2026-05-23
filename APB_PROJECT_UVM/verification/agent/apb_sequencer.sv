//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: APB sequencer responsible for
//             managing and forwarding sequence
//             items from sequences to driver
//             during simulation.
//Date: 08/05/2026 to 15/05/2026.
//*************************************************//

`ifndef _APB_SEQUENCER
`define _APB_SEQUENCER

class apb_sequencer extends uvm_sequencer#(apb_sequence_item);
//  handle declaration for seq_item
   apb_sequence_item seq_h;

//  factory registration
  `uvm_component_utils(apb_sequencer) 
   function new(string name = "apb_sequencer",uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
   endfunction:build_phase

   task run_phase(uvm_phase phase);
   endtask:run_phase
endclass:apb_sequencer
`endif
