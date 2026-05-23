class apb_seq2 extends uvm_sequence #(apb_seq_item);
   apb_seq_item apb_item_h;
   `uvm_object_utils(apb_seq2)

   function new(string name = "apb_seq2");
      super.new(name);
   endfunction:new

   task body();
     // repeat(5) begin
         `uvm_do_with(apb_item_h, {write ==1'b1; data !=32'h0;})
         `uvm_info(get_type_name(),$sformatf("Displaying from apb_seq2=%0s",apb_item_h.sprint()),UVM_NONE);
    //  end
   endtask
endclass:apb_seq2
