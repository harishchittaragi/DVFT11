`ifndef SPI_SEQ1_
`define SPI_SEQ1_
class spi_seq1 extends uvm_sequence # (spi_seq_item);
    `uvm_object_utils(spi_seq1)

    spi_seq_item item_h;

    function new(string name = "spi_seq1");
        super.new(name);
    endfunction:new

    task body();
        repeat(5) begin
            item_h = spi_seq_item#() :: type_id :: create ("item_h");
            start_item(item_h);
            item_h.randomize();
            `uvm_info("SEQ1",$sformatf("This si Seq1--%0s",item_h.sprint()),UVM_NONE);
            finish_item(item_h);
        end
    endtask:body
endclass:spi_seq1
`endif
