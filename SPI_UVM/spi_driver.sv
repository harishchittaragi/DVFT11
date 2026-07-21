`ifndef SPI_DRIVER_
`define SPI_DRIVER_
class spi_driver extends uvm_driver #(spi_seq_item);
    `uvm_component_utils(spi_driver)
    spi_seq_item item_h;
    virtual spi_interface vif;

    // Local shadow of sclk's current driven value -- clocking block
    // outputs cannot be read back in an expression, so we track the
    // state ourselves instead of doing "vif.drv_cb.sclk <= ~vif.drv_cb.sclk".
    bit sclk_state;

    //  CONSTRUCTOR
    function new(string name = "spi_driver",uvm_component parent= null);
        super.new(name,parent);
    endfunction:new

    //  BUILD_PHASE
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual spi_interface)::get(this,"","vif",vif))
            `uvm_fatal("NO_VIF","virtual interface not found in config_db of [DRV]");
    endfunction:build_phase

    //  RESET_PHASE
    task reset_phase(uvm_phase phase);
        super.reset_phase(phase);
        vif.drv_cb.ss_n  <= 1;   // deselect slave
        vif.drv_cb.mosi  <= 0;   // no data
        vif.drv_cb.sclk  <= 0;
        vif.drv_cb.tx_en <= 0;   // DUT drives nothing on MISO by default
        vif.drv_cb.tx_d  <= 0;
        sclk_state = 0;
        wait(vif.rst_n==1);
        @(vif.drv_cb);
    endtask:reset_phase

    //  DRIVER_LOGIC
    task driver_logic(spi_seq_item item);
        int bit_idx;
        int half_period;
        half_period = item.clk_div;
        
        vif.drv_cb.tx_d <= item.tx_data;
        vif.drv_cb.tx_en <= 1;
        @(vif.drv_cb);
        vif.drv_cb.tx_en <= 0;
        
        sclk_state = item.cpol;
        vif.drv_cb.sclk <= sclk_state;
        @(vif.drv_cb);
        vif.drv_cb.ss_n <= 0;
        repeat(half_period) @(vif.drv_cb);

        for(int i = 0; i < item.num_bits; i++) begin
            bit_idx = item.lsb_first ? i : (item.num_bits-1-i);

            if(item.cpha == 0) begin
                vif.drv_cb.mosi <= item.tx_data[bit_idx];
                `uvm_info("DRV",$sformatf("DRV MOSI(bit_idx=%0d) = %0b", bit_idx, item.tx_data[bit_idx]),UVM_NONE);
                repeat(half_period) @(vif.drv_cb);

                sclk_state = ~sclk_state;
                vif.drv_cb.sclk <= sclk_state;
                repeat(half_period) @(vif.drv_cb);

                item.rx_data[bit_idx] <= vif.drv_cb.miso;

                sclk_state = ~sclk_state;
                vif.drv_cb.sclk <= sclk_state;
            end
            else begin
                sclk_state = ~sclk_state;
                vif.drv_cb.sclk <= sclk_state;

                vif.drv_cb.mosi <= item.tx_data[bit_idx];
                repeat(half_period) @(vif.drv_cb);

                sclk_state = ~sclk_state;
                vif.drv_cb.sclk <= sclk_state;
                repeat(half_period) @(vif.drv_cb);

                item.rx_data[bit_idx] <= vif.drv_cb.miso;
            end
        end
        @(vif.drv_cb);
        `uvm_info("DRV", $sformatf("Captured rx_data = 0x%0h (expected tx_d loopback = 0x%0h)", item.rx_data, item.tx_data), UVM_NONE);
        vif.drv_cb.ss_n  <= 1;
        sclk_state = item.cpol;
        vif.drv_cb.sclk  <= sclk_state;
        vif.drv_cb.mosi  <= 0;
        repeat(half_period) @(vif.drv_cb);
    endtask:driver_logic

    //  RUN_PHASE
    task run_phase(uvm_phase phase);
        wait(vif.rst_n==1);
        @(vif.drv_cb);
        forever begin
            seq_item_port.get_next_item(item_h);
            driver_logic(item_h);
            seq_item_port.item_done();
        end
    endtask:run_phase
endclass : spi_driver
`endif
