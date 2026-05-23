//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: This is Read_test_file.
//Date: 04/03/2026 to  / /2026.
//*************************************************//

`ifndef _APB_READ_SEQ
`define _APB_READ_SEQ

class apb_read_seq extends uvm_sequence#(apb_sequence_item);
   apb_sequence_item seq_h;
   apb_sequence_item resume_drv;
   `uvm_object_utils(apb_read_seq)

   function new(string name = "apb_read_seq");
      super.new(name);
   endfunction:new

   task body();
      repeat(10) begin
      seq_h=apb_sequence_item::type_id::create("seq_h");
      resume_drv=apb_sequence_item::type_id::create("resume_drv");
      start_item(seq_h);
      if(!seq_h.has_resume) begin
      seq_h.randomize()with {seq_h.pwrite == 0;
                             seq_h.paddr inside {[0:255]};
                            };
      `uvm_info(get_type_name(),$sformatf("Dispalying From apb_read_seq=%0s",seq_h.sprint()),UVM_NONE);
      finish_item(seq_h);
     end
     else
      get_response(resume_drv);
   end
 endtask:body
endclass:apb_read_seq
`endif


//  apb_env env;
//  virtual apb_interface vif;
//   
//  function new(virtual apb_interface vif);
//     super.new(vif);
//    this.vif = vif;
//  endfunction
//
//  task run();
//    env = new(vif);
//    env.agent_h.gen.count =200;
//    env.agent_h.gen.error = 1'b0;
//    env.agent_h.gen.write = 2'b00;
//    env.run();
//  endtask
//endclass:apb_read_seq
//`endif
