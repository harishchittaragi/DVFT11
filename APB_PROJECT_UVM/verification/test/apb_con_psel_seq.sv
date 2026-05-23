//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: APB sequence that generates
//             transactions with optional
//             continuous psel behavior and
//             supports resume of interrupted
//             transactions after reset.
//Date: 08/05/2026 to 15/05/2026.
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

            //this if condition makes psel continuously high afer 5 repeatation occurs.
            if (i >5)
               seq_h.continuous_psel = continuous_psel; //assigning value
               start_item(seq_h);
               //condition checking if reset occurs then from driver class has_resume becomes high.
               if(!seq_h.has_resume) begin
                  seq_h.randomize();
                  `uvm_info("con_psel_seq",$sformatf("Dispalying From apb_con_psel_seq=%0s",seq_h.sprint()),UVM_NONE);
                finish_item(seq_h);
               end
               else begin
                  //collecting resume_drv packet from driver class (default method)
                  get_response(resume_drv);
               end
        end
   endtask:body
endclass:apb_con_psel_seq
`endif

