class axi_driver extends uvm_driver # (axi_seq_item);
   axi_seq_item axi_item_h;
   `uvm_component_utils(axi_driver)

   function new(string name = "axi_driver",uvm_component parent = null);
      super.new(name,parent);
   endfunction:new

   task run_phase(uvm_phase phase);
      forever begin
      seq_item_port.get_next_item(axi_item_h);
      `uvm_info(get_type_name(),$sformatf("Displaying from axi_driver = %0s",axi_item_h.sprint()),UVM_NONE);
      seq_item_port.item_done();
   end
   endtask:run_phase
endclass:axi_driver

