import uvm_pkg::*;
`include "uvm_macros.svh" // this two lines are importing uvm packages

//------------MONITOR CLASS-------------------------------------//
class monitor extends uvm_component;

   `uvm_component_utils(monitor)

   function new (string name = "monitor", uvm_component parent =null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
   endfunction:build_phase

  task run_phase(uvm_phase phase);
     super.run_phase(phase);
     `uvm_info(get_type_name(),"This is monitor run_phase",UVM_NONE);
  endtask:run_phase
 endclass:monitor
//=============================================================================//
//
//--------------------DRIVER CLASS---------------------------------------------//
class driver extends uvm_component;
   `uvm_component_utils(driver)

   function new (string name = "driver", uvm_component parent =null);
      super.new(name,parent);
   endfunction:new

virtual   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      $display("build phase 321");
   endfunction:build_phase

  task run_phase(uvm_phase phase);
    // super.run_phase(phase);
     `uvm_info(get_type_name(),"This is driver run_phase",UVM_NONE);
  endtask:run_phase
 endclass:driver
//====================================================================//
//
//--------------------Dummy_DRIVER CLASS---------------------------------------------//
class dummy_driver extends driver;
   `uvm_component_utils(dummy_driver)

   function new (string name = "dummy_driver", uvm_component parent =null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
//      super.build_phase(phase);  /*if this lines written means it will display driver class build _                                      phase display statements also*/
//      $display("build phase 123");
   endfunction:build_phase

  task run_phase(uvm_phase phase);
    // super.run_phase(phase); /*if this lines written means it will display driver class run_phase                                     display statements also*/

     `uvm_info(get_type_name(),"this is dummy_driver run_phase",UVM_NONE);
  endtask:run_phase
 endclass:dummy_driver
//====================================================================//
//

//---------------AGENT CLASS -----------------------------------------//
class agent extends uvm_component;
   driver driver_h;            //handle creating for driver
   monitor monitor_h;          // handle creating for monitor
 
  `uvm_component_utils(agent)  // registration to factory for default function calling

  function new(string name = "agent", uvm_component parent =null);
     super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     driver_h=driver::type_id::create("driver_h",this);//<----memory creation for driver
     monitor_h=monitor::type_id::create("monitor_h",this);//<---memory creation for monitor
  endfunction

  task run_phase(uvm_phase phase);
     super.run_phase(phase);
     `uvm_info(get_type_name(),"This is agent run_phase",UVM_NONE);
  endtask:run_phase
endclass:agent
//=====================================================================//

//-------------------------------ENV CLASS-----------------------------//
class env extends uvm_component;
  agent agent_h;
  `uvm_component_utils(env)
  function new(string name = "env", uvm_component parent =null);
     super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     agent_h=agent::type_id::create("agent_h",this);
  endfunction:build_phase
  
  task run_phase(uvm_phase phase);
     super.run_phase(phase);
     `uvm_info(get_type_name(),"This is env run_phase",UVM_NONE);
  endtask:run_phase
 endclass:env
//=======================================================================//

//-------------------------TEST CLASS-----------------------------------//
class test extends uvm_test;
  env env_h;
  `uvm_component_utils(test)
  function new(string name = "test", uvm_component parent =null);
     super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     env_h=env::type_id::create("env_h",this);
// Overriding existed driver to dummy_driver 
//// type-type
//     set_type_override_by_type(
//        driver::get_type(),
//        dummy_driver::get_type()
//     );

//// type-name
//     uvm_factory::get().set_type_override_by_name(
//        "driver",
//        "dummy_driver",
//        1
//     );

////inst-type
     uvm_factory::get().set_inst_override_by_type(
        driver::get_type(),
        dummy_driver::get_type(),
        "uvm_test_top.env_h.agent_h.driver_h"
    );

////inst-name
//     uvm_factory::get().set_inst_override_by_name(
//        "driver",
//        "dummy_driver",
//        "env_h.agent_h.driver"
//     );

  endfunction:build_phase

    task run_phase(uvm_phase phase);
     super.run_phase(phase);
     `uvm_info(get_type_name(),"This is test run_phase",UVM_NONE);
       endtask:run_phase
 endclass:test
//========================================================//

// ------------------MODULE-------------------------------//
module phase_ex1();
initial begin
run_test("test");
end
endmodule:phase_ex1
//========================================================//
