`ifndef SPI_AGENT_
`define SPI_AGENT_
class spi_agent extends uvm_agent;
    `uvm_component_utils(spi_agent)
    spi_sequencer seqr_h;
    spi_driver    drv_h;
    spi_monitor   mon_h;

    //CONSTRUCTOR
    function new(string name = "spi_agent", uvm_component parent= null);
        super.new(name,parent);
    endfunction:new

    //BUILD_PHASE
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        seqr_h = spi_sequencer :: type_id :: create("seqr_h",this);
        drv_h = spi_driver :: type_id :: create("drv_h",this);
        mon_h = spi_monitor :: type_id :: create("mon_h",this);
    endfunction:build_phase

    //CONNECT_PHASE
    function void connect_phase(uvm_phase phase);
        drv_h.seq_item_port.connect(seqr_h.seq_item_export);
    endfunction:connect_phase
endclass:spi_agent
`endif
