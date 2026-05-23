class transaction extends uvm_sequence_item;
  rand int addr; //variable declaring with int type
  rand int data;

   `uvm_object_utils_begin(transaction) //factory registration for my_trans
    `uvm_field_int(addr,UVM_ALL_ON)  //factory registartion for addr variable
    `uvm_field_int(data,UVM_ALL_ON)
   `uvm_object_utils_end

   function new(string name="transaction"); // for objects there is no parent statement here
      super.new(name);
//      `uvm_info(get_type_name(),"New constructor of my_trans",UVM_NONE);
   endfunction:new
endclass:transaction

