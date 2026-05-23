class consumer_a extends uvm_component;
  
   //calling consumer_b class:
   consumer_b cb_h;

  //creating imp
   uvm_analysis_imp #(transaction,consumer_a) r1;

  // factory registration
   `uvm_component_utils(consumer_a)

   function new(string name = "consumer_a", uvm_component parent=null);
      super.new(name,parent);
//      `uvm_info(get_type_name(),"This is new constructor of consumer_a class",UVM_NONE);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      cb_h=consumer_b ::type_id :: create("cb_h",this);//memory creation for consumer_b class.
      r1=new("r1",this); //memory creation for imp.
   endfunction:build_phase

//   here we have to include write function:
    function write(transaction tr);
       `uvm_info(get_type_name(),"This write function from consumer_a ",UVM_NONE);
       tr.print();
    endfunction

endclass:consumer_a

