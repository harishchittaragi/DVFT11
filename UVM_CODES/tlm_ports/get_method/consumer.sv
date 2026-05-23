class consumer extends uvm_component;
   transaction tr;
   uvm_blocking_get_port #(transaction) receive;
   `uvm_component_utils_begin(consumer)
   `uvm_component_utils_end

   function new(string name = "consumer",uvm_component parent=null);
      super.new(name,parent);
//      `uvm_info(get_type_name(),"this is consumer construction block",UVM_NONE);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
//      `uvm_info(get_type_name(),"This is build_phase of consumer",UVM_NONE);
      receive=new("receive",this);
   endfunction:build_phase

//Actual receive
//  task put(transaction tr);
//     `uvm_info(get_type_name(),"Printing from consumer",UVM_NONE);
//     tr.print();
//  endtask:put

//   function void connect_phase(uvm_phase phase);
//      super.connect_phase(phase);
//      `uvm_info(get_type_name(),"This is connect_phase of consumer",UVM_NONE);
//   endfunction:connect_phase
//
//   now here write run_phase
    task  run_phase(uvm_phase phase);
      `uvm_info(get_type_name(),"Before calling get method in consumer",UVM_NONE);
       receive.get(tr);
      `uvm_info(get_type_name(),"After calling get method in consumer",UVM_NONE);
       tr.print();
    endtask:run_phase

endclass:consumer
