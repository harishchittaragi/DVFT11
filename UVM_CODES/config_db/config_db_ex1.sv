import uvm_pkg::*;
`include "uvm_macros.svh" // this two lines are importing uvm packages

//------------MONITOR CLASS-------------------------------------//
class monitor extends uvm_monitor;
   int a;
   string s;
   real r;

   `uvm_component_utils(monitor)

   function new (string name = "monitor", uvm_component parent =null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      $display("This is Monitor build_phase");
     uvm_config_db#(int)::get(this,"","location_1",a);
     `uvm_info(get_full_name(),$psprintf("The vaule of location_1 = %0d",a),UVM_NONE);
     uvm_config_db#(string)::get(this,"","location_2",s);
     `uvm_info(get_full_name(),$psprintf("The vaule of location_2 = %0s",s),UVM_NONE);
// checking connection using if condition statement
     if(uvm_config_db#(real)::get(this,"","location_3",r)) begin
     `uvm_info(get_full_name(),$psprintf("1111The vaule of location_3 = %0f",r),UVM_NONE);
      end
     else
       $display("not connected");
   endfunction:build_phase
endclass:monitor
//=============================================================================//
//
//--------------------DRIVER CLASS---------------------------------------------//
class driver extends uvm_driver;
   int a;
   string s;
   real r;
   `uvm_component_utils(driver)

   function new (string name = "driver", uvm_component parent =null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      $display("This is Driver build_phase");
     uvm_config_db #(int)::get(this,"","location_1",a);
     `uvm_info(get_full_name(),$psprintf("The vaule of location_1 = %0d",a),UVM_NONE);
     uvm_config_db #(string)::get(this,"","location_2",s);
     `uvm_info(get_full_name(),$psprintf("The vaule of location_2 = %0s",s),UVM_NONE);
     uvm_config_db #(real)::get(this,"","location_3",r);
     `uvm_info(get_full_name(),$psprintf("The vaule of location_3 = %0f",r),UVM_NONE);
   endfunction:build_phase
 endclass:driver
//====================================================================//
//
//---------------AGENT CLASS -----------------------------------------//
class agent extends uvm_agent;
   int a;
   string s;
   real r;
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

     $display("This is agent build_phase");
     uvm_config_db #(int)::get(this,"","location_1",a);
     `uvm_info(get_full_name(),$psprintf("The vaule of location_1 = %0d",a),UVM_NONE);
     uvm_config_db #(string)::get(this,"","location_2",s);
     `uvm_info(get_full_name(),$psprintf("The vaule of location_2 = %0s",s),UVM_NONE);
     uvm_config_db #(real)::get(this,"","location_3",r);
     `uvm_info(get_full_name(),$psprintf("The vaule of location_3 = %0f",r),UVM_NONE);
  endfunction

endclass:agent
//=====================================================================//

//-------------------------------ENV CLASS-----------------------------//
class env extends uvm_env;
   int a;
   string s;
   real r;
  agent agent_h;
  `uvm_component_utils(env)
  function new(string name = "env", uvm_component parent =null);
     super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     agent_h=agent::type_id::create("agent_h",this);

     $display("This is env build_phase");
// get_method of config_db is calling here to dispaly value of a from test class     
     uvm_config_db #(int)::get(this,"","location_1",a);
     `uvm_info(get_full_name(),$psprintf("The vaule of location_1 = %0d",a),UVM_NONE);
     uvm_config_db #(string)::get(this,"","location_2",s);
     `uvm_info(get_full_name(),$psprintf("The vaule of location_2 = %0s",s),UVM_NONE);
     uvm_config_db #(real)::get(this,"","location_3",r);
     `uvm_info(get_full_name(),$psprintf("The vaule of location_3 = %0f",r),UVM_NONE);
  endfunction:build_phase
endclass:env
//=======================================================================//

//-------------------------TEST CLASS-----------------------------------//
class test extends uvm_test;
   int a;
   string s;
   real r;
  env env_h;
  `uvm_component_utils(test)
  function new(string name = "test", uvm_component parent =null);
     super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     env_h=env::type_id::create("env_h",this);

// Declaring config_db set method:
/* before entering into run phase set the values properly so we need to
 declare here in build_phase*/

//     uvm_config_db # (int) :: set(this,"env_h","location_1",10);
//
/*  The below set method path will gave access of loc_1 to all its below heirarchy include its curren     t heirarchy*/
     uvm_config_db # (int) :: set(this,"env_h*","location_1",10);

/*  The below set method path will gave access of loc_1 to all its below heirarchy but not its curren     t heirarchy because (env_h.*) here dot is there*/
//     uvm_config_db # (int) :: set(this,"env_h.*","location_1",10);

     uvm_config_db#(string)::set(this,"env_h.agent_h","location_2","Harish");
     uvm_config_db#(real)::set(this,"env_h.agent_h.monitor_h","location_3",5.4);
     
     $display("This is test build_phase");
// get_method of config_db is calling here to dispaly value of locations inside test class     
     uvm_config_db #(int)::get(this,"","location_1",a);
     `uvm_info(get_full_name(),$psprintf("The vaule of location_1 = %0d",a),UVM_NONE);
     uvm_config_db #(string)::get(this,"","location_2",s);
     `uvm_info(get_full_name(),$psprintf("The vaule of location_2 = %0s",s),UVM_NONE);
     uvm_config_db #(real)::get(this,"","location_3",r);
     `uvm_info(get_full_name(),$psprintf("The vaule of location_3 = %0f",r),UVM_NONE);
  endfunction:build_phase

  function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
  endfunction:connect_phase

endclass:test
//========================================================//

// ------------------MODULE-------------------------------//
module phase_ex1();
initial begin
run_test("test");
end
endmodule:phase_ex1
//========================================================//
/*NOTE:1
* --> this, use this inside config_db when set method called inside class
* --> null, use this inside config_db when set method and get method called
      inside module(static)
* --> uvm_config_db # (data_type) :: set (1st_param,"2nd_param","3rd_param","4th_param")
*     ^ 1st_param is == "this" (inside class),(defines currennt hierarchy handle) or "null" (inside m        odule)
*     ^ 2nd_param is == path(inside "") to access this location data ex:env_h.agent_h.driver_h 
*     ^ 3rd_param is == location_name inside "" (user_defined)
*     ^ 4th_param is == vaule or string based on type defined in--> #(type_name) :: */

/*NOTE:2
*  --> while writing inside the module any set() method or get() method then,
*     ^ 1st param is == null
*     ^ 2nd param is == start withn "uvm_test_top.env_h.*" (test handle created by factory) */
