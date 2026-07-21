`ifndef SPI_SEQ2_
`define SPI_SEQ2_
class spi_seq2 extends uvm_sequence # (spi_seq_item);
    `uvm_object_utils(spi_seq2)

    spi_seq_item item_h;

    function new(string name = "spi_seq2");
        super.new(name);
    endfunction:new

task body();
    bit [7:0] corner_vals[4] = '{8'h00, 8'hFF, 8'hA5, 8'h5A};
    bit       cpha_vals[2]   = '{0, 1};
    foreach (corner_vals[i]) begin
        foreach (cpha_vals[j]) begin
            item_h = spi_seq_item#()::type_id::create("item_h");
            start_item(item_h);
            item_h.randomize() with {
                tx_data == corner_vals[i];
                cpha    == cpha_vals[j];
            };
            `uvm_info("SEQ2", $sformatf("This si Seq2--%0s", item_h.sprint()), UVM_NONE);
            finish_item(item_h);
        end
    end
endtask: body
endclass:spi_seq2
`endif

