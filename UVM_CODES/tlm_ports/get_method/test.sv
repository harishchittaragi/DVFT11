class test extends uvm_test;

   producer p_h;
   consumer c_h;

   `uvm_component_utils(test)

   function new(string name = "test",uvm_component parent = null);
      super.new(name, parent);
//      `uvm_info(get_type_name(),"This is constructor of test class",UVM_NONE);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
//      `uvm_info(get_type_name(),"This is build_phase of test class",UVM_NONE);
      p_h = producer ::type_id ::create("p_h",this);
      c_h = consumer ::type_id ::create("c_h",this);
   endfunction:build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
//      `uvm_info(get_type_name(),"This is connect_phase of test class",UVM_NONE);
      c_h.receive.connect(p_h.send);
   endfunction:connect_phase

   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      #100;
      phase.drop_objection(this);
   endtask:run_phase
endclass:test

