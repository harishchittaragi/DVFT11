class axi_agent extends uvm_agent;
   axi_sequencer axi_seqr_h;
   axi_driver axi_drv_h;
   `uvm_component_utils(axi_agent)

   function new(string name= "axi_agent", uvm_component parent =null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      axi_seqr_h=axi_sequencer::type_id::create("axi_seqr_h",this);
      axi_drv_h=axi_driver::type_id::create("axi_drv_h",this);
   endfunction:build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      axi_drv_h.seq_item_port.connect(axi_seqr_h.seq_item_export);
   endfunction:connect_phase
endclass:axi_agent
