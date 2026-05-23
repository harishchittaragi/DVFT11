class test extends uvm_test;
   //calling producer_b and consumer_a classes:
   producer_b pb_h;
   consumer_a ca_h;

   `uvm_component_utils(test)

   function new(string name = "test", uvm_component parent =null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      pb_h=producer_b::type_id :: create("pb_h",this);
      ca_h=consumer_a::type_id :: create("ca_h",this);
   endfunction:build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      pb_h.pass_a.connect(ca_h.pass_b);
   endfunction:connect_phase
endclass:test

