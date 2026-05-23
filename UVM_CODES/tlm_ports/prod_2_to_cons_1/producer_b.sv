class producer_b extends uvm_component;
   
   // transaction class calling here
   transaction tr;

   //port creation
   uvm_blocking_put_port # (transaction) s2;
   `uvm_component_utils(producer_b)

   function new(string name = "producer_b", uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      tr=transaction :: type_id ::create("tr");
      s2=new("s2",this);
   endfunction:build_phase

   //run_phase
   task run_phase(uvm_phase phase);
      super.run_phase(phase);
      //tr.randomize(addr,data);
      tr.addr=100;
      tr.data=200;
      s2.put(tr);
      `uvm_info(get_full_name(),"This is Producer_b prinitng",UVM_NONE);
      tr.print();
   endtask:run_phase
endclass:producer_b

