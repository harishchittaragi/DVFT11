//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: This is Read_Write_test_file.
//Date: 04/03/2026 to  / /2026.
//*************************************************//

`ifndef _APB_RW_SEQ
`define _APB_RW_SEQ

class apb_rw_seq extends uvm_sequence#(apb_sequence_item);
   apb_sequence_item seq_h;
   apb_sequence_item resume_drv;
   bit write;
   int addr[1:0];
   int i;

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
                  addr[0] = seq_h.paddr;
               else
                  seq_h.paddr=addr[0];
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

//   apb_env env;
//   virtual apb_interface vif;
//   
//   function new(virtual apb_interface vif);
//      super.new(vif);
//      this.vif = vif;
//   endfunction
//
//   task run();
//      env = new(vif);
//      env.agent_h.gen.count=500;
//      env.agent_h.gen.write=2'b10;
//      env.run();
//   endtask
//endclass

