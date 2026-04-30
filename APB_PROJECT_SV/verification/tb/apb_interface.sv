//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: APB Interface that acts as a communication
//             bridge between testbench and DUT by grouping
//             all protocol signals. Supports timing control
//             via clocking blocks, structured access through
//             modports, and protocol validation using embedded
//             assertions to ensure compliance with APB standards.//Date: 04/03/2026 to  20/04/2026.
//*************************************************//


`ifndef _APB_INTERFACE
`define _APB_INTERFACE

interface apb_interface(input logic pclk,input logic presetn);
   // control signals.

      logic       psel;
      logic       penable;
      logic       pready;

   // side band signals.

      logic[31:0] paddr;
      logic       pwrite;
      logic[31:0] prdata;
      logic[31:0] pwdata;
      logic       pslverr;

   // This signals is for APB4/5.

     // logic       pprot;
     // logic       pstrb;
     // logic       pauser;
     // logic       pwuser;
     // logic       pbuser;
     // logic       pruser;

    // Clocking Block
      
      clocking master_cb @ (posedge pclk);
          //default input #2 output #2;
         input pready, prdata, pslverr;
         output psel, penable, paddr, pwrite, pwdata ;
      endclocking

       clocking monitor_cb @ (negedge pclk);
         // default input #2 output #2;
         input pready, prdata, pslverr;
         input psel, penable, paddr, pwrite, pwdata ;
      endclocking

//Modports
      modport slave_mp(input psel, penable, paddr, pwrite, pwdata,
                       output pready, prdata, pslverr);

//ASSERTIONS                    
      property reset_check;
       @(posedge pclk)
       (!presetn)|->(!psel&&!penable);
      endproperty
      preset_check: assert property (reset_check);
            
      property psel_penable;
       @(posedge pclk) disable iff(!presetn)
       $rose(penable)|-> (psel && !$past(penable));
      endproperty
      psel_to_penable:assert property (psel_penable); 

      property addr_stable;
       @(posedge pclk) disable iff(!presetn)
       (penable&&!pready) |=> $stable(paddr);
      endproperty
      paddr_stable:assert property (addr_stable); 
      
      property write_stable;
       @(posedge pclk) disable iff(!presetn)
       (penable&&!pready) |=> $stable(pwrite);
      endproperty
      pwrite_stable: assert property (write_stable);

      property wdata_stable;
       @(posedge pclk) disable iff(!presetn)
       (penable && pwrite &&! pready) |=> $stable(pwdata);
      endproperty
      pwdata_stable: assert property (wdata_stable); 

      property read_check;
       @(posedge pclk) disable iff(!presetn)
       (psel&& penable)|->##[0:5]pready;
      endproperty
      prdata_checking: assert property (read_check); 

      property slverr_check;
       @(posedge pclk) disable iff(!presetn)
       (psel&& penable && pready && pslverr)|-> (penable && pready);
      endproperty
      pslverr_checking: assert property (slverr_check);

      property ready_wait;
       @(posedge pclk) disable iff(!presetn)
       $rose(psel) |=>(penable##[1:5]pready);
      endproperty
      pready_waiting: assert property (ready_wait); 

endinterface:apb_interface
`endif
