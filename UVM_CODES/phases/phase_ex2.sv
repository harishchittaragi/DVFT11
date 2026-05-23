//time delay baseed execution flow
/*when we applied any delays in subphases and we were not adding any
raise/drop objections then it will not consider that dealy and will not
display the statements after that delay*/
/*when we apply any delays in run_phase and not mentioned any objections and
* we mentioned that objections inside the subphases then the delay of run
* phase will be considered and the statements will execute at that time
* (condition===time_delay_of_run_phase < time_delay_of_sub_phases)*/
import uvm_pkg::*;
`include "uvm_macros.svh"
//-------------------------------ENV CLASS-----------------------------//
class env extends uvm_env;
  `uvm_component_utils(env)
  function new(string name = "env", uvm_component parent =null);
     super.new(name,parent);
     $display("This is env new block");
  endfunction

  function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     $display("This is env build_phase");
  endfunction:build_phase
  
  function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     $display("This is env connect_phase");
  endfunction:connect_phase

  function void end_of_elaboration_phase(uvm_phase phase);
     super.end_of_elaboration_phase(phase);
     $display("This is env end_of_elaboration_phase");
  endfunction:end_of_elaboration_phase

  function void start_of_simulation_phase(uvm_phase phase);
     super.start_of_simulation_phase(phase);
     $display("This is env start_of_simulation_phase");
  endfunction:start_of_simulation_phase

  task run_phase(uvm_phase phase);
     super.run_phase(phase);
     $display("this is env run_phase");
//     phase.raise_objection(this);
     #5;
     $display("after time delay in env run phase   {%0t}",$time);
//     phase.drop_objection(this);
  endtask:run_phase

  task reset_phase(uvm_phase phase);
     super.reset_phase(phase);
     $display("this is env reset_phase");
  endtask:reset_phase

  task configure_phase(uvm_phase phase);
     super.configure_phase(phase);
     $display("this is env configure_phase");
  endtask:configure_phase
  
  task main_phase(uvm_phase phase);
     super.main_phase(phase);
     phase.raise_objection(this);
     $display("This is env main_phase");
     #10;
     $display("This is env main_phase after time {%0t}",$time);
     phase.drop_objection(this);
  endtask:main_phase

  task shutdown_phase(uvm_phase phase);
     super.shutdown_phase(phase);
     $display("this is env shutdown_phase");
  endtask:shutdown_phase

  function void extract_phase(uvm_phase phase);
     super.extract_phase(phase);
     $display("This is env extract_phase");
  endfunction:extract_phase

  function void check_phase(uvm_phase phase);
     super.check_phase(phase);
     $display("This is env check_phase");
  endfunction:check_phase

  function void report_phase(uvm_phase phase);
     super.report_phase(phase);
     $display("This is env report_phase");
  endfunction:report_phase

  function void final_phase(uvm_phase phase);
     super.final_phase(phase);
     $display("This is env final_phase");
  endfunction:final_phase
endclass:env
//=======================================================================//

//-------------------------TEST CLASS-----------------------------------//
class test extends uvm_test;
  env env_h;
  `uvm_component_utils(test)
  function new(string name = "test", uvm_component parent =null);
     super.new(name,parent);
     $display("This is test new block");
  endfunction

  function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     $display("This is test build_phase");
     env_h=env::type_id::create("env_h",this);
  endfunction:build_phase

  function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     $display("This is test connect_phase");
  endfunction:connect_phase

  function void end_of_elaboration_phase(uvm_phase phase);
     super.end_of_elaboration_phase(phase);
     $display("This is test end_of_elaboration_phase");
  endfunction:end_of_elaboration_phase

  function void start_of_simulation_phase(uvm_phase phase);
     super.start_of_simulation_phase(phase);
     $display("This is test start_of_simulation_phase");
  endfunction:start_of_simulation_phase

  task run_phase(uvm_phase phase);
     super.run_phase(phase);
     $display("this is test run_phase");
    // phase.raise_objection(this);
     #2;
     $display("after time delay in test run phase   {%0t}",$time);
    // phase.drop_objection(this);
  endtask:run_phase

  task reset_phase(uvm_phase phase);
     super.reset_phase(phase);
     $display("this is test reset_phase");
  endtask:reset_phase

  task configure_phase(uvm_phase phase);
     super.configure_phase(phase);
     $display("this is test configure_phase");
  endtask:configure_phase
  
  task main_phase(uvm_phase phase);
     super.main_phase(phase);
     $display("this is test main_phase");
  endtask:main_phase

  task shutdown_phase(uvm_phase phase);
     super.shutdown_phase(phase);
     $display("this is test shutdown_phase");
  endtask:shutdown_phase

  function void extract_phase(uvm_phase phase);
     super.extract_phase(phase);
     $display("This is test extract_phase");
  endfunction:extract_phase

  function void check_phase(uvm_phase phase);
     super.check_phase(phase);
     $display("This is test check_phase");
  endfunction:check_phase

  function void report_phase(uvm_phase phase);
     super.report_phase(phase);
     $display("This is test report_phase");
  endfunction:report_phase

  function void final_phase(uvm_phase phase);
     super.final_phase(phase);
     $display("This is test final_phase");
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
