`ifndef SPI_SEQ_ITEM_
`define SPI_SEQ_ITEM_
class spi_seq_item #(parameter DATA_WIDTH = 8) extends uvm_sequence_item;
    rand bit [DATA_WIDTH-1:0] tx_data; // transmit data
         bit [DATA_WIDTH-1:0] rx_data; // recieve data
    rand bit ss_n; // Slave select signal
    rand bit cpol; // clock polarity signal
    rand bit cpha; // clock phase signal
    rand bit lsb_first;
    rand int unsigned clk_div;
    rand int unsigned num_bits;

    `uvm_object_param_utils_begin(spi_seq_item#(DATA_WIDTH))
      `uvm_field_int (tx_data,  UVM_ALL_ON)
      `uvm_field_int (rx_data,  UVM_ALL_ON)
      `uvm_field_int (ss_n,     UVM_ALL_ON)
      `uvm_field_int (cpol,     UVM_ALL_ON)
      `uvm_field_int (cpha,     UVM_ALL_ON)
      `uvm_field_int (lsb_first,UVM_ALL_ON)
      `uvm_field_int (clk_div,  UVM_ALL_ON)
      `uvm_field_int (num_bits, UVM_ALL_ON)
     `uvm_object_utils_end

    //Constructor
    function new (string name = "spi_seq_item");
        super.new(name);
    endfunction:new

    constraint c_ss_active {
        ss_n == 0;               // SPI transfer happens when SS is low
    }
    constraint c_clk_div {
        clk_div inside {[2:50]}; // reasonable divider range
    }
    constraint c_num_bits {
        num_bits == DATA_WIDTH;  // DUT is fixed at 8-bit transfers per CS_n window
    }
    constraint c_spi_mode {
        cpol == 0;
        soft cpha inside{0,1};
    }
    constraint c_bit_order {
        lsb_first == 0;
    }
endclass:spi_seq_item
`endif
