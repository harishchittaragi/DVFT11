`ifndef SPI_MONITOR_
`define SPI_MONITOR_
class spi_monitor extends uvm_monitor;
    `uvm_component_utils(spi_monitor)

    virtual spi_interface vif;
    uvm_analysis_port #(spi_seq_item) anal_port;

    bit [7:0] captured_tx_d;

    bit prev_sclk;
    bit prev_ss_n;
    bit cpol_sampled;
    bit cpha_sampled;
    int edge_count;
    int ticks_since_ssn_low;
    int ticks_since_last_edge;
    int ticks_at_edge1;
    int half_period_ticks;

    function new(string name = "spi_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual spi_interface)::get(this, "", "vif", vif))
            `uvm_fatal("NO_VIF", "virtual interface not found in config_db of [MON]");
        anal_port = new("anal_port", this);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        spi_seq_item item;

        wait(vif.rst_n == 1);
        prev_sclk = vif.mon_cb.sclk;
        prev_ss_n = vif.mon_cb.ss_n;

        forever begin
            @(vif.mon_cb);
            ticks_since_last_edge++;
            ticks_since_ssn_low++;

            // ---- Transaction start: ss_n falls ----
            if (prev_ss_n == 1 && vif.mon_cb.ss_n == 0) begin
                cpol_sampled          = prev_sclk;
                edge_count            = 0;
                ticks_since_last_edge = 0;
                ticks_since_ssn_low   = 0;
                half_period_ticks     = 0;
            end

            // ---- Catch DUT being loaded with new TX data ----
            if (vif.mon_cb.tx_en) begin
                captured_tx_d = vif.mon_cb.tx_d;
                `uvm_info("MON", $sformatf("Observed tx_d load = 0x%0h", captured_tx_d), UVM_NONE);
            end

            // ---- SCLK edge detection (only while CS is asserted) ----
            if (vif.mon_cb.ss_n == 0 && vif.mon_cb.sclk !== prev_sclk) begin
                edge_count++;

                if (edge_count == 1) begin
                    // Record timing offset from CS-low to the first edge --
                    // this is data-independent, unlike comparing mosi values.
                    ticks_at_edge1 = ticks_since_ssn_low;
                end
                else if (edge_count == 2) begin
                    half_period_ticks = ticks_since_last_edge;
                    // CPHA=1: first edge ~1 half-period after CS-low
                    // CPHA=0: first edge ~2 half-periods after CS-low
                    cpha_sampled = (ticks_at_edge1 <= (half_period_ticks + half_period_ticks/2))
                                   ? 1'b1 : 1'b0;
                end

                ticks_since_last_edge = 0;
            end

            // ---- Catch a completed RX byte ----
            if (vif.mon_cb.rxdv) begin
                item = spi_seq_item#()::type_id::create("item");
                item.tx_data   = captured_tx_d;
                item.rx_data   = vif.mon_cb.rx_d;
                item.cpol      = cpol_sampled;
                item.cpha      = cpha_sampled;
                item.clk_div   = half_period_ticks;
                item.num_bits  = 8;
                item.lsb_first = 0;

                `uvm_info("MON", $sformatf(
                    "MON Transaction: rx_data=0x%0h tx_data=0x%0h cpol=%0d cpha=%0d clk_div=%0d",
                    item.rx_data, item.tx_data, item.cpol, item.cpha, item.clk_div), UVM_NONE);

                anal_port.write(item);
            end
            prev_sclk = vif.mon_cb.sclk;
            prev_ss_n = vif.mon_cb.ss_n;
        end
    endtask: run_phase
endclass: spi_monitor
`endif
