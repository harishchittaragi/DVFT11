//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: UVM Sequence for AXI4-Lite that
//             performs combined write and read
//             operations. It first generates a
//             write transaction, stores the address,
//             then performs a read on the same
//             address to verify data consistency.
//             It also handles reset conditions by
//             resending transactions when needed.
//Date: 25/05/2026 to  29/05/2026.
//*************************************************//

`ifndef WR_RD_SEQ_
`define WR_RD_SEQ_
class wr_rd_seq extends uvm_sequence #(axi4_lite_seq_item);
   axi4_lite_seq_item item_h;
   axi4_lite_seq_item re_drv;
   `uvm_object_utils(wr_rd_seq)
   bit write;
   bit i;
   bit iw;
   int addr[1:0];

   function new(string name = "wr_rd_seq");
      super.new(name);
   endfunction:new

   task body();
      repeat(20) begin
         write =1;
         i=1;
         iw = 1;
         repeat(2) begin
            item_h = axi4_lite_seq_item#()::type_id::create("item_h");
            re_drv = axi4_lite_seq_item#()::type_id::create("re_drv");
            start_item(item_h);
               item_h.is_write = iw;
               item_h.randomize()with {is_write == iw;
                 awaddr[1:0]==2'h00;
                 araddr[1:0]==2'h00;};
               if(iw)
                  item_h.wstrb = 4'hF;
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
endclass:wr_rd_seq
`endif
