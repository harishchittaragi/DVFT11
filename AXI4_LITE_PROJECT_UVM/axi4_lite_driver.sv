//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: UVM Driver for AXI4-Lite protocol
//             that drives read and write transactions
//             to the DUT by handling AW, W, B, AR,
//             and R channel handshakes. It manages
//             reset conditions, supports parallel
//             write operations, sequential read flow,
//             and returns responses back to sequencer.
//Date: 25/05/2026 to  29/05/2026.
//*************************************************//

`ifndef AXI4_LITE_DRIVER_
`define AXI4_LITE_DRIVER_
class axi4_lite_driver extends uvm_driver #(axi4_lite_seq_item);
   // Handle declaration for seq_item
   axi4_lite_seq_item item_h;
   
   // Handle declaration for seq_item which will store lost packate while reset
   axi4_lite_seq_item re_drv;

   // handle declaration for Virtual Interface
   virtual axi4_lite_interface vif;

   // factory registration
   `uvm_component_utils(axi4_lite_driver)

   function new(string name = "axi4_lite_driver",uvm_component parent = null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db #(virtual axi4_lite_interface)::get(this,"","vif",vif))
         `uvm_fatal("NO_VIF","Virtual interface not found in config_db of [DRV]");
   endfunction:build_phase

   task reset_logic();
      // write address channel
      vif.drv_cb.awaddr  <= 0;
      vif.drv_cb.awvalid <= 0;
      // write data channel
      vif.drv_cb.wdata   <= 0;
      vif.drv_cb.wstrb   <= 0;
      vif.drv_cb.wvalid  <= 0;
      // write response channel
      vif.drv_cb.bready  <= 0;
      // read address channel
      vif.drv_cb.araddr   <= 0;
      vif.drv_cb.arvalid  <= 0;
      // read data channel
      vif.drv_cb.rready  <= 0;
      wait(vif.ARESETn==1);
      @(vif.drv_cb);
   endtask:reset_logic

   //--write address channel--// 
   task wr_addr_channel(axi4_lite_seq_item item_h);
      `uvm_info("[DRV]","Entered wr_addr_channel",UVM_NONE);
      @(vif.drv_cb);
         if(!vif.ARESETn || $isunknown (vif.ARESETn)) begin
            reset_logic();
            item_h.rst_f = 1;
            `uvm_info("[DRV]","Reset detected before awvalid <=0",UVM_NONE);
         end
      // awvalid asserting before handshaking:
      vif.drv_cb.awvalid <= 1;
      vif.drv_cb.awaddr <= item_h.awaddr;

      // waiting for awready asserting from DUT:
      do begin
      if(!vif.drv_cb.awready);
      @(vif.drv_cb);
      end
      while(vif.drv_cb.awready);

      // awvalid deasserting after handshake:
      @(vif.drv_cb);
         if(!vif.ARESETn || $isunknown (vif.ARESETn)) begin
            reset_logic();
            item_h.rst_f = 1;
            `uvm_info("[DRV]","Reset detected before awvalid <=0",UVM_NONE);
         end
      vif.drv_cb.awvalid <= 0;
      `uvm_info("DRV",$sformatf("This is driver_wr_addr_channel = %0s",item_h.sprint()),UVM_HIGH);
      `uvm_info("DRV",$sformatf("DRV AW_CHANNEL : awaddr=0x%0h",item_h.awaddr),UVM_NONE);
      `uvm_info("[DRV]","Exiting wr_addr_channel",UVM_NONE);
   endtask:wr_addr_channel

   //--write data channel----//
   task wr_data_channel(axi4_lite_seq_item item_h);
      `uvm_info("[DRV]","Entered wr_data_channel",UVM_NONE);
      
      // wvalid asserting before handshaking:
      vif.drv_cb.wdata <= item_h.wdata;
      vif.drv_cb.wstrb <= item_h.wstrb;
      vif.drv_cb.wvalid <= 1;
      
      // waiting for wready asserting signal from DUT:
      do begin
      if(!vif.drv_cb.wready);
      @(vif.drv_cb);
      end
      while(vif.drv_cb.wready);

      // wvalid deasserting after handshaking
      @(vif.drv_cb);
         if(!vif.ARESETn || $isunknown (vif.ARESETn)) begin
            reset_logic();
            item_h.rst_f = 1;
            `uvm_info("[DRV]","Reset detected before wvalid <=0",UVM_NONE);
         end
      vif.drv_cb.wvalid <=0;
      `uvm_info("DRV",$sformatf("This is driver_wr_data_channel = %0s",item_h.sprint()),UVM_HIGH);
      `uvm_info("DRV",$sformatf("DRV DW_CHANNEL : wdata = 0X%0h",item_h.wdata),UVM_NONE);
      `uvm_info("[DRV]","Exiting wr_data_channel",UVM_NONE);
   endtask:wr_data_channel

    //---write response channel---//
    task wr_resp_channel(axi4_lite_seq_item item_h);
      `uvm_info("[DRV]","Entered wr_resp_channel",UVM_NONE);
      
      // bready asserting before handshaking:
      @(vif.drv_cb);
         if(!vif.ARESETn || $isunknown (vif.ARESETn)) begin
            reset_logic();
            item_h.rst_f = 1;
            `uvm_info("[DRV]","Reset detected before seq_item_port",UVM_NONE);
         end
      vif.drv_cb.bready <= 1;
      
      // waiting for bvalid asserting from DUT
      do begin
      if(!vif.drv_cb.bvalid);
      @(vif.drv_cb);
      end
      while(vif.drv_cb.bvalid);

      // bvalid deasserting after handshaking:
      @(vif.drv_cb);
         if(!vif.ARESETn || $isunknown (vif.ARESETn)) begin
            reset_logic();
            item_h.rst_f = 1;
            `uvm_info("[DRV]","Reset detected before bready <=0",UVM_NONE);
         end
      vif.drv_cb.bready <= 0;
      `uvm_info("DRV",$sformatf("This is driver_wr_resp_channel = %0s",item_h.sprint()),UVM_HIGH);
      `uvm_info("[DRV]","Exiting wr_resp_channel",UVM_NONE);
   endtask:wr_resp_channel

      //---read address channel----//
    task rd_addr_channel(axi4_lite_seq_item item_h);
      `uvm_info("[DRV]","Entered rd_addr_channel",UVM_NONE);

      // arvalid asserting before handshaking:
       @(vif.drv_cb);
         if(!vif.ARESETn || $isunknown (vif.ARESETn)) begin
            reset_logic();
            item_h.rst_f = 1;
            `uvm_info("[DRV]","Reset detected before bready <=0",UVM_NONE);
         end
       vif.drv_cb.araddr <= item_h.araddr;
       vif.drv_cb.arvalid <= 1;

      // waiting for arready asserting from DUT:
      do begin
      if(!vif.drv_cb.arready);
      @(vif.drv_cb);
      end
      while(vif.drv_cb.arready);

      // Deasserting arvalid after handshake:
       @(vif.drv_cb);
         if(!vif.ARESETn || $isunknown (vif.ARESETn)) begin
            reset_logic();
            item_h.rst_f = 1;
            `uvm_info("[DRV]","Reset detected before bready <=0",UVM_NONE);
         end
       vif.drv_cb.arvalid <= 0;
      `uvm_info("DRV",$sformatf("This is driver_rd_addr_channel = %0s",item_h.sprint()),UVM_HIGH);
      `uvm_info("DRV",$sformatf("DRV araddr_channel: araddr=0x%0h",item_h.araddr),UVM_NONE);
      `uvm_info("[DRV]","Existing rd_addr_channel",UVM_NONE);
    endtask:rd_addr_channel

      //---read data channel-------//
    task rd_data_channel(axi4_lite_seq_item item_h);
      `uvm_info("[DRV]","Entered rd_data_channel",UVM_NONE);

      // asserting rready before handshaking:
       @(vif.drv_cb);
         if(!vif.ARESETn || $isunknown (vif.ARESETn)) begin
            reset_logic();
            item_h.rst_f = 1;
            `uvm_info("[DRV]","Reset detected before bready <=0",UVM_NONE);
         end
       vif.drv_cb.rready <= 1;
       
      // waiting for rvalid signal asserting from DUT: 
      do begin
      if(!vif.drv_cb.rvalid);
      @(vif.drv_cb);
      end
      while(vif.drv_cb.rvalid);
      @(vif.drv_cb);
         if(!vif.ARESETn || $isunknown (vif.ARESETn)) begin
            reset_logic();
            item_h.rst_f = 1;
            `uvm_info("[DRV]","Reset detected before bready <=0",UVM_NONE);
         end
      vif.drv_cb.rready <= 0;
      `uvm_info("DRV",$sformatf("This is driver_rd_data_channel = %0s",item_h.sprint()),UVM_HIGH);
      `uvm_info("[DRV]","Existing rd_data_channel",UVM_NONE);
   endtask:rd_data_channel
       
   // TASK RUN-PHASE
   task run_phase(uvm_phase phase);
      forever begin
         @(vif.drv_cb);
         if(!vif.ARESETn || $isunknown (vif.ARESETn)) begin
            reset_logic();
            `uvm_info("[DRV]","Reset detected before seq_item_port",UVM_NONE);
         end
         else begin
            seq_item_port.get_next_item(item_h);
            if(item_h.is_write) begin
               // AW & W channel must run Parallely:
               fork
                  wr_addr_channel(item_h);
                  wr_data_channel(item_h);
               join
               // B channel should run after AW & W channel:
               wr_resp_channel(item_h);
           end
           else begin
              // AR and R channel should run sequentially:
              rd_addr_channel(item_h);
              rd_data_channel(item_h);
           end
           seq_item_port.item_done();
           `uvm_info("[DRV]","After item_done()",UVM_NONE);
           if(item_h.rst_f) begin
              $cast(re_drv,item_h.clone());
              re_drv.set_id_info(item_h);
              seq_item_port.put_response(re_drv);
           end
           else
              seq_item_port.put_response(item_h);
        end
     end
   endtask:run_phase
endclass:axi4_lite_driver
`endif
