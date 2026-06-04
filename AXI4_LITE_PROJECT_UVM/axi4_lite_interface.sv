//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: AXI4-Lite Interface that defines all
//             read and write channel signals along
//             with clocking blocks for driver and
//             monitor synchronization. It includes
//             modports for structured access and
//             embedded assertions to verify protocol
//             correctness, signal stability, reset
//             behavior, and handshake compliance.
//Date: 25/05/2026 to  29/05/2026.
//*************************************************//

`ifndef AXI4_LITE_INTERFACE_
`define AXI4_LITE_INTERFACE_
interface axi4_lite_interface #(parameter ADDR_WIDTH =32, DATA_WIDTH=32)(input logic ACLK,input logic ARESETn);
//-------WRITE ADDRESS CHANNEL--------//
    logic [ADDR_WIDTH-1:0]   awaddr;
    logic                    awvalid;
    logic                    awready;
    
//-------WRITE DATA CHANNEL-----------//
    logic [DATA_WIDTH-1:0]   wdata;
    logic [DATA_WIDTH/8-1:0] wstrb;
    logic                    wvalid;
    logic                    wready;

//-------WRITE RESPONSE CHANNEL-------//
    logic [1:0]              bresp;
    logic                    bvalid;
    logic                    bready;

//-------READ ADDRESS CHANNEL---------//
    logic [ADDR_WIDTH-1:0]   araddr;
    logic                    arvalid;
    logic                    arready;

//-------READ DATA CHANNEL------------//
    logic [DATA_WIDTH-1:0]   rdata;
    logic [1:0]              rresp;
    logic                    rvalid;
    logic                    rready;

//-----CLOCKING BLOCK-----------------//
//-----DRIVER------//
clocking drv_cb @(posedge ACLK);
   //default input #1step output #1;
   input  awready;
   output awaddr, awvalid;

   input  wready;
   output wdata, wvalid, wstrb;

   input  bresp, bvalid;
   output bready;

   input  arready;
   output araddr, arvalid;

   input  rdata, rresp, rvalid;
   output rready;
endclocking:drv_cb

//-----MONITOR-----//
clocking mon_cb @(negedge ACLK);
   //default input #1step output #1;
   input  awaddr,  awvalid, awready;
   input  wdata,   wvalid,  wready,  wstrb;
   input  bresp,   bvalid,  bready;
   input  araddr,  arvalid, arready;
   input  rdata,   rvalid,  rready,  rresp;
endclocking:mon_cb

//-------MODPORTS------------//
modport DRV (clocking drv_cb , input ACLK,ARESETn);
modport MON (clocking mon_cb , input ACLK,ARESETn);

//--------------------ASSERTIONS------------//
//--------------------------------//
// checking with reset conditions //
//--------------------------------//

