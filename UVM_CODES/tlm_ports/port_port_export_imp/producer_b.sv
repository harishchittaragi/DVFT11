class producer_b extends uvm_component;
   
   producer_a pa_h;

   //port creation
   uvm_blocking_put_port # (transaction) pass_a;
   `uvm_component_utils(producer_b)

   function new(string name = "producer_b", uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      pa_h=producer_a :: type_id :: create("pa_h",this);
      pass_a=new("pass_a",this);
   endfunction:build_phase
   
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      pa_h.send.connect(this.pass_a);
   endfunction:connect_phase

endclass:producer_b

