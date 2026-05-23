`uvm_blocking_put_imp_decl(_1)
`uvm_blocking_put_imp_decl(_2)

class consumer extends uvm_component;
   //creating implementation ports here:
   uvm_blocking_put_imp_1 # (transaction,consumer) r1;
   uvm_blocking_put_imp_2 # (transaction,consumer) r2;
   `uvm_component_utils(consumer)

   function new(string name = "consumer", uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      r1=new("r1",this);
      r2=new("r2",this);
   endfunction:build_phase

   task put_1 (transaction tr);
      tr.print();
   endtask

   task put_2 (transaction tr);
      tr.print();
   endtask
endclass:consumer