//rst_awvalid
property awvalid_reset_p;
   @(posedge ACLK)
   (!ARESETn) |-> (awvalid==1'b0);
endproperty:awvalid_reset_p
rst_awvalid : assert property(awvalid_reset_p);

//rst_wvalid
property wvalid_reset_p;
   @(posedge ACLK)
   (!ARESETn) |-> (wvalid==1'b0);
endproperty:wvalid_reset_p
rst_wvalid : assert property(wvalid_reset_p);

//rst_bready
property bready_reset_p;
   @(posedge ACLK)
   (!ARESETn) |-> (bready==1'b0);
endproperty:bready_reset_p
rst_bready : assert property(bready_reset_p);

//rst_arvalid
property arvalid_reset_p;
   @(posedge ACLK)
   (!ARESETn) |-> (arvalid==1'b0);
endproperty:arvalid_reset_p
rst_arvalid : assert property(arvalid_reset_p);

//rst_rready
property rready_reset_p;
   @(posedge ACLK)
   (!ARESETn) |-> (rready==1'b0);
endproperty:rready_reset_p
rst_rready : assert property(rready_reset_p);

//-----------------------//
// WRITE ADDRESS CHANNEL //
//-----------------------//

//awvalid must not be unknown value:
 property awvalid_known;
    @(posedge ACLK) disable iff (!ARESETn)
    !$isunknown(awvalid);
 endproperty: awvalid_known
 AW_awvalid_known: assert property (awvalid_known);

//awvalid must high till awready becomes high:
 property awvalid_high;
    @(posedge ACLK) disable iff (!ARESETn)
    (awvalid && !awready) |=> (awvalid);
 endproperty: awvalid_high
 AW_awvalid_high: assert property (awvalid_high);

//awaddr must stable when awvalid is high:
 property awaddr_stable;
    @(posedge ACLK) disable iff (!ARESETn)
    (awvalid && !awready) |=> $stable(awaddr);
 endproperty: awaddr_stable
 AW_awaddr_stable: assert property (awaddr_stable);

//awaddr must aligned with 4bit:
 property awaddr_align;
    @(posedge ACLK) disable iff (!ARESETn)
    (awvalid && awaddr != 32'h0000_00001) |-> (awaddr[1:0]==2'b00);
 endproperty: awaddr_align
 AW_awaddr_align: assert property (awaddr_align);

//awvalid becomes low after handshaking:
 property awvalid_low;
    @(posedge ACLK) disable iff (!ARESETn)
    (awvalid && awready) |=> (!awvalid);
 endproperty: awvalid_low
 AW_awvalid_low: assert property (awvalid_low);

//--------------------//
// WRITE DATA CHANNEL //
//--------------------//

//wvalid must not be unknown value:
 property wvalid_known;
    @(posedge ACLK) disable iff (!ARESETn)
    !$isunknown(wvalid);
 endproperty: wvalid_known
 W_wvalid_known: assert property (wvalid_known);

//wvalid must high till wready becomes high:
 property wvalid_high;
    @(posedge ACLK) disable iff (!ARESETn)
    (wvalid && !wready) |=> (wvalid);
 endproperty: wvalid_high
 W_wvalid_high: assert property (wvalid_high);

//wdata must stable when wvalid is high:
 property wdata_stable;
    @(posedge ACLK) disable iff (!ARESETn)
    (wvalid && !wready) |=> $stable(wdata);
 endproperty: wdata_stable
 W_wdata_stable: assert property (wdata_stable);

//wstrb should not be unknown value:
 property wstrb_known;
    @(posedge ACLK) disable iff (!ARESETn)
    (wvalid) |-> (!$isunknown(wstrb));
 endproperty: wstrb_known
 W_wstrb_known: assert property (wstrb_known);

//wvalid becomes low after handshaking:
 property wvalid_low;
    @(posedge ACLK) disable iff (!ARESETn)
    (wvalid && wready) |=> (!wvalid);
 endproperty: wvalid_low
 W_wvalid_low: assert property (wvalid_low);

//------------------------//
// WRITE RESPONSE CHANNEL //
//------------------------//

// bvalid must not "X" or "Z":
 property bvalid_known;
    @(posedge ACLK) disable iff (!ARESETn)
    !$isunknown(bvalid);
 endproperty: bvalid_known
 B_bvalid_known: assert property (bvalid_known);

//bresp must not be "X" or "Z":
 property bresp_known;
    @(posedge ACLK) disable iff (!ARESETn)
    (wvalid) |-> (!$isunknown(bresp));
 endproperty: bresp_known
 B_bresp_known: assert property (bresp_known);

//bvalid must stay high till bready becomes high :
 property bvalid_high;
    @(posedge ACLK) disable iff (!ARESETn)
    (bvalid && !bready) |=> (bvalid);
 endproperty: bvalid_high
 B_bvalid_high: assert property (bvalid_high);

//bresp must stable when bvalid is high:
 property bresp_stable;
    @(posedge ACLK) disable iff (!ARESETn)
    (bvalid && !bready) |=> $stable(bresp);
 endproperty: bresp_stable
 B_bresp_stable: assert property (bresp_stable);

//bvalid becomes low after handshaking:
 property bvalid_low;
    @(posedge ACLK) disable iff (!ARESETn)
    (bvalid && bready) |=> (!bvalid);
 endproperty: bvalid_low
 B_bvalid_low: assert property (bvalid_low);

//bresp must be OKAY after every successful write:
 property bresp_check;
    @(posedge ACLK) disable iff (!ARESETn)
    (bvalid && bready) |-> ((awaddr[1:0]!=2'b00)?(bresp==2'b10):(bresp==2'b00));
 endproperty: bresp_check
 B_bresp_check: assert property (bresp_check);

//----------------------//
// READ ADDRESS CHANNEL //
//----------------------//

//arvalid must not be unknown value:
 property arvalid_known;
    @(posedge ACLK) disable iff (!ARESETn)
    !$isunknown(arvalid);
 endproperty: arvalid_known
 AR_arvalid_known: assert property (arvalid_known);

//arvalid must high till arready becomes high:
 property arvalid_high;
    @(posedge ACLK) disable iff (!ARESETn)
    (arvalid && !arready) |=> (arvalid);
 endproperty: arvalid_high
 AR_arvalid_high: assert property (arvalid_high);

//araddr must stable when arvalid is high:
 property araddr_stable;
    @(posedge ACLK) disable iff (!ARESETn)
    (arvalid && !arready) |=> $stable(araddr);
 endproperty: araddr_stable
 AR_araddr_stable: assert property (araddr_stable);

//araddr must aligned with 4bit:
 property araddr_align;
    @(posedge ACLK) disable iff (!ARESETn)
    (arvalid && araddr != 32'h0000_0001) |-> (araddr[1:0]==2'b00);
 endproperty: araddr_align
 AR_araddr_align: assert property (araddr_align);

//arvalid becomes low after handshaking:
 property arvalid_low;
    @(posedge ACLK) disable iff (!ARESETn)
    (arvalid && arready) |=> (!arvalid);
 endproperty: arvalid_low
 AR_arvalid_low: assert property (arvalid_low);

//-------------------//
// READ DATA CHANNEL //
//-------------------//

//rvalid must not be unknown value:
 property rvalid_known;
    @(posedge ACLK) disable iff (!ARESETn)
    !$isunknown(rvalid);
 endproperty: rvalid_known
 R_rvalid_known: assert property (rvalid_known);

//rvalid must high till rready becomes high:
 property rvalid_high;
    @(posedge ACLK) disable iff (!ARESETn)
    (rvalid && !rready) |=> (rvalid);
 endproperty: rvalid_high
 R_rvalid_high: assert property (rvalid_high);

//rdata must stable when rvalid is high:
 property rdata_stable;
    @(posedge ACLK) disable iff (!ARESETn)
    (rvalid && !rready) |=> $stable(rdata);
 endproperty: rdata_stable
 R_rdata_stable: assert property (rdata_stable);

//rvalid becomes low after handshaking:
 property rvalid_low;
    @(posedge ACLK) disable iff (!ARESETn)
    (rvalid && rready) |=> (!rvalid);
 endproperty: rvalid_low
 R_rvalid_low: assert property (rvalid_low);

//rresp must be OKAY after every successful write:
 property rresp_check;
    @(posedge ACLK) disable iff (!ARESETn)
    (rvalid && rready) |-> ((araddr[1:0]!=2'b00)?(rresp==2'b10):(rresp==2'b00));
 endproperty: rresp_check
 R_rresp_check: assert property (rresp_check);

endinterface:axi4_lite_interface
`endif
