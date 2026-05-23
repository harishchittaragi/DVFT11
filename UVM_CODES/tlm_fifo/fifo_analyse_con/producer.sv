class producer extends uvm_component;
   
   // transaction class calling here
   transaction tr;

   //port creation
   uvm_analysis_port # (transaction) send;
   `uvm_component_utils(producer)

   function new(string name = "producer", uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      send=new("send",this);
   endfunction:build_phase

   //run_phase
   task run_phase(uvm_phase phase);
      super.run_phase(phase);
//      repeat(2) begin
      tr=transaction :: type_id ::create("tr");
      //tr.randomize(addr,data);
      tr.addr=100;
      tr.data=256;
//      `uvm_info(get_type_name(),$sformatf("displaying the values from producer %s",tr.sprint()),UVM_NONE);
      tr.print();
      send.write(tr);
//      end
     // tr.print();
   endtask:run_phase
endclass:producer

