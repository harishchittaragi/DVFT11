class producer extends uvm_component;
   transaction tr; //handle assignment for transaction

   uvm_blocking_get_imp # (transaction,producer) send;
           // port declaration of transaction type send is own declaration(we can gave any name).
   `uvm_component_utils_begin(producer)
    `uvm_field_object(tr,UVM_ALL_ON)
   `uvm_component_utils_end

   function new(string name = "producer",uvm_component parent=null);
      super.new(name,parent);
//      `uvm_info(get_type_name(),"this is producer construction block",UVM_NONE);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
//      `uvm_info(get_type_name(),"This is build_phase of producer",UVM_NONE);
       send=new("send",this); // memory creation for ports needs two args fix.
   endfunction:build_phase

//   function void connect_phase(uvm_phase phase);
//      super.connect_phase(phase);
//      `uvm_info(get_type_name(),"This is connect_phase of producer",UVM_NONE);
//   endfunction:connect_phase

//   task run_phase(uvm_phase phase);
//      super.run_phase(phase);
//      tr.randomize();
//      send.put(tr);
//      `uvm_info(get_type_name(),$sformatf("ADDR = %0h | DATA = %0h",tr.addr,tr.data),UVM_NONE);
     // tr.print();
//   endtask:run_phase
//   
//   instead of run_phase write here task get method
     task get (output transaction tr);
      `uvm_info(get_type_name(),"Before randomization it enters from get calling in consumer",UVM_NONE);
       tr=new("tr"); // memory creation for objects using new method need only one arg fix.
       #50;
       tr.randomize();
       tr.print();
       #10;
      `uvm_info(get_type_name(),"after randomization it exits from get methos in producer",UVM_NONE);
     endtask:get

endclass:producer

