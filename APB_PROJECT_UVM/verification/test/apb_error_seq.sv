//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: APB error sequence that generates
//             invalid or boundary transactions
//             to trigger error conditions and
//             verifies DUT error handling with
//             resume support after reset.
//Date: 08/05/2026 to 15/05/2026.
//*************************************************//

`ifndef _APB_ERROR_SEQ
`define _APB_ERROR_SEQ

class apb_error_seq extends uvm_sequence #(apb_sequence_item);
//  handle declaration for sequence_item  
   apb_sequence_item seq_h;
   apb_sequence_item resume_drv;
//  factory registration 
   `uvm_object_utils(apb_error_seq)
    
   function new(string name = "apb_error_seq");
      super.new(name);
   endfunction:new

   task body();
      repeat(10) begin
//      memory creation for sequence_item.
      seq_h=apb_sequence_item::type_id::create("seq_h");
      resume_drv=apb_sequence_item::type_id::create("resume_drv");

//      sequence_starts here      
      start_item(seq_h);
//      condition checking for has_resume value considering from driver logic. 
      if(!seq_h.has_resume) begin
      seq_h.randomize()with {seq_h.pwrite ==0;
                             seq_h.paddr == 32'hffff_ffff;
                            };
      `uvm_info("apb_error_seq",$sformatf("Dispalying From apb_error_seq=%0s",seq_h.sprint()),UVM_NONE);
      finish_item(seq_h);
     end
     else
      get_response(resume_drv);
   end
   endtask:body
endclass:apb_error_seq
`endif
