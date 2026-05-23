typedef enum {RED, WHITE, PINK} colours; 
class transaction extends uvm_sequence_item;
   
   //variable declaration
   rand int a;
   rand byte b;
        real r=1000.000;
        string s;
   rand colours col_h;
   rand my_object obj;
   rand bit [7:0] mem [3:0];

   //factory registration
   `uvm_object_utils_begin(transaction) //object registration
    `uvm_field_int(a,UVM_ALL_ON)     //var addr registration
    `uvm_field_int(b,UVM_ALL_ON)     //var data registration
    `uvm_field_real(r,UVM_NOCOPY)     //var data registration
    `uvm_field_string(s,UVM_NOCOPY)     //var data registration
    `uvm_field_enum(colours,col_h,UVM_ALL_ON)     //var data registration
    `uvm_field_object(obj,UVM_ALL_ON)     //var data registration
    `uvm_field_sarray_int(mem,UVM_ALL_ON)     //var data registration
   `uvm_object_utils_end

   function new (string name = "transaction");
      super.new(name);
      obj=my_object :: type_id :: create("obj");
   endfunction:new
endclass:transaction

