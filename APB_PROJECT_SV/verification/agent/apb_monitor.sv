//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: APB Monitor responsible for passive observation
//             of bus activity, reconstructing transactions,
//             and validating protocol behavior. Implements
//             detailed functional coverage including control
//             signals, transfer types, wait states, error
//             responses, and state machine transitions.
//             Ensures robust handling of reset conditions
//             and forwards valid transactions to scoreboard.
//Date: 04/03/2026 to  20/04/2026.
//*************************************************//

`ifndef _APB_MONITOR
`define _APB_MONITOR
class apb_monitor;
  virtual apb_interface vif;
  mailbox mon_sb;
  apb_transaction transaction_h;
  
  function new ( virtual apb_interface vif, mailbox mon_sb);
    transaction_h = new();
    this.vif      = vif;
    this.mon_sb   = mon_sb;
    apb_proto_cg  = new();
    apb_state_cg  = new();
  endfunction :new

// COVERAGES
  covergroup apb_proto_cg ;
//        control signal:
//        psel:
          cp_psel : coverpoint vif.monitor_cb.psel {
             bins psel_high = {1'b1};
             bins psel_low  = {1'b0};
          }
//        penable:
          cp_penable : coverpoint vif.monitor_cb.penable {
             bins penable_high = {1'b1};
             bins penable_low  = {1'b0};
          }
//        pready:
          cp_pready : coverpoint vif.monitor_cb.pready {
             bins pready_high = {1'b1};
             bins pready_low  = {1'b0};
          }
//        pwrite:
          cp_pwrite : coverpoint transaction_h.pwrite {
             bins pwrite_high = {1'b1};
             bins pwrite_low  = {1'b0};
          }
//        Slave error response
//        pslverr:
          cp_pslverr: coverpoint transaction_h.pslverr {
              bins no_error = {1'b0};
              bins error    = {1'b1};
          }

//         Address & data
//         paddr:
           cp_paddr: coverpoint transaction_h.paddr {
              bins low_range  = {[32'h0 : 32'h64]};
              bins mid_range  = {[32'h65 : 32'hC8]};
              bins high_range = {[32'hC9 : 32'hFF]};
           }
//         pwdata:
           cp_pwdata: coverpoint transaction_h.pwdata {
              bins low_range  = {[32'h0000_0000 : 32'h0000_00FF]};
              bins mid_range  = {[32'h0000_0100 : 32'h0000_FFFF]};
              bins high_range = {[32'h0001_0000 : 32'hFFFF_FFFF]};
           }
//         prdata:
           cp_prdata: coverpoint transaction_h.prdata {
              bins zero  = {32'h0};
              bins low_range  = {[32'h1 : 32'h64]};
              bins high_range = {[32'h65 :32'hFF]};
           }

//         Transfer type
           cp_transfer: coverpoint transaction_h.pwrite {
              bins read  = {1'b0};
              bins write = {1'b1};
           }

//         pready Wait states:
//         pready:
           cp_wait: coverpoint vif.monitor_cb.pready {
              bins pready_wait    = {1'b0};
              bins pready_no_wait = {1'b1};
           } 
           endgroup

//   Coverages for state diagram
  covergroup apb_state_cg;
     cp_state:coverpoint transaction_h.apb_state {
        bins idle_state   = {2'b00};
        bins setup_state  = {2'b01};
        bins access_state = {2'b10};
     }
// state transition
     cp_state_transition: coverpoint transaction_h.apb_state {
        bins idle_setup   = (2'b00 => 2'b01);
        bins setup_access = (2'b01 => 2'b10);
        bins access_idle  = (2'b10 => 2'b00);
     }
  endgroup
    
  task run();
    forever begin
              apb_proto_cg.sample();
      @(vif.monitor_cb);

      if(!vif.presetn || $isunknown(vif.presetn))
         continue;
      if(!vif.monitor_cb.psel || vif.monitor_cb.penable)
         continue;
       transaction_h.apb_state=IDLE;
       apb_state_cg.sample();

              transaction_h.paddr  = vif.monitor_cb.paddr;
              transaction_h.pwrite = vif.monitor_cb.pwrite;
              transaction_h.pwdata = vif.monitor_cb.pwdata;
             
              $display("[MON] setup detected: paddr=0x%0h pwrite=%0b prdata=%0b",
                 transaction_h.paddr,transaction_h.pwrite,transaction_h.prdata);
             
       transaction_h.apb_state= SETUP;
       apb_state_cg.sample();
              @(vif.monitor_cb);

              if(!vif.presetn || $isunknown(vif.presetn)) begin
                 $display("[MON] Reset during Access Phase --droping transaction");
                 continue;
              end

              if(!vif.monitor_cb.penable) begin
                 $error("[MON] %0t :penable is not asserted after SETUP",$time);
                 continue;
              end
       transaction_h.apb_state=ACCESS;
       apb_state_cg.sample();
              
           while(!vif.monitor_cb.pready) begin
              @(vif.monitor_cb);
              if(!vif.presetn || $isunknown(vif.presetn)) begin
                 $display("[MON] Reset while waiting for pready --droping transaction");
                break;
              end
           end
              transaction_h.prdata =vif.monitor_cb.prdata;
              transaction_h.pslverr =vif.monitor_cb.pslverr;
              transaction_h.display("MON");
              mon_sb.put(transaction_h);
              $display("[MON] Transaction sent to scoreboard");
              end
           endtask
endclass:apb_monitor
`endif
