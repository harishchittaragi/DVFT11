class apb_driver extends uvm_driver #(apb_seq_item);
    apb_seq_item apb_item_h;
   `uvm_component_utils(apb_driver)

   function new (string name = "apb_driver", uvm_component parent=null );
      super.new(name,parent);
   endfunction:new

   task run_phase(uvm_phase phase);
      forever begin
         seq_item_port.get_next_item(apb_item_h);
         `uvm_info(get_type_name(),$sformatf("Displaying from apb_driver=%0s",apb_item_h.sprint()),UVM_NONE);
        seq_item_port.item_done();
     end
  endtask:run_phase
endclass:apb_driver
