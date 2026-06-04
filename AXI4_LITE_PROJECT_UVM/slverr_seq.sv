//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: UVM Sequence to generate SLVERR
//             scenarios in AXI4-Lite by driving
//             misaligned write and read addresses.
//             It performs write followed by read
//             on invalid address, captures response,
//             and handles reset conditions by
//             resending transactions when required.
//Date: 25/05/2026 to  29/05/2026.
//*************************************************//
`ifndef SLVERR_RD_SEQ_
`define SLVERR_RD_SEQ_
class slverr_seq extends uvm_sequence #(axi4_lite_seq_item);
   axi4_lite_seq_item item_h;
   axi4_lite_seq_item re_drv;
   `uvm_object_utils(slverr_seq)
   bit write;
   bit i;
   bit iw;
   int addr[1:0];

   function new(string name = "slverr_seq");
      super.new(name);
   endfunction:new
task body();
      repeat(5) begin
         //item_h = axi4_lite_seq_item#()::type_id::create("item_h");
         write =1;
         i=1;
         iw = 1;
         repeat(2) begin
            item_h = axi4_lite_seq_item#()::type_id::create("item_h");
            re_drv = axi4_lite_seq_item#()::type_id::create("re_drv");
            start_item(item_h);
               item_h.is_write = iw;
               item_h.randomize() with {awaddr == 32'h0000_0001;};
              // item_h.randomize();
               if(i)
                  addr[0] = item_h.awaddr;
               else
                  item_h.araddr = addr[0];
               `uvm_info("AWADDR_SEQ",$sformatf("This is wr_rd_seq : %0s",item_h.sprint()),UVM_NONE);
            finish_item(item_h);
            write =0;
            i=0;
            iw = 0;
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
      end
   endtask:body
endclass:slverr_seq
`endif
