//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: APB read-write sequence that
//             performs write followed by read
//             on same address, verifies data
//             consistency, and supports resume
//             after reset conditions.
//Date: 08/05/2026 to 15/05/2026.
//*************************************************//

`ifndef _APB_RW_SEQ
`define _APB_RW_SEQ

class apb_rw_seq extends uvm_sequence#(apb_sequence_item);
//  handle creation for seq_item.
   apb_sequence_item seq_h;
   apb_sequence_item resume_drv;

//  local variable declaration.
   bit write;
   int addr[1:0];
   int i;

//  factory registration
   `uvm_object_utils(apb_rw_seq)

   function new(string name = "apb_rw_seq");
      super.new(name);
   endfunction:new

   task body();
      repeat(10) begin
         write=1;
         i=1;
         repeat(2) begin
            seq_h=apb_sequence_item::type_id::create("seq_h");
            resume_drv=apb_sequence_item::type_id::create("resume_drv");

            start_item(seq_h);
            if(!seq_h.has_resume) begin
               seq_h.randomize() with {seq_h.pwrite==write;};
               if(i)
                  addr[0] = seq_h.paddr;//randomized seq_paddr assigned to local variable memory.
               else
                  seq_h.paddr=addr[0];//memory address sent back to seq_paddr to read same packate.
               `uvm_info("apb_rw_seq",$sformatf("Dispalying From apb_rw_seq=%0s",
                  seq_h.sprint()),UVM_NONE);
            finish_item(seq_h);
            write=0;
            i=0;
            end
           else
              get_response(resume_drv);
        end
     end
   endtask:body
endclass:apb_rw_seq
`endif
