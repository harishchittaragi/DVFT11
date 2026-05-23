class producer extends uvm_component;
   
   // transaction class calling here
   transaction tr;

   //port creation
   uvm_blocking_put_port # (transaction) send;
   `uvm_component_utils(producer)

   function new(string name = "producer", uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      tr=transaction :: type_id ::create("tr");
      send=new("send",this);
   endfunction:build_phase

   //run_phase
   task run_phase(uvm_phase phase);
      super.run_phase(phase);
      tr.randomize(addr,data);
//      `uvm_info(get_type_name(),$sformatf("displaying the values from producer %s",tr.sprint()),UVM_NONE);
      tr.print();
      send.put(tr);
     // tr.print();
   endtask:run_phase
endclass:producer

