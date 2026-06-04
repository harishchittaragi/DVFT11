//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: UVM Write Sequence for AXI4-Lite that
//             generates randomized write transactions,
//             sets valid write strobes, and sends them
//             to the driver. It collects responses
//             from the DUT and handles reset conditions
//             by resending transactions when required.
//Date: 25/05/2026 to  29/05/2026.
//*************************************************//

`ifndef WRITE_SEQ_
`define WRITE_SEQ_
class write_seq extends uvm_sequence #(axi4_lite_seq_item);
   axi4_lite_seq_item item_h;
   axi4_lite_seq_item re_drv;
   `uvm_object_utils(write_seq)

   function new(string name = "write_seq");
      super.new(name);
   endfunction:new

   task body();
      repeat(10) begin
         item_h = axi4_lite_seq_item#()::type_id::create("item_h");
         re_drv = axi4_lite_seq_item#()::type_id::create("re_drv");
         start_item(item_h);
         item_h.is_write = 1;
         item_h.wstrb =4'hF; //for 32 bit
         item_h.randomize();
         `uvm_info("AWADDR_SEQ",$sformatf("This is write_seq : %0s",item_h.sprint()),UVM_NONE);
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
endclass:write_seq
`endif
