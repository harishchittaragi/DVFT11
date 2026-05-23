class consumer_a extends uvm_component;
  
   //calling consumer_b class:
   consumer_b cb_h;

  //creating export
   uvm_blocking_put_export #(transaction) pass_b;

  // factory registration
   `uvm_component_utils(consumer_a)

   function new(string name = "consumer_a", uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      cb_h=consumer_b ::type_id :: create("cb_h",this);//memory creation for consumer_b class.
      pass_b=new("pass_b",this); //memory creation for export.
   endfunction:build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      //connecting export to implementation port
      pass_b.connect(cb_h.recieve);
   endfunction:connect_phase

endclass:consumer_a

