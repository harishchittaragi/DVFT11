class env extends uvm_env;
   apb_agent apb_agent_h;
   axi_agent axi_agent_h;
   `uvm_component_utils(env);

   function new(string name = "env",uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      apb_agent_h = apb_agent::type_id::create("apb_agent_h",this);
      axi_agent_h = axi_agent::type_id::create("axi_agent_h",this);
   endfunction:build_phase
endclass:env

