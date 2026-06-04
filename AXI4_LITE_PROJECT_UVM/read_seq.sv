//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: UVM Read Sequence for AXI4-Lite that
//             generates randomized read transactions,
//             sends them to the driver, and collects
//             responses. It handles reset conditions
//             by resending transactions when reset
//             occurs and logs the received responses.
//Date: 25/05/2026 to  29/05/2026.
//*************************************************//

`ifndef READ_SEQ_
`define READ_SEQ_
class read_seq extends uvm_sequence #(axi4_lite_seq_item);
   axi4_lite_seq_item item_h;
   axi4_lite_seq_item re_drv;
   `uvm_object_utils(read_seq)

   function new(string name = "read_seq");
      super.new(name);
   endfunction:new

   task body();
      repeat(10) begin
         item_h = axi4_lite_seq_item#()::type_id::create("item_h");
         re_drv = axi4_lite_seq_item#()::type_id::create("re_drv");
         start_item(item_h);
         item_h.is_write = 0;
         item_h.randomize();
         `uvm_info("AWADDR_SEQ",$sformatf("This is read_seq : %0s",item_h.sprint()),UVM_NONE);
         finish_item(item_h);
         get_response(re_drv);
         if(re_drv.rst_f) begin
            `uvm_info("[SEQ]","Reset Ocuured -- resending packet",UVM_NONE);
            start_item(re_drv);
            finish_item(re_drv);
            get_response(re_drv);
         end
         else
            `uvm_info("[SEQ]",$sformatf("Response = %0s",re_drv.sprint()),UVM_NONE);
      end
   endtask:body
endclass:read_seq
`endif
