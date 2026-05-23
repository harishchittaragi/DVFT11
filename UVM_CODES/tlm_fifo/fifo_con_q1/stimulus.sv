class stimulus extends uvm_component;
   transaction tr;
   //port creation
   uvm_blocking_put_port # (transaction) s_port;
   `uvm_component_utils(stimulus)

   function new(string name = "stimulus", uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      s_port=new("s_port",this);
   endfunction:build_phase
   
   //run_phase
   task run_phase(uvm_phase phase);
      //Randomization 
      tr=transaction::type_id::create("tr");
      tr.randomize();
      s_port.put(tr);
      `uvm_info(get_name(),"This is stimulus prinitng",UVM_NONE);
      tr.print();
   endtask:run_phase
endclass:stimulus

