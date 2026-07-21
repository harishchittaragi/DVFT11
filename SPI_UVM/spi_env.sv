`ifndef SPI_ENV_
`define SPI_ENV_
class spi_env extends uvm_env;
    `uvm_component_utils(spi_env)
    spi_agent agent_h;
    spi_scoreboard sb_h;
    spi_coverage cov_h;

    //  CONSTRUCTOR
    function new(string name = "spi_env",uvm_component parent=null);
        super.new(name,parent);
    endfunction:new

    //  BUILD_PHASE
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent_h = spi_agent :: type_id ::create("agent_h",this);
        sb_h = spi_scoreboard :: type_id ::create("sb_h",this);
        cov_h = spi_coverage :: type_id ::create("cov_h",this);
    endfunction:build_phase

    //  CONNECT_PHASE
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agent_h.mon_h.anal_port.connect(sb_h.anal_imp);
        agent_h.mon_h.anal_port.connect(cov_h.analysis_export);
    endfunction:connect_phase
endclass:spi_env
`endif
