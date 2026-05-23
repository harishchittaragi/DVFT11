class env extends uvm_env;
   //calling producer_a and consumer classes:
   producer_a pa_h;
   producer_b pb_h;
   consumer c_h;

   `uvm_component_utils(env)

   function new(string name = "env", uvm_component parent =null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      pa_h=producer_a::type_id :: create("pa_h",this);
      pb_h=producer_b::type_id :: create("pb_h",this);
      c_h=consumer::type_id :: create("c_h",this);
   endfunction:build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      pa_h.s1.connect(c_h.r1);
      pb_h.s2.connect(c_h.r2);
   endfunction:connect_phase
endclass:env

