`ifndef SPI_TOP_
`define SPI_TOP_
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "spi_interface.sv"
`include "spi_seq_item.sv"
`include "spi_seq1.sv"
`include "spi_seq2.sv"
`include "spi_sequencer.sv"
`include "spi_driver.sv"
`include "spi_monitor.sv"
`include "spi_scoreboard.sv"
`include "spi_coverage.sv"
`include "spi_agent.sv"
`include "spi_env.sv"
`include "spi_test.sv"
`include "spi_slave.sv"

module spi_top();
    reg rst_n, clk;
    spi_interface intf_h(clk, rst_n);
    SPI_Slave #(
        .SPI_MODE (0)
    ) dut (
        .i_Rst_L     (rst_n),
        .i_Clk       (clk),

        .o_RX_DV     (intf_h.rxdv),
        .o_RX_Byte   (intf_h.rx_d),

        .i_TX_DV     (intf_h.tx_en),
        .i_TX_Byte   (intf_h.tx_d),

        .i_SPI_Clk   (intf_h.sclk),
        .o_SPI_MISO  (intf_h.miso),
        .i_SPI_MOSI  (intf_h.mosi),
        .i_SPI_CS_n  (intf_h.ss_n)
    );
    // Clock generation
    always #5 clk = ~clk;

    initial begin
        clk   = 0;
        rst_n = 0;
        #7 rst_n = 1;
    end
    // UVM setup and test invocation
    initial begin
        uvm_config_db#(virtual spi_interface)::set(null, "*", "vif", intf_h);
        run_test("spi_test");
    end
endmodule : spi_top
`endif
