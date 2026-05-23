class transaction extends uvm_sequence_item;
   
   //variable declaration
   logic addr;
   logic data;
   
   //factory registration
   `uvm_object_utils_begin(transaction) //object registration
    `uvm_field_int(addr,UVM_ALL_ON)     //var addr registration
    `uvm_field_int(data,UVM_ALL_ON)     //var data registration
   `uvm_object_utils_end

   function new (string name = "transaction");
      super.new(name);
   endfunction:new
endclass:transaction

