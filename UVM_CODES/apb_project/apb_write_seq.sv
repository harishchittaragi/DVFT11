//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: This is Write_test_file.
//Date: 04/03/2026 to  / /2026.
//*************************************************//

`ifndef _APB_WRITE_SEQ
`define _APB_WRITE_SEQ

class apb_write_seq extends uvm_sequence#(apb_sequence_item);
    apb_sequence_item seq_h;
    apb_sequence_item resume_drv;
   `uvm_object_utils(apb_write_seq)

   function new(string name = "apb_write_seq");
      super.new(name);
   endfunction:new

   task body();
    repeat(10) begin
      seq_h=apb_sequence_item::type_id::create("seq_h");
      resume_drv=apb_sequence_item::type_id::create("resume_drv");
      start_item(seq_h);
      if(!seq_h.has_resume) begin
         seq_h.randomize() with {seq_h.pwrite == 1;
                                 seq_h.paddr inside {[0:255]};
                                 seq_h.pwdata inside {[32'h0000_0100 : 32'h0000_FFFF]};
                                };
         `uvm_info("w_seq",$sformatf("Dispalying From apb_write_seq=%0s",seq_h.sprint()),UVM_NONE);
      finish_item(seq_h);
      end
      else
      get_response(resume_drv);
   end
  endtask:body
endclass:apb_write_seq
`endif

//class apb_write_seq extends apb_test;
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
//      env.agent_h.gen.count = 200;
//      env.agent_h.gen.write = 2'b01;
//      env.agent_h.gen.error = 1'b0;
//      env.run();
//   endtask
//endclass:apb_write_seq
//`endif
