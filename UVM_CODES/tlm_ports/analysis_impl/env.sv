class env extends uvm_env;
   //calling producer and consumer_a classes:
   producer p_h;
   consumer_a ca_h;

   `uvm_component_utils(env)

   function new(string name = "env", uvm_component parent =null);
      super.new(name,parent);
      `uvm_info(get_type_name(),"This is new constructor of env class",UVM_NONE);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      p_h=producer::type_id :: create("p_h",this);
      ca_h=consumer_a::type_id :: create("ca_h",this);
   endfunction:build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      p_h.send.connect(ca_h.r1);
      p_h.send.connect(ca_h.cb_h.r2);
   endfunction:connect_phase
endclass:env

