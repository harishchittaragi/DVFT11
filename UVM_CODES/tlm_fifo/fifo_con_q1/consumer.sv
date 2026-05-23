
class consumer extends uvm_component;
   driver drv;
   uvm_tlm_fifo #(transaction) c_fifo;
   uvm_blocking_put_export # (transaction) c_exp;
   
   `uvm_component_utils(consumer)

   function new(string name = "consumer", uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      drv = driver :: type_id ::create("drv",this);
      c_exp=new("c_exp",this);
      c_fifo=new("c_fifo",this);
   endfunction:build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      c_exp.connect(c_fifo.put_export);
      drv.receive.connect(c_fifo.get_export);
   endfunction:connect_phase
endclass:consumer
