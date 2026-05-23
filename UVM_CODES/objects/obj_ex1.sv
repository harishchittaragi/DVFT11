import uvm_pkg::*;
`include "uvm_macros.svh"
//---------------------uvm_sequence_item------------------------------//
class my_object extends uvm_sequence_item;
   int a;
   `uvm_object_utils_begin(my_object)
   `uvm_field_int(a,UVM_ALL_ON)
   `uvm_object_utils_end
   function new(string name = "my_object");
      super.new(name);
      `uvm_info(get_type_name(),"uvm_sequence_item constructor",UVM_NONE);
   endfunction
endclass
//===================================================================//

//--------------------uvm_sequence----------------------------------//
class my_seq extends uvm_sequence #(my_object);
   //my_object obj;
    int b;
   `uvm_object_utils_begin(my_seq)
    `uvm_field_int(b,UVM_ALL_ON)
   `uvm_object_utils_end
   function new(string name = "my_seq");
      super.new(name);
      `uvm_info(get_name(),"my_seq constructor",UVM_NONE);
   endfunction

   task body();
      `uvm_do(req);
   endtask
endclass
//===================================================================//

//-----------------------test class--------------------------------//
class test extends uvm_test;
   my_object obj;
   my_seq seq1;
   `uvm_component_utils_begin(test)
   `uvm_field_object(obj,UVM_ALL_ON)
   `uvm_field_object(seq1,UVM_ALL_ON)
   `uvm_component_utils_end

  function new(string name = "test", uvm_component parent =null);
     super.new(name,parent);
     `uvm_info(get_type_name(),"This is test new block",UVM_NONE);
  endfunction

  function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     `uvm_info(get_type_name(),"This is test build_phase",UVM_NONE);
      obj = my_object ::type_id ::create ("obj");
      seq1 = my_seq ::type_id ::create ("seq1");
      obj.a=100;
      seq1.b=10;
      print();
  endfunction:build_phase

  function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     `uvm_info(get_type_name(),"This is test connect_phase",UVM_NONE);
     //print();
  endfunction:connect_phase

  function void end_of_elaboration_phase(uvm_phase phase);
     super.end_of_elaboration_phase(phase);
     `uvm_info(get_type_name(),"This is test end_of_elaboration_phase",UVM_NONE);
  endfunction:end_of_elaboration_phase

  function void start_of_simulation_phase(uvm_phase phase);
     super.start_of_simulation_phase(phase);
     `uvm_info(get_type_name(),"This is test start_of_simulation_phase",UVM_NONE);
  endfunction:start_of_simulation_phase

  task run_phase(uvm_phase phase);
     super.run_phase(phase);
     `uvm_info(get_type_name(),"this is test run_phase",UVM_NONE);
  endtask:run_phase

  task reset_phase(uvm_phase phase);
     super.reset_phase(phase);
     `uvm_info(get_type_name(),"this is test reset_phase",UVM_NONE);
     //print();
  endtask:reset_phase

  task configure_phase(uvm_phase phase);
     super.configure_phase(phase);
     `uvm_info(get_type_name(),"this is test configure_phase",UVM_NONE);
  endtask:configure_phase
  
  task main_phase(uvm_phase phase);
     super.main_phase(phase);
     `uvm_info(get_type_name(),"this is test main_phase",UVM_NONE);
  endtask:main_phase

  task shutdown_phase(uvm_phase phase);
     super.shutdown_phase(phase);
     `uvm_info(get_type_name(),"this is test shutdown_phase",UVM_NONE);
  endtask:shutdown_phase

  function void extract_phase(uvm_phase phase);
     super.extract_phase(phase);
     `uvm_info(get_type_name(),"This is test extract_phase",UVM_NONE);
  endfunction:extract_phase

  function void check_phase(uvm_phase phase);
     super.check_phase(phase);
     `uvm_info(get_type_name(),"This is test check_phase",UVM_NONE);
  endfunction:check_phase

  function void report_phase(uvm_phase phase);
     super.report_phase(phase);
     `uvm_info(get_type_name(),"This is test report_phase",UVM_NONE);
  endfunction:report_phase

  function void final_phase(uvm_phase phase);
     super.final_phase(phase);
     `uvm_info(get_type_name(),"This is test final_phase",UVM_NONE);
  endfunction:final_phase
endclass:test
//========================================================//

// ------------------MODULE-------------------------------//
module phase_ex1();
initial begin
run_test("test");
end
endmodule:phase_ex1
//========================================================//
