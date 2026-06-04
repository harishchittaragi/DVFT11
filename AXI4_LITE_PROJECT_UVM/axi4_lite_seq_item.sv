//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: UVM Sequence Item for AXI4-Lite that
//             models read and write transactions
//             with all channel signals. It includes
//             randomizable address and data fields,
//             control flags, and constraints for
//             valid address range and alignment.
//             It is used by sequences, driver, and
//             monitor for transaction generation.
//Date: 25/05/2026 to  29/05/2026.
//*************************************************//

`ifndef AXI4_LITE_SEQ_ITEM_
`define AXI4_LITE_SEQ_ITEM_
class axi4_lite_seq_item #(ADDR_WIDTH=32, DATA_WIDTH=32) extends uvm_sequence_item;
//-------WRITE ADDRESS CHANNEL--------//
    rand bit [ADDR_WIDTH-1:0]   awaddr;
         bit                    awvalid;
         bit                    awready;

//-------WRITE DATA CHANNEL-----------//
    rand bit [DATA_WIDTH-1:0]   wdata;
         bit [DATA_WIDTH/8-1:0] wstrb;
         bit                    wvalid;
         bit                    wready;

//-------WRITE RESPONSE CHANNEL-------//
         bit [2:0]              bresp;
         bit                    bvalid;
         bit                    bready;

//-------READ ADDRESS CHANNEL---------//
    rand bit [ADDR_WIDTH-1:0]   araddr;
         bit                    arvalid;
         bit                    arready;

//-------READ DATA CHANNEL------------//
         bit [DATA_WIDTH-1:0]   rdata;
         bit [2:0]              rresp;
         bit                    rvalid;
         bit                    rready;

//-------EXTRA SIGNALS---------------//
         bit                    is_write;
         bit                    rst_f;

    // factory registration for all the signals:
    `uvm_object_utils_begin(axi4_lite_seq_item)
     `uvm_field_int (awaddr ,  UVM_ALL_ON)
     `uvm_field_int (awvalid , UVM_ALL_ON)
     `uvm_field_int (awready , UVM_ALL_ON)
     `uvm_field_int (wdata ,   UVM_ALL_ON)
     `uvm_field_int (wstrb ,   UVM_ALL_ON)
     `uvm_field_int (wvalid ,  UVM_ALL_ON)
     `uvm_field_int (wready ,  UVM_ALL_ON)
     `uvm_field_int (bresp ,   UVM_ALL_ON)
     `uvm_field_int (bvalid ,  UVM_ALL_ON)
     `uvm_field_int (bready ,  UVM_ALL_ON)
     `uvm_field_int (araddr ,  UVM_ALL_ON)
     `uvm_field_int (arvalid , UVM_ALL_ON)
     `uvm_field_int (arready , UVM_ALL_ON)
     `uvm_field_int (rdata ,   UVM_ALL_ON)
     `uvm_field_int (rresp ,   UVM_ALL_ON)
     `uvm_field_int (rvalid ,  UVM_ALL_ON)
     `uvm_field_int (rready ,  UVM_ALL_ON)
     `uvm_field_int (is_write ,  UVM_ALL_ON)
     `uvm_field_int (rst_f ,  UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "axi4_lite_seq_item");
       super.new(name);
    endfunction:new

     constraint address_c1 {awaddr inside {[32'h0 : 32'h0000_00FF]};
                          };                    
     constraint address_c2 {soft awaddr % 4 ==0;
                            soft araddr % 4 ==0;
                           };
endclass:axi4_lite_seq_item
`endif
