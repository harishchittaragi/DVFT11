class consumer_b extends uvm_component;
    
   //creating implementation port here:
   uvm_blocking_put_imp # (transaction,consumer_b) recieve;
   `uvm_component_utils(consumer_b)

   function new(string name = "consumer_b", uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      recieve=new("recieve",this);
   endfunction:build_phase

   task put(transaction tr);
      tr.print();
   endtask
endclass

