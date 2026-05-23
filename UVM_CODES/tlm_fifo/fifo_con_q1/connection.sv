class connection extends uvm_component;
   transaction tr;
   //port to receive from fifo:
   uvm_blocking_get_port # (transaction) in_port;
   // port to send to produver port
   uvm_blocking_put_port # (transaction) out_port;
   `uvm_component_utils(connection)

   function new(string name = "connection", uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      in_port=new("in_port",this);
      out_port=new("out_port",this);
   endfunction:build_phase

   task run_phase (uvm_phase phase);
    tr=transaction ::type_id::create("tr");
    in_port.get(tr);
    `uvm_info(get_name(),"Recieved transaction from fifo inside connection class",UVM_NONE);
    tr.print();
    out_port.put(tr);
 endtask
endclass:connection

