//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: This is Monitor_file. 
//Date: 04/03/2026 to  / /2026.
//*************************************************//

`ifndef _APB_ACTIVE_MONITOR
`define _APB_ACTIVE_MONITOR

class apb_active_monitor extends uvm_monitor;
   virtual apb_interface vif;
   apb_sequence_item seq_h;
   uvm_analysis_port#(apb_sequence_item) ap;
   `uvm_component_utils(apb_active_monitor)

   function new(string name = "apb_active_monitor",uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual apb_interface)::get(this,"","vif",vif))
         `uvm_fatal("No_VIF","Virtual interface not found in config_db of [APB_ACTIVE_MONITOR]");
      ap=new("ap",this);
   endfunction:build_phase

   task run_phase (uvm_phase phase);
    forever begin
      @(vif.monitor_cb);
      if(!vif.presetn || $isunknown(vif.presetn))
         continue;
      if(!vif.monitor_cb.psel || vif.monitor_cb.penable)
         continue;
       seq_h=apb_sequence_item::type_id::create("seq_h");
       seq_h.apb_state=IDLE;
       ap.write(seq_h);
       seq_h.psel  = vif.monitor_cb.psel;
       seq_h.penable  = vif.monitor_cb.penable;
       seq_h.pready  = vif.monitor_cb.pready;
       seq_h.paddr  = vif.monitor_cb.paddr;
       seq_h.pwrite = vif.monitor_cb.pwrite;
       seq_h.pwdata = vif.monitor_cb.pwdata;
       `uvm_info("[ACTIVE_MON]",$sformatf("setup detected:::::- %0s",seq_h.sprint()),UVM_NONE);
       seq_h.apb_state= SETUP;
       ap.write(seq_h);
       @(vif.monitor_cb);
       if(!vif.presetn || $isunknown(vif.presetn)) begin
          `uvm_info("[ACTIVE_MON]"," Reset during Access Phase --droping transaction",UVM_NONE);
          continue;
       end
       if(!vif.monitor_cb.penable) begin
          `uvm_error("[ACTIVE_MON]",$sformatf("%0t :penable is not asserted after SETUP",$time));
          continue;
       end
       seq_h.apb_state=ACCESS;
       ap.write(seq_h);
    while(!vif.monitor_cb.pready) begin
       @(vif.monitor_cb);
       if(!vif.presetn || $isunknown(vif.presetn)) begin
          `uvm_info("[ACTIVE_MON]","Reset while waiting for pready --droping transaction",UVM_NONE);
          break;
       end
    end
    seq_h.penable  = vif.monitor_cb.penable;
    seq_h.prdata =vif.monitor_cb.prdata;
    seq_h.pslverr =vif.monitor_cb.pslverr;
    ap.write(seq_h);
    `uvm_info("[ACTIVE_MON]"," Transaction sent to scoreboard",UVM_NONE);
 end      
endtask:run_phase
endclass:apb_active_monitor
`endif

//class apb_monitor;
//  mailbox mon_sb;
  
//  function new ( virtual apb_interface vif, mailbox mon_sb);
//    seq_h = new();
//    this.vif      = vif;
//    this.mon_sb   = mon_sb;
//   apb_proto_cg  = new();
//    apb_state_cg  = new();
//  endfunction :new

    
//  task run();
//    forever begin
//              apb_proto_cg.sample();
//      @(vif.monitor_cb);
//
//      if(!vif.presetn || $isunknown(vif.presetn))
//         continue;
//      if(!vif.monitor_cb.psel || vif.monitor_cb.penable)
//         continue;
//       seq_h.apb_state=IDLE;
//       apb_state_cg.sample();
//
//              seq_h.paddr  = vif.monitor_cb.paddr;
//              seq_h.pwrite = vif.monitor_cb.pwrite;
//              seq_h.pwdata = vif.monitor_cb.pwdata;
//             
//              $display("[MON] setup detected: paddr=0x%0h pwrite=%0b prdata=%0b",
//                 seq_h.paddr,seq_h.pwrite,seq_h.prdata);
//             
//       seq_h.apb_state= SETUP;
//       apb_state_cg.sample();
//              @(vif.monitor_cb);
//
//              if(!vif.presetn || $isunknown(vif.presetn)) begin
//                 $display("[MON] Reset during Access Phase --droping transaction");
//                 continue;
//              end
//
//              if(!vif.monitor_cb.penable) begin
//                 $error("[MON] %0t :penable is not asserted after SETUP",$time);
//                 continue;
//              end
//       seq_h.apb_state=ACCESS;
//       apb_state_cg.sample();
//              
//           while(!vif.monitor_cb.pready) begin
//              @(vif.monitor_cb);
//              if(!vif.presetn || $isunknown(vif.presetn)) begin
//                 $display("[MON] Reset while waiting for pready --droping transaction");
//                break;
//              end
//           end
//              seq_h.prdata =vif.monitor_cb.prdata;
//              seq_h.pslverr =vif.monitor_cb.pslverr;
//              seq_h.display("MON");
//              mon_sb.put(seq_h);
//              $display("[MON] Transaction sent to scoreboard");
//              end
//           endtask
//endclass:apb_monitor
//`endif
