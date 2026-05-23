class axi_seq_item extends uvm_sequence_item;

   rand bit [31:0] ad;
   rand bit [31:0] da;
   rand bit        wr;

   `uvm_object_utils_begin(axi_seq_item)
    `uvm_field_int(ad, UVM_ALL_ON)
    `uvm_field_int(da, UVM_ALL_ON)
    `uvm_field_int(wr, UVM_ALL_ON)
   `uvm_object_utils_end

   function new(string name = "axi_seq_item");
      super.new(name);
   endfunction:new
endclass:axi_seq_item

