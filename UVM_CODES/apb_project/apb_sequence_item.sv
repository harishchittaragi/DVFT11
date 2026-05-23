//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: This is Transcation_file.
//Date: 04/03/2026 to  / /2026.
//*************************************************//
`ifndef _APB_SEQUENCE_ITEM
`define _APB_SEQUENCE_ITEM

typedef enum logic[1:0] {
        IDLE   = 2'b00,
        SETUP  = 2'b01,
        ACCESS = 2'b10
        } apb_state_e;

class apb_sequence_item extends uvm_sequence_item;
      bit       psel;
      bit       penable;
      bit       pready;

rand  bit[31:0] paddr;
rand  bit       pwrite;
      bit[31:0] prdata;
rand  bit[31:0] pwdata;
      bit       pslverr;
      bit       continuous_psel;
      bit       has_resume;

     apb_state_e apb_state;
     `uvm_object_utils_begin(apb_sequence_item)
      `uvm_field_int(psel,UVM_ALL_ON)
      `uvm_field_int(continuous_psel,UVM_ALL_ON)
      `uvm_field_int(penable,UVM_ALL_ON)
      `uvm_field_int(pready,UVM_ALL_ON)
      `uvm_field_int(paddr,UVM_ALL_ON)
      `uvm_field_int(pwrite,UVM_ALL_ON)
      `uvm_field_int(prdata,UVM_ALL_ON)
      `uvm_field_int(pwdata,UVM_ALL_ON)
      `uvm_field_int(pslverr,UVM_ALL_ON)
      `uvm_field_enum(apb_state_e,apb_state,UVM_ALL_ON)
     `uvm_object_utils_end

     function new(string name = "apb_sequence_item");
        super.new(name);
     endfunction:new

      constraint c_paddr {soft paddr inside {[0:255]};}
//      function void display(string name);
//             $display("[%0t] [%s] paddr=%0d pwrite=%0b pwdata=%0d prdata=%0d pslverr=%0b",
//              $time,name, paddr, pwrite, pwdata, prdata, pslverr);      
//      endfunction
endclass:apb_sequence_item
`endif
