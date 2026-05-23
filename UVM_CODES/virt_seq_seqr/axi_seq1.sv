class axi_seq1 extends uvm_sequence#(axi_seq_item);
   axi_seq_item axi_item_h;
   `uvm_object_utils(axi_seq1)

   function new(string name = "axi_seq1");
      super.new(name);
   endfunction:new

   task body();
      axi_item_h = axi_seq_item::type_id::create("axi_item_h");
      start_item(axi_item_h);
      axi_item_h.randomize();
      `uvm_info(get_type_name(),$sformatf("Displaying from axi_seq1 = %0s",axi_item_h.sprint()),UVM_NONE);
      finish_item(axi_item_h);
   endtask:body
endclass:axi_seq1

