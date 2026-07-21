`ifndef SPI_SCOREBOARD_
`define SPI_SCOREBOARD_
`uvm_analysis_imp_decl(_mon)

class spi_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(spi_scoreboard)

    // Analysis import — the monitor connects its analysis_port to this.
    uvm_analysis_imp_mon #(spi_seq_item, spi_scoreboard) anal_imp;

    // Simple pass/fail bookkeeping
    int unsigned num_matched;
    int unsigned num_mismatched;

    //  CONSTRUCTOR
    function new(string name = "spi_scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    //  BUILD_PHASE
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        anal_imp = new("anal_imp", this);
        num_matched    = 0;
        num_mismatched = 0;
    endfunction: build_phase

    //  WRITE — called automatically whenever the monitor publishes an item
    function void write_mon(spi_seq_item item);
        if (item.tx_data === item.rx_data) begin
            num_matched++;
            `uvm_info("SCB", $sformatf("MATCH: tx_data=0x%0h == rx_data=0x%0h",
                       item.tx_data, item.rx_data), UVM_NONE);
        end
        else begin
            num_mismatched++;
            `uvm_error("SCB", $sformatf("MISMATCH: expected tx_data=0x%0h, got rx_data=0x%0h",
                        item.tx_data, item.rx_data));
        end
    endfunction: write_mon

    //  REPORT_PHASE — summary printed at the end of simulation
    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("SCB", $sformatf("SCOREBOARD SUMMARY: Matched=%0d, Mismatched=%0d",
                   num_matched, num_mismatched), UVM_NONE);
    endfunction: report_phase

endclass: spi_scoreboard
`endif
