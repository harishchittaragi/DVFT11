class apb_agent extends uvm_agent;
   apb_driver apb_drv_h;
   apb_sequencer apb_seqr_h;
   `uvm_component_utils(apb_agent)

   function new (string name ="apb_agent", uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      apb_drv_h=apb_driver :: type_id :: create ("apb_drv_h",this);
      apb_seqr_h=apb_sequencer :: type_id :: create ("apb_seqr_h",this);
   endfunction:build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      apb_drv_h.seq_item_port.connect(apb_seqr_h.seq_item_export);
   endfunction:connect_phase
endclass:apb_agent

