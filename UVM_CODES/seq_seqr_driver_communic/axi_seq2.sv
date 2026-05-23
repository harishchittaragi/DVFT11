class axi_seq2 extends uvm_sequence # (axi_seq_item);
   axi_seq_item axi_item_h;
   `uvm_object_utils(axi_seq2)

   function new (string name= "axi_seq2");
      super.new(name);
   endfunction:new

   task body();
      axi_item_h=axi_seq_item::type_id::create("axi_item_h");
      start_item(axi_item_h);
      axi_item_h.ad=32'h10;
      axi_item_h.da=32'h100;
      axi_item_h.wr=0;
      `uvm_info(get_type_name(),$sformatf("Displaying from axi_seq2 = %0s",axi_item_h.sprint()),UVM_NONE);
      finish_item(axi_item_h);
   endtask:body
endclass:axi_seq2


