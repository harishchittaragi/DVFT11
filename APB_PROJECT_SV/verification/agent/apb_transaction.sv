//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: APB Transaction object used as a data container
//             for communication between generator, driver,
//             monitor, and scoreboard. Encapsulates all APB
//             protocol signals, supports randomization with
//             constraints, and models APB state transitions
//             for accurate protocol verification.
//Date: 04/03/2026 to  20/04/2026.
//*************************************************//
`ifndef _APB_TRANSACTION
`define _APB_TRANSACTION

typedef enum logic[1:0] {
        IDLE   = 2'b00,
        SETUP  = 2'b01,
        ACCESS = 2'b10
        } apb_state_e;

class apb_transaction ;
      bit       psel;
      bit       penable;
      bit       pready;

rand  bit[31:0] paddr;
rand  bit       pwrite;
      bit[31:0] prdata;
rand  bit[31:0] pwdata;
      bit       pslverr;
     apb_state_e apb_state;
     constraint c_paddr {soft paddr inside {[0:32'hffff_ffff]};}
     function void display(string name);
             $display("[%0t] [%s] paddr=%0d pwrite=%0b pwdata=%0d prdata=%0d pslverr=%0b",
             $time,name, paddr, pwrite, pwdata, prdata, pslverr);      
      endfunction
endclass:apb_transaction
`endif
