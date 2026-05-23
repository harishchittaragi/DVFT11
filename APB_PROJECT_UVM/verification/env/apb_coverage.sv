//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: APB coverage component that collects
//             functional coverage from active and
//             passive monitors using analysis ports,
//             and samples protocol, state, and error
//             scenarios for verification.
//Date: 08/05/2026 to 15/05/2026.
//*************************************************//

`ifndef _APB_COVERAGE
`define _APB_COVERAGE
// imp port declaration for active_monitor and passive_monitor purpose.
`uvm_analysis_imp_decl(_ACT)
`uvm_analysis_imp_decl(_PAS)

class apb_coverage extends uvm_subscriber #(apb_sequence_item);
//  factory registration.
   `uvm_component_utils(apb_coverage)

//  imp port naming
   uvm_analysis_imp_ACT#(apb_sequence_item,apb_coverage) cov_act_imp;
   uvm_analysis_imp_PAS#(apb_sequence_item,apb_coverage) cov_pas_imp;

//  handle declaration for seq_item.
   apb_sequence_item act_seq;
   apb_sequence_item pas_seq;

// COVERAGES
  covergroup act_proto_cg;
//        control signal:
//        psel:
          cp_psel : coverpoint act_seq.psel {
             bins psel_high = {1'b1};
             bins psel_low  = {1'b0};
          }
//        penable:
          cp_penable : coverpoint act_seq.penable {
             bins penable_high = {1'b1};
             bins penable_low  = {1'b0};
          }
//        pready:
          cp_pready : coverpoint act_seq.pready {
             bins pready_high = {1'b1};
             bins pready_low  = {1'b0};
          }
//        pwrite:
          cp_pwrite : coverpoint act_seq.pwrite {
             bins pwrite_high = {1'b1};
             bins pwrite_low  = {1'b0};
          }
//        Slave error response
//        pslverr:
          cp_pslverr: coverpoint act_seq.pslverr {
              bins no_error = {1'b0};
              bins error    = {1'b1};
          }

//         Address & data
//         paddr:
           cp_paddr: coverpoint act_seq.paddr {
              bins low_range  = {[32'h0 : 32'h64]};
              bins mid_range  = {[32'h65 : 32'hC8]};
              bins high_range = {[32'hC9 : 32'hFF]};
           }
//         pwdata:
           cp_pwdata: coverpoint act_seq.pwdata {
              bins low_range  = {[32'h0000_0000 : 32'h0000_00FF]};
              bins mid_range  = {[32'h0000_0100 : 32'h0000_FFFF]};
              bins high_range = {[32'h0001_0000 : 32'hFFFF_FFFF]};
           }
//         prdata:
           cp_prdata: coverpoint act_seq.prdata {
              bins zero  = {32'h0};
              bins low_range  = {[32'h1 : 32'h64]};
              bins high_range = {[32'h65 :32'hFF]};
           }

//         Transfer type
           cp_transfer: coverpoint act_seq.pwrite {
              bins read  = {1'b0};
              bins write = {1'b1};
           }

//         pready Wait states:
//         pready:
           cp_wait: coverpoint act_seq.pready {
              bins pready_wait    = {1'b0};
              bins pready_no_wait = {1'b1};
           } 
  endgroup:act_proto_cg

//   Coverages for state diagram
  covergroup act_state_cg;
     cp_state:coverpoint act_seq.apb_state {
        bins idle_state   = {2'b00};
        bins setup_state  = {2'b01};
        bins access_state = {2'b10};
     }
// state transition
     cp_state_transition: coverpoint act_seq.apb_state {
        bins idle_setup   = (IDLE => SETUP);
        bins setup_access = (SETUP => ACCESS);
        bins access_idle  = (ACCESS => IDLE);
     }
  endgroup:act_state_cg

//Coverages for error 
  covergroup act_error_cg;
     //error during write
     cp_err_on_write: coverpoint act_seq.pslverr{
        bins err_write={1'b1};
        bins no_err={1'b0};
     }

     //address caused error
     cp_err_addr:coverpoint act_seq.paddr{
        bins low_addr={[32'h0:32'h64]};
        bins mid_addr={[32'h65:32'hC8]};
        bins high_addr={[32'hC9:32'hFF]};
     }
  endgroup:act_error_cg

  // COVERAGES
  covergroup pas_proto_cg;
//        control signal:
//        psel:
          cp_psel : coverpoint pas_seq.psel {
             bins psel_high = {1'b1};
             bins psel_low  = {1'b0};
          }
//        penable:
          cp_penable : coverpoint pas_seq.penable {
             bins penable_high = {1'b1};
             bins penable_low  = {1'b0};
          }
//        pready:
          cp_pready : coverpoint pas_seq.pready {
             bins pready_high = {1'b1};
             bins pready_low  = {1'b0};
          }
//        pwrite:
          cp_pwrite : coverpoint pas_seq.pwrite {
             bins pwrite_high = {1'b1};
             bins pwrite_low  = {1'b0};
          }
//        Slave error response
//        pslverr:
          cp_pslverr: coverpoint pas_seq.pslverr {
              bins no_error = {1'b0};
              bins error    = {1'b1};
          }

//         Address & data
//         paddr:
           cp_paddr: coverpoint pas_seq.paddr {
              bins low_range  = {[32'h0 : 32'h64]};
              bins mid_range  = {[32'h65 : 32'hC8]};
              bins high_range = {[32'hC9 : 32'hFF]};
           }
//         pwdata:
           cp_pwdata: coverpoint pas_seq.pwdata {
              bins low_range  = {[32'h0000_0000 : 32'h0000_00FF]};
              bins mid_range  = {[32'h0000_0100 : 32'h0000_FFFF]};
              bins high_range = {[32'h0001_0000 : 32'hFFFF_FFFF]};
           }
//         prdata:
           cp_prdata: coverpoint pas_seq.prdata {
              bins zero  = {32'h0};
              bins low_range  = {[32'h1 : 32'h64]};
              bins high_range = {[32'h65 :32'hFF]};
           }

//         Transfer type
           cp_transfer: coverpoint pas_seq.pwrite {
              bins read  = {1'b0};
              bins write = {1'b1};
           }

//         pready Wait states:
//         pready:
           cp_wait: coverpoint pas_seq.pready {
              bins pready_wait    = {1'b0};
              bins pready_no_wait = {1'b1};
           } 
  endgroup:pas_proto_cg

//   Coverages for state diagram
  covergroup pas_state_cg;
     cp_state:coverpoint pas_seq.apb_state {
        bins idle_state   = {2'b00};
        bins setup_state  = {2'b01};
        bins access_state = {2'b10};
     }
// state transition
     cp_state_transition: coverpoint pas_seq.apb_state {
        bins idle_setup   = (IDLE => SETUP);
        bins setup_access = (SETUP => ACCESS);
        bins access_idle  = (ACCESS => IDLE);
     }
  endgroup:pas_state_cg


//Coverages for error 
  covergroup pas_error_cg;
     //error during write
     cp_err_on_write: coverpoint pas_seq.pslverr{
        bins err_write={1'b1};
        bins no_err={1'b0};
     }

     //address caused error
     cp_err_addr:coverpoint pas_seq.paddr{
        bins low_addr={[32'h0:32'h64]};
        bins mid_addr={[32'h65:32'hC8]};
        bins high_addr={[32'hC9:32'hFF]};
     }
  endgroup:pas_error_cg

  function new(string name ="apb_coverage",uvm_component parent = null);
     super.new(name,parent);
     act_proto_cg=new();
     act_state_cg=new();
     act_error_cg=new();
     pas_proto_cg=new();
     pas_state_cg=new();
     pas_error_cg=new();
  endfunction:new

  function void build_phase(uvm_phase phase);
     super.build_phase(phase);
      cov_act_imp=new("cov_act_imp",this);
      cov_pas_imp=new("cov_pas_imp",this);
  endfunction:build_phase

  function void write(apb_sequence_item t);

  endfunction:write

  function void write_ACT(apb_sequence_item item1);
     $cast(act_seq,item1.clone());
     act_proto_cg.sample();
     act_state_cg.sample();
     act_error_cg.sample();
     `uvm_info("[APB_COV]",
        $sformatf("[ACTIVE] paddr=0x%0h pwrite=%0b pwdata=0x%0h state=%s",
          act_seq.paddr,act_seq.pwrite,act_seq.pwdata,act_seq.apb_state.name()),UVM_HIGH);
  endfunction:write_ACT

  function void write_PAS(apb_sequence_item item2);
     $cast(pas_seq,item2.clone());
     pas_proto_cg.sample();
     pas_state_cg.sample();
     pas_error_cg.sample();
     `uvm_info("[APB_COV]",
        $sformatf("[PASSIVE] paddr=0x%0h pwrite=%0b pwdata=0x%0h state=%s",
          pas_seq.paddr,pas_seq.pwrite,pas_seq.pwdata,pas_seq.apb_state.name()),UVM_HIGH);
  endfunction:write_PAS
endclass:apb_coverage
`endif
