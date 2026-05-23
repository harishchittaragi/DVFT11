class producer_a extends uvm_component;
   
   // transaction class calling here
   transaction tr;

   //port creation
   uvm_blocking_put_port # (transaction) s1;
   `uvm_component_utils(producer_a)

   function new(string name = "producer_a", uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      tr=transaction :: type_id ::create("tr");
      s1=new("s1",this);
   endfunction:build_phase

   //run_phase
   task run_phase(uvm_phase phase);
      super.run_phase(phase);
      //Randomization 
      //tr.randomize(addr,data);
      tr.addr=10;
      tr.data=20;
      s1.put(tr);
      `uvm_info(get_full_name(),"This is Producer_a prinitng",UVM_NONE);
      tr.print();
   endtask:run_phase
endclass:producer_a


