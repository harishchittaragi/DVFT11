class producer extends uvm_component;
   
   // transaction class calling here
   transaction tr,tr1,tr2;

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
      tr.r=3.14;
      tr.s="Harish";
      tr.randomize();
//      `uvm_info(get_type_name(),$sformatf("displaying the values from producer %s",tr.sprint()),UVM_NONE);
      tr.print();
      send.put(tr);
// COPY METHOD
   tr1=transaction :: type_id ::create("tr1");
   tr1.copy(tr);
      `uvm_info(get_type_name(),"This Producer side copy block",UVM_NONE);
      `uvm_info(get_type_name(),$psprintf("Real = {%0f} String = {%0s}",tr1.r,tr1.s),UVM_NONE);

    tr1.print();

//  CLONE METHOD
    $cast(tr2,tr1.clone());
      `uvm_info(get_type_name(),"This Producer side clone block",UVM_NONE);
    tr2.print();
   endtask:run_phase
endclass:producer

