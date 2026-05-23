class env extends uvm_env;
   //calling producer and consumer classes:
   producer p_h;
   consumer c_h;

   `uvm_component_utils(env)

   function new(string name = "env", uvm_component parent =null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      p_h=producer::type_id :: create("p_h",this);
      c_h=consumer::type_id :: create("c_h",this);
   endfunction:build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      p_h.p_port.connect(c_h.c_exp);
   endfunction:connect_phase
endclass:env

