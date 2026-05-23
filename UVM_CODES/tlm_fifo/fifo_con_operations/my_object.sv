class my_object extends uvm_sequence_item;
   
   //variable declaration
   rand logic addr;
   rand logic data;
   
   //factory registration
   `uvm_object_utils_begin(my_object) //object registration
    `uvm_field_int(addr,UVM_ALL_ON)     //var addr registration
    `uvm_field_int(data,UVM_ALL_ON)     //var data registration
   `uvm_object_utils_end

   function new (string name = "my_object");
      super.new(name);
   endfunction:new
endclass:my_object

