class consumer_b extends uvm_component;
    
   //creating implementation port here:
   uvm_blocking_put_imp # (transaction,consumer_b) recieve;
   `uvm_component_utils(consumer_b)

   function new(string name = "consumer_b", uvm_component parent=null);
      super.new(name,parent);
      `uvm_info(get_type_name(),"This is new constructor of consumer_b class",UVM_NONE);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      recieve=new("recieve",this);
   endfunction:build_phase

   task put(transaction tr);
      tr.print();
   endtask

   //function void connect_phase(uvm_phase phase);
   //   super.connect_phase(phase);
   //endfunction:connect_phase

   //task run_phase(uvm_phase phase);
   
   //endtask:run_phase
endclass:consumer_b
