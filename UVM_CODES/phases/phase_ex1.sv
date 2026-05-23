import uvm_pkg::*;
`include "uvm_macros.svh" // this two lines are importing uvm packages

//------------MONITOR CLASS-------------------------------------//
class monitor extends uvm_monitor;

   `uvm_component_utils(monitor)

   function new (string name = "monitor", uvm_component parent =null);
      super.new(name,parent);
      $display("This is monitor new block");
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      $display("This is monitor build phase");
   endfunction:build_phase

  function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     $display("This is monitor connect_phase");
  endfunction:connect_phase

  function void end_of_elaboration_phase(uvm_phase phase);
     super.end_of_elaboration_phase(phase);
     $display("This is monitor end_of_elaboration_phase");
  endfunction:end_of_elaboration_phase

  function void start_of_simulation_phase(uvm_phase phase);
     super.start_of_simulation_phase(phase);
     $display("This is monitor start_of_simulation_phase");
  endfunction:start_of_simulation_phase

  task run_phase(uvm_phase phase);
     super.run_phase(phase);
     $display("this is monitor run_phase");
     phase.raise_objection(this);
     #6;
     $display("after time delay in monitor run phase   {%0t}",$time);
     phase.drop_objection(this);
  endtask:run_phase

  task reset_phase(uvm_phase phase);
     super.reset_phase(phase);
     $display("this is monitor reset_phase");
  endtask:reset_phase

  task configure_phase(uvm_phase phase);
     super.configure_phase(phase);
     $display("this is monitor configure_phase");
  endtask:configure_phase
  
  task main_phase(uvm_phase phase);
     super.main_phase(phase);
     $display("this is monitor main_phase");
  endtask:main_phase

  task shutdown_phase(uvm_phase phase);
     super.shutdown_phase(phase);
     $display("this is monitor shutdown_phase");
  endtask:shutdown_phase

  function void extract_phase(uvm_phase phase);
     super.extract_phase(phase);
     $display("This is monitor extract_phase");
  endfunction:extract_phase

  function void check_phase(uvm_phase phase);
     super.check_phase(phase);
     $display("This is monitor check_phase");
  endfunction:check_phase

  function void report_phase(uvm_phase phase);
     super.report_phase(phase);
     $display("This is monitor report_phase");
  endfunction:report_phase

  function void final_phase(uvm_phase phase);
     super.final_phase(phase);
     $display("This is monitor final_phase");
  endfunction:final_phase
endclass:monitor
//=============================================================================//
//
//--------------------DRIVER CLASS---------------------------------------------//
class driver extends uvm_driver;
   `uvm_component_utils(driver)

   function new (string name = "driver", uvm_component parent =null);
      super.new(name,parent);
      $display("This is driver new block");
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      $display("This is driver build phase");
   endfunction:build_phase

  function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     $display("This is driver connect_phase");
  endfunction:connect_phase

  function void end_of_elaboration_phase(uvm_phase phase);
     super.end_of_elaboration_phase(phase);
     $display("This is driver end_of_elaboration_phase");
  endfunction:end_of_elaboration_phase

  function void start_of_simulation_phase(uvm_phase phase);
     super.start_of_simulation_phase(phase);
     $display("This is driver start_of_simulation_phase");
  endfunction:start_of_simulation_phase

  task run_phase(uvm_phase phase);
     super.run_phase(phase);
     $display("this is driver run_phase");
     phase.raise_objection(this);
     #8;
     $display("after time delay in driver run phase   {%0t}",$time);
     phase.drop_objection(this);
  endtask:run_phase

  task reset_phase(uvm_phase phase);
     super.reset_phase(phase);
     $display("this is driver reset_phase");
  endtask:reset_phase

  task configure_phase(uvm_phase phase);
     super.configure_phase(phase);
     $display("this is driver configure_phase");
  endtask:configure_phase
  
  task main_phase(uvm_phase phase);
     super.main_phase(phase);
     $display("this is driver main_phase");
  endtask:main_phase

  task shutdown_phase(uvm_phase phase);
     super.shutdown_phase(phase);
     $display("this is driver shutdown_phase");
  endtask:shutdown_phase

  function void extract_phase(uvm_phase phase);
     super.extract_phase(phase);
     $display("This is driver extract_phase");
  endfunction:extract_phase

  function void check_phase(uvm_phase phase);
     super.check_phase(phase);
     $display("This is driver check_phase");
  endfunction:check_phase

  function void report_phase(uvm_phase phase);
     super.report_phase(phase);
     $display("This is driver report_phase");
  endfunction:report_phase

  function void final_phase(uvm_phase phase);
     super.final_phase(phase);
     $display("This is driver final_phase");
  endfunction:final_phase
endclass:driver
//====================================================================//
//
//---------------AGENT CLASS -----------------------------------------//
class agent extends uvm_agent;
   driver driver_h;            //handle creating for driver
   monitor monitor_h;          // handle creating for monitor
// moniotr amonitor_h;         //this memory creation is based on aplhabetic order of handle names   
 
  `uvm_component_utils(agent)  // registration to factory for default function calling

  // This below three lines must present in all the classes.  
  function new(string name = "agent", uvm_component parent =null);
     super.new(name,parent);
     $display("This is agent new block");
  endfunction

