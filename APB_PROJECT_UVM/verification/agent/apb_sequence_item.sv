//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: APB sequence item representing
//             transaction data, control signals,
//             and protocol states used for
//             stimulus generation and monitoring.
//Date: 08/05/2026 to 15/05/2026.
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
endclass:apb_sequence_item
`endif
