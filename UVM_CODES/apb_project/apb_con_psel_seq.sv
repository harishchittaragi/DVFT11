//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: This is Write_test_file.
//Date: 04/03/2026 to  / /2026.
//*************************************************//

`ifndef _APB_CON_PSEL_SEQ
`define _APB_CON_PSEL_SEQ

class apb_con_psel_seq extends uvm_sequence#(apb_sequence_item);
    //assign two request and response handle to sequence_item
    apb_sequence_item seq_h;
    apb_sequence_item resume_drv;

    //factory registration
    `uvm_object_utils(apb_con_psel_seq)

    //local variables 
    bit continuous_psel;
    int i;
    
   function new(string name = "apb_con_psel_seq");
      super.new(name);
   endfunction:new

   task body();
      //continuous_psel value taking from command line
      if($value$plusargs("continuous_psel=%0d",continuous_psel))
         repeat(10) begin
            i++;
            //memory creation for handles(sequence_item)
            seq_h=apb_sequence_item::type_id::create("seq_h");
            resume_drv=apb_sequence_item::type_id::create("resume_drv");
            if (i >5)
               seq_h.continuous_psel = continuous_psel;
               `uvm_info("w_seq","Before Start item",UVM_NONE);
               start_item(seq_h);
               if(!seq_h.has_resume) begin
                  //`uvm_info("CON_PSEL_SEQ",$sformatf("Entered in con_psel before randomization"),UVM_NONE);
                  seq_h.randomize();
                  `uvm_info("con_psel_seq",$sformatf("Dispalying From apb_con_psel_seq=%0s",seq_h.sprint()),UVM_NONE);
                finish_item(seq_h);
               end
               else begin
                  get_response(resume_drv);
                  //`uvm_info("WRITE_SEQ",$sformatf("%0s",resume_drv.sprint()),UVM_NONE);
               end
        end
   endtask:body
endclass:apb_con_psel_seq
`endif

