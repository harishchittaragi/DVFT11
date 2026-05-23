class test extends uvm_test;
   env env_h;
   `uvm_component_utils(test)
   
   function new(string name = "test", uvm_component parent=null);
      super.new(name,parent);
      `uvm_info(get_type_name(),"This is new constructor of test class",UVM_NONE);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env_h=env::type_id :: create("env_h",this);
   endfunction:build_phase
endclass:test