//=====build_phase=========//
//-->memory creation
//
  function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     $display("This is agent build_phase");
     driver_h=driver::type_id::create("driver",this);//<----memory creation for driver
     monitor_h=monitor::type_id::create("monitor",this);//<---memory creation for monitor
  endfunction

//=====connect_phase=======//
//--connection using tlm ports
  function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     $display("This is agent connect_phase");
  endfunction:connect_phase

//=====end_of_elaboration_phase=====//
//---for writing any type display statements;
  function void end_of_elaboration_phase(uvm_phase phase);
     super.end_of_elaboration_phase(phase);
     $display("This is agent end_of_elaboration_phase");
  endfunction:end_of_elaboration_phase

//====start_of_simulation_phase=======//
  function void start_of_simulation_phase(uvm_phase phase);
     super.start_of_simulation_phase(phase);
     $display("This is agent start_of_simulation_phase");
  endfunction:start_of_simulation_phase

//=====run_phase==============//
  task run_phase(uvm_phase phase);
     super.run_phase(phase);
     $display("this is agent run_phase");
     phase.raise_objection(this);
     #1;
     $display("after time delay in agent run phase   {%0t}",$time);
     phase.drop_objection(this);
  endtask:run_phase

//=======reset_phase=========//
  task reset_phase(uvm_phase phase);
     super.reset_phase(phase);
     $display("this is agent reset_phase");
  endtask:reset_phase

//========configure_phase====//
  task configure_phase(uvm_phase phase);
     super.configure_phase(phase);
     $display("this is agent configure_phase");
  endtask:configure_phase

//========main_phase========//
  task main_phase(uvm_phase phase);
     super.main_phase(phase);
     $display("this is agent main_phase");
  endtask:main_phase

//========shutdown_phase=====//
  task shutdown_phase(uvm_phase phase);
     super.shutdown_phase(phase);
     $display("this is agent shutdown_phase");
  endtask:shutdown_phase

//========extract_phase======//
  function void extract_phase(uvm_phase phase);
     super.extract_phase(phase);
     $display("This is agent extract_phase");
  endfunction:extract_phase

//========check_phase========//
  function void check_phase(uvm_phase phase);
     super.check_phase(phase);
     $display("This is agent check_phase");
  endfunction:check_phase

//========report_phase=======//
  function void report_phase(uvm_phase phase);
     super.report_phase(phase);
     $display("This is agent report_phase");
  endfunction:report_phase

//========final_phase========//
  function void final_phase(uvm_phase phase);
     super.final_phase(phase);
     $display("This is agent final_phase");
  endfunction:final_phase
endclass:agent
//=====================================================================//

//-------------------------------ENV CLASS-----------------------------//
class env extends uvm_env;
  agent agent_h;
  `uvm_component_utils(env)
  function new(string name = "env", uvm_component parent =null);
     super.new(name,parent);
     $display("This is env new block");
  endfunction

  function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     $display("This is env build_phase");
     agent_h=agent::type_id::create("agent_h",this);
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
     phase.raise_objection(this);
     #5;
     $display("after time delay in env run phase   {%0t}",$time);
     phase.drop_objection(this);
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
     $display("this is env main_phase");
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
     phase.raise_objection(this);
     #2;
     $display("after time delay in test run phase   {%0t}",$time);
     phase.drop_objection(this);
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
