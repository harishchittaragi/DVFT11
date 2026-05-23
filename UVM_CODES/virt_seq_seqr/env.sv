class env extends uvm_env;
   apb_agent apb_agent_h;
   axi_agent axi_agent_h;
   virtual_sequencer v_seqr_h;
   `uvm_component_utils(env);

   function new(string name = "env",uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      apb_agent_h = apb_agent::type_id::create("apb_agent_h",this);
      axi_agent_h = axi_agent::type_id::create("axi_agent_h",this);
      v_seqr_h = virtual_sequencer::type_id::create("v_seqr_h",this);
   endfunction:build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      v_seqr_h.apb_seqr_h=apb_agent_h.apb_seqr_h;
      v_seqr_h.axi_seqr_h=axi_agent_h.axi_seqr_h;
   endfunction:connect_phase
endclass:env

