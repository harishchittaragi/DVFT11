class apb_seq1 extends uvm_sequence # (apb_seq_item);
    apb_seq_item apb_item_h;
   `uvm_object_utils(apb_seq1)

   function new (string name = "apb_seq1");
      super.new(name);
   endfunction:new

   task body();
     // repeat (5) begin
         apb_item_h = apb_seq_item::type_id::create("apb_item_h");
         start_item(apb_item_h);
         apb_item_h.randomize();
         `uvm_info(get_type_name(),$sformatf("Displaying from apb_seq1=%0s",apb_item_h.sprint()),UVM_NONE);
         finish_item(apb_item_h);
    //  end
   endtask:body
endclass:apb_seq1

