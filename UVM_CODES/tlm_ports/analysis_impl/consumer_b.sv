class consumer_b extends uvm_component;
    
   //creating implementation port here:
   uvm_analysis_imp # (transaction,consumer_b) r2;
   `uvm_component_utils(consumer_b)

   function new(string name = "consumer_b", uvm_component parent=null);
      super.new(name,parent);
//      `uvm_info(get_type_name(),"This is new constructor of consumer_b class",UVM_NONE);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      r2=new("r2",this);
   endfunction:build_phase

   function write(transaction tr);
     `uvm_info(get_type_name(),"This write function from consumer_b ",UVM_NONE);
      tr.print();
   endfunction:write

endclass:consumer_b
