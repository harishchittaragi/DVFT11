`ifndef SPI_INTERFACE_
`define SPI_INTERFACE_
interface spi_interface # (parameter DATA_WIDTH = 8) (input logic clk, rst_n);

    // ---------------- Physical SPI signals ----------------
    logic   sclk;  // Serial clock signal
    logic   miso;  // Master In Slave Out
    logic   mosi;  // Master Out Slave In
    logic   ss_n;  // Slave Select Signal (active low)

    // ---------------- DUT-side data (slave's own interface, for
    //                  monitor observation) ----------------
    logic   [DATA_WIDTH-1:0] tx_d;   // data DUT drives out on MISO
    logic                     tx_en;  // enables DUT to drive MISO
    logic   [DATA_WIDTH-1:0] rx_d;   // data DUT captured from MOSI
    logic                     rxdv;   // pulses when rx_d is valid

    // ---------------- Clocking Blocks ----------------
    // Driver Clocking Block
    clocking drv_cb @(posedge clk);
        input  miso;//rx_data;
        output sclk, mosi, ss_n;// tx_data;
        output tx_d, tx_en;   // driver also controls what the DUT transmits back
    endclocking: drv_cb

    // Monitor Clocking Block
    clocking mon_cb @(negedge clk);
        input sclk, mosi, miso, ss_n;//tx_data, rx_data;
        input tx_d, tx_en, rx_d, rxdv;   // monitor observes DUT's captured data too
    endclocking: mon_cb

    // ---------------- MODPORTS ----------------
    modport DRIVER (
        clocking drv_cb,
        input clk,
        input rst_n
    );

    modport MONITOR (
        clocking mon_cb,
        input clk,
        input rst_n
    );

    // ------------------------------------------------------------
    // A1: MISO must be tri-stated whenever the slave is deselected
    // ------------------------------------------------------------
    property p_miso_tristate_when_deselected;
        @(posedge clk) disable iff (!rst_n)
        ss_n |-> (miso === 1'bz);
    endproperty
    a_miso_tristate: assert property (p_miso_tristate_when_deselected)
        else `uvm_error("ASSERT", $sformatf("MISO not tri-stated while ss_n=1, miso=%b", miso));

    // ------------------------------------------------------------
    // A2: sclk must not toggle while the slave is deselected
    // ------------------------------------------------------------
    property p_sclk_stable_when_deselected;
        @(posedge clk) disable iff (!rst_n)
        ss_n |-> $stable(sclk);
    endproperty
    a_sclk_stable: assert property (p_sclk_stable_when_deselected)
        else `uvm_error("ASSERT", "sclk toggled while ss_n=1 (slave deselected)");

    // ------------------------------------------------------------
    // A3: rxdv must be exactly one clk cycle wide (single pulse)
    // ------------------------------------------------------------
    property p_rxdv_single_cycle_pulse;
        @(posedge clk) disable iff (!rst_n)
        rxdv |=> !rxdv;
    endproperty
    a_rxdv_pulse: assert property (p_rxdv_single_cycle_pulse)
        else `uvm_error("ASSERT", "rxdv stayed high for more than one clk cycle");

    // ------------------------------------------------------------
    // A4: rxdv must never assert if ss_n has been high (idle)
    // ------------------------------------------------------------
    property p_rxdv_needs_prior_transaction;
        @(posedge clk) disable iff (!rst_n)
        rxdv |-> $past(ss_n, 1) == 1'b0 or $past(ss_n, 2) == 1'b0;
    endproperty
    a_rxdv_needs_txn: assert property (p_rxdv_needs_prior_transaction)
        else `uvm_error("ASSERT", "rxdv asserted with no recent ss_n low activity");

    // ------------------------------------------------------------
    // A5: tx_en should be a single-cycle pulse 
    // ------------------------------------------------------------
    property p_tx_en_single_cycle_pulse;
        @(posedge clk) disable iff (!rst_n)
        tx_en |=> !tx_en;
    endproperty
    a_tx_en_pulse: assert property (p_tx_en_single_cycle_pulse)
        else `uvm_error("ASSERT", "tx_en stayed high for more than one clk cycle");

    // ------------------------------------------------------------
    // A6: after reset deassertion, ss_n must be high (idle)
    // ------------------------------------------------------------
    property p_ss_n_idle_after_reset;
        @(posedge clk)
        $rose(rst_n) |-> ss_n;
    endproperty
    a_reset_idle: assert property (p_ss_n_idle_after_reset)
        else `uvm_error("ASSERT", "ss_n not high immediately after reset deassertion");

    // ------------------------------------------------------------
    // A7: mosi/miso must not be X/Z 
    // ------------------------------------------------------------
    property p_mosi_known_when_selected;
        @(posedge clk) disable iff (!rst_n)
        !ss_n |-> !$isunknown(mosi);
    endproperty
    a_mosi_known: assert property (p_mosi_known_when_selected)
        else `uvm_error("ASSERT", "mosi is X while ss_n=0 (transaction active)");
endinterface: spi_interface
`endif
