class producer extends uvm_component;
   stimulus st;
   connection conv;
   //port creation
   uvm_tlm_fifo #(transaction) p_fifo;
   uvm_blocking_put_port # (transaction) p_port;
   `uvm_component_utils(producer)

   function new(string name = "producer", uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      st=stimulus::type_id::create("st",this);
      conv=connection::type_id::create("conv",this);
      p_port=new("p_port",this);
      p_fifo=new("p_fifo",this);
   endfunction:build_phase
   
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      st.s_port.connect(p_fifo.put_export);
      conv.in_port.connect(p_fifo.get_export);
      conv.out_port.connect(this.p_port);

   endfunction:connect_phase
endclass:producer


