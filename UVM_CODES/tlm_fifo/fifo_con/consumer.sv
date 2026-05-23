class consumer extends uvm_component;
   transaction tr; 
   //creating implementation port here:
   uvm_blocking_get_port # (transaction) recieve;
   `uvm_component_utils(consumer)

   function new(string name = "consumer", uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      recieve=new("recieve",this);
   endfunction:build_phase

   task run_phase(uvm_phase phase);
      tr=transaction :: type_id :: create ("tr");
      recieve.get(tr);
      tr.print();
   endtask
endclass:consumer

