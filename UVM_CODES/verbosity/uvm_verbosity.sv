//this code block is related to
/*-->verbosities
      --UVM_NONE   :-(000) always printed cannot be filtered out.
      --UVM_LOW    :-(100) critical info for regression logs.
      --UVM_MEDIUM :-(200) default general periodic statements updates.
      --UVM_HIGH   :-(300) detailed configuration or entry/exit info.
      --UVM_FULL   :-(400) extremely detailed (ex:packet,data,loops).
      --UVM_DEBUG  :-(500) highest level,typically for debugging the uvm library.
      */ 

/* run command for verbosities
 vcs -full64 -sverilog -R -debug_access+all file_name.sv +UVM_VERBOSITY=verbosity_name(ex:UVM_NONE)*/

/*-->'uvm_info 
      -- `uvm_info("id","display_statement",verbosity_name);*/

/*--> print()
       ==table printer
         --1. print();
         --2. uvm_default_printer=uvm_default_table_printer
              print();

       ==line printer
         --1. uvm_default_printer=uvm_default_line_printer
              print();
         --2. print(uvm_default_line_printer);

       ==tree printer
         --1. uvm_default_printer=uvm_default_tree_printer
              print();
         --2. print(uvm_default_tree_printer);         */   


import uvm_pkg::*;
`include "uvm_macros.svh"
//-------------------------------ENV CLASS-----------------------------//
class env extends uvm_env;
   bit [7:0] b = 8'hA;
  //variable registration into factory. 
  `uvm_component_utils_begin(env)
  `uvm_field_int(b,UVM_ALL_ON)
  `uvm_component_utils_end
  function new(string name = "env", uvm_component parent =null);
     super.new(name,parent);
     `uvm_info(get_type_name(),"This is env new block",UVM_NONE);
  endfunction

  function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     `uvm_info(get_type_name(),"This is env build_phase",UVM_NONE);
  endfunction:build_phase
  
  function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     `uvm_info(get_type_name(),"This is env connect_phase",UVM_NONE);
  endfunction:connect_phase

  function void end_of_elaboration_phase(uvm_phase phase);
     super.end_of_elaboration_phase(phase);
     `uvm_info(get_type_name(),"This is env end_of_elaboration_phase",UVM_NONE);
  endfunction:end_of_elaboration_phase

  function void start_of_simulation_phase(uvm_phase phase);
     super.start_of_simulation_phase(phase);
     `uvm_info(get_type_name(),"This is env start_of_simulation_phase",UVM_NONE);
  endfunction:start_of_simulation_phase

  task run_phase(uvm_phase phase);
     super.run_phase(phase);
     `uvm_info(get_type_name(),"this is env run_phase",UVM_NONE);
//     phase.raise_objection(this);
     #5;
//     `uvm_info(get_type_name(),"after time delay in env run phase   {%0t}",$time,UVM_NONE);
//     phase.drop_objection(this);
     print();
     /*-----------------------------------
        Name          Type      Size  Value
        -----------------------------------
        uvm_test_top  test      -     @337 
          env_h       env       -     @354 
            b         integral  8     'ha  
        -----------------------------------*/
     
  endtask:run_phase

  task reset_phase(uvm_phase phase);
     super.reset_phase(phase);
     `uvm_info(get_type_name(),"this is env reset_phase",UVM_NONE);
  endtask:reset_phase

  task configure_phase(uvm_phase phase);
     super.configure_phase(phase);
     `uvm_info(get_type_name(),"this is env configure_phase",UVM_NONE);
  endtask:configure_phase
  
  task main_phase(uvm_phase phase);
     super.main_phase(phase);
//     phase.raise_objection(this);
     `uvm_info(get_type_name(),"This is env main_phase",UVM_NONE);
//     #10;
//     `uvm_info(get_type_name(),"This is env main_phase after time {%0t}",$time,UVM_NONE);
//     phase.drop_objection(this);
  endtask:main_phase

  task shutdown_phase(uvm_phase phase);
     super.shutdown_phase(phase);
     `uvm_info(get_type_name(),"this is env shutdown_phase",UVM_NONE);
  endtask:shutdown_phase

  function void extract_phase(uvm_phase phase);
     super.extract_phase(phase);
     `uvm_info(get_type_name(),"This is env extract_phase",UVM_NONE);
     print(uvm_default_line_printer);// o/p:-> env_h: (env@354) { b: 'ha  } 
  endfunction:extract_phase

  function void check_phase(uvm_phase phase);
     super.check_phase(phase);
     `uvm_info(get_type_name(),"This is env check_phase",UVM_NONE);
     print(uvm_default_tree_printer);
      /*env_h: (env@354) {
          b: 'ha 
         }    */
  endfunction:check_phase

  function void report_phase(uvm_phase phase);
     super.report_phase(phase);
     `uvm_info(get_type_name(),"This is env report_phase",UVM_NONE);
  endfunction:report_phase

  function void final_phase(uvm_phase phase);
     super.final_phase(phase);
     `uvm_info(get_type_name(),"This is env final_phase",UVM_NONE);
  endfunction:final_phase
endclass:env
//=======================================================================//

//-------------------------TEST CLASS-----------------------------------//
class test extends uvm_test;
   bit [7:0] a;
   env env_h;
   `uvm_component_utils(test)
  function new(string name = "test", uvm_component parent =null);
     super.new(name,parent);
     `uvm_info(get_type_name(),"This is test new block",UVM_NONE);
  endfunction

  function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     `uvm_info(get_type_name(),"This is test build_phase",UVM_NONE);
     env_h=env::type_id::create("env_h",this);
  endfunction:build_phase

  function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     `uvm_info(get_type_name(),"This is test connect_phase",UVM_NONE);
     print();
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
//     phase.raise_objection(this);
//     #2;
//     `uvm_info(get_type_name(),"after time delay in test run phase   {%0t}",$time,UVM_NONE);
//      phase.drop_objection(this);
  endtask:run_phase

  task reset_phase(uvm_phase phase);
     super.reset_phase(phase);
     `uvm_info(get_type_name(),"this is test reset_phase",UVM_NONE);
     print();
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
