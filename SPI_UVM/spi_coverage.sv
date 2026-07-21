`ifndef SPI_COVERAGE_
`define SPI_COVERAGE_

class spi_coverage extends uvm_subscriber #(spi_seq_item);
    `uvm_component_utils(spi_coverage)

    // NOTE: uvm_subscriber already provides a built-in port called
    // 'analysis_export' — no need to declare our own imp/port here.
    // The monitor connects directly to: spi_coverage_h.analysis_export

    // Local copy of the item being sampled, so the covergroup can reach
    // its fields via the sample() call
    spi_seq_item item_h;

    //  COVERGROUP
    covergroup spi_cg;
        option.per_instance = 1;

        cp_cpha: coverpoint item_h.cpha {
            bins mode0 = {0};
            bins mode1 = {1};
        }

        cp_cpol: coverpoint item_h.cpol {
            bins cpol0 = {0};
            ignore_bins cpol1 = {1};
        }

        cp_lsb_first: coverpoint item_h.lsb_first {
            bins msb_first = {0};
            ignore_bins lsb_first = {1};
        }

        cp_tx_data: coverpoint item_h.tx_data {
            bins all_zero    = {8'h00};
            bins all_ones    = {8'hFF};
            bins alt_a5      = {8'hA5};
            bins alt_5a      = {8'h5A};
            bins others      = default;
        }

        cp_clk_div: coverpoint item_h.clk_div {
            bins low_div  = {[2:17]};
            bins mid_div  = {[18:34]};
            bins high_div = {[35:50]};
        }

        cp_match: coverpoint (item_h.tx_data === item_h.rx_data) {
            bins matched    = {1};
            ignore_bins mismatched = {0};
        }

        cx_mode_data: cross cp_cpha, cp_tx_data;

    endgroup: spi_cg

    //  CONSTRUCTOR
    function new(string name = "spi_coverage", uvm_component parent = null);
        super.new(name, parent);
        spi_cg = new();
    endfunction: new

    //  WRITE — called automatically whenever the monitor publishes an item
    //  This overrides the pure virtual method required by uvm_subscriber.
    function void write(spi_seq_item t);
        item_h = t;
        spi_cg.sample();
        `uvm_info("COV", $sformatf("Sampled coverage: cpha=%0d tx_data=0x%0h",
                   item_h.cpha, item_h.tx_data), UVM_HIGH);
    endfunction: write

    //  REPORT_PHASE
    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("COV", $sformatf("Overall functional coverage = %0.2f%%",
                   spi_cg.get_coverage()), UVM_NONE);
    endfunction: report_phase
endclass: spi_coverage
`endif
