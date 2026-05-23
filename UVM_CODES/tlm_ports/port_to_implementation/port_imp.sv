
`include "uvm_macros.svh"
import uvm_pkg ::*;
//--------------class my_trans extended from uvm_sequence_item--------------//
class my_trans extends uvm_sequence_item;
  rand int addr; //variable declaring with int type
  rand int data;
   `uvm_object_utils_begin(my_trans) //factory registration for my_trans
    `uvm_field_int(addr,UVM_ALL_ON)  //factory registartion for addr variable
    `uvm_field_int(data,UVM_ALL_ON)
   `uvm_object_utils_end

   function new(string name="my_trans"); // for objects there is no parent statement here
      super.new(name);
      `uvm_info(get_type_name(),"New constructor of my_trans",UVM_NONE);
   endfunction:new
endclass:my_trans
//=============================================================================//
//
//----------------compa example taken from uvm_component-------------------//
class compa extends uvm_component;
   my_trans tr; //handle assignment for my_trans

   uvm_blocking_put_port # (my_trans) put_port;
           // port declaration of my_trans type put_port is own declaration(we can gave any name).
   `uvm_component_utils_begin(compa)
    `uvm_field_object(tr,UVM_ALL_ON)
   `uvm_component_utils_end

   function new(string name = "compa",uvm_component parent=null);
      super.new(name,parent);
      `uvm_info(get_type_name(),"this is compa construction block",UVM_NONE);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info(get_type_name(),"This is build_phase of compa",UVM_NONE);
       tr=new("tr");     // memory creation for objects using new method need only one arg fix.
       put_port=new("put_port",this); // memory creation for ports needs two args fix.
   endfunction:build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info(get_type_name(),"This is connect_phase of compa",UVM_NONE);
   endfunction:connect_phase

   task run_phase(uvm_phase phase);
      super.run_phase(phase);
      tr.randomize();
      put_port.put(tr);
      `uvm_info(get_type_name(),$sformatf("ADDR = %0h | DATA = %0h",tr.addr,tr.data),UVM_NONE);
     // tr.print();
   endtask:run_phase
endclass:compa

class compb extends uvm_component;
   uvm_blocking_put_imp #(my_trans,compb) put_imp;
   `uvm_component_utils_begin(compb)
   `uvm_component_utils_end

   function new(string name = "compb",uvm_component parent=null);
      super.new(name,parent);
      `uvm_info(get_type_name(),"this is compb construction block",UVM_NONE);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info(get_type_name(),"This is build_phase of compb",UVM_NONE);
      put_imp=new("put_imp",this);
   endfunction:build_phase
//Actual receive
  task put(my_trans tr);
     `uvm_info(get_type_name(),"Printing from compb",UVM_NONE);
     tr.print();
  endtask:put

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info(get_type_name(),"This is connect_phase of compb",UVM_NONE);
   endfunction:connect_phase
endclass:compb

class test extends uvm_test;
   compa compa_h;
   compb compb_h;
   `uvm_component_utils(test)
   function new(string name = "test",uvm_component parent = null);
      super.new(name, parent);
      `uvm_info(get_type_name(),"This is constructor of test class",UVM_NONE);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info(get_type_name(),"This is build_phase of test class",UVM_NONE);
      compa_h = compa ::type_id ::create("compa_h",this);
      compb_h = compb ::type_id ::create("compb_h",this);
   endfunction:build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info(get_type_name(),"This is connect_phase of test class",UVM_NONE);
      compa_h.put_port.connect(compb_h.put_imp);
   endfunction:connect_phase
endclass:test

module tb();
initial 
   run_test("test");
endmodule:tb

   






