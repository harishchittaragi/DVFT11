class driver extends uvm_component;
   transaction tr;
   uvm_blocking_get_port # (transaction) receive;
   `uvm_component_utils(driver)

   function new(string name = "driver", uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      receive=new("receive",this);
   endfunction:build_phase

   task run_phase(uvm_phase phase);
      tr=transaction:: type_id::create("tr");
      receive.get(tr);
      `uvm_info(get_name(),"Displaying from driver class",UVM_NONE);
      tr.print();
   endtask:run_phase
endclass:driver
