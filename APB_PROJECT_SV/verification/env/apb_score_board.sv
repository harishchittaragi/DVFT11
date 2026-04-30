//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: APB Scoreboard responsible for functional
//             verification by comparing DUT outputs with
//             expected results using a reference memory model.
//             Validates read/write operations, identifies
//             protocol violations and data mismatches, and
//             ensures correctness of APB transactions.
//             Supports error handling and coverage of corner cases.
//Date: 04/03/2026 to  20/04/2026.
//*************************************************//

`ifndef _APB_SCORE_BOARD
`define _APB_SCORE_BOARD
class apb_score_board;

   mailbox mon_sb;
   apb_transaction transaction_h;

   bit[31:0] mem [bit[31:0]];
  // int pass_count;
  // int fail_count;

   function new(mailbox mon_sb);
      this.mon_sb=mon_sb;
     // pass_count=0;
     // fail_count=0;
   endfunction

  // function void report();
  //    $display("------------------------------------------------------------");
  //    $display("[SB] Score board summary");
  //    $display("[SB] PASS : %0d",pass_count);
  //    $display("[SB] FAIL : %0d",fail_count);
  //    $display("[SB] TOTAL : %0d",pass_count+ fail_count);
  //    $display("-------------------------------------------------------------");
  // endfunction:report

   task run();
      forever begin
         transaction_h=new();
         mon_sb.get(transaction_h);
         $display("[SB] Recieved packets");

         if(transaction_h.pslverr) begin
            $error("[SB] %0t : Slave error on paddr=0x%0h pwrite=%0b",$time,transaction_h.paddr,                        transaction_h.pwrite);
            continue;
         end

         if(transaction_h.pwrite) begin
            mem[transaction_h.paddr]=transaction_h.pwdata;
            $display("[SB] %0t: WRITE mem[0x%0h]= 0x%0h",$time,
               transaction_h.paddr,transaction_h.pwdata);
         end
         else begin
            if(!mem.exists(transaction_h.paddr)) begin
               $warning("[SB] %0t: READ from uninitialised addr 0x%0h -no reference",
                  $time,transaction_h.paddr);
              // fail_count++;
               continue;
            end

            if(mem[transaction_h.paddr]==transaction_h.prdata) begin
              // pass_count++;
               $display("[SB] %0t : Pass paddr=0x%0h expected=0x%0h got=0x%0h",
               $time,transaction_h.paddr,mem[transaction_h.paddr],transaction_h.prdata);
            end
            else begin
              // fail_count++;
               $error("[SB] %0t : FAIL paddr=0x%0h expected =0x%0h got=0x%0h",
               $time,transaction_h.paddr,mem[transaction_h.paddr],transaction_h.prdata);
            end
         end
      end
   endtask:run
endclass:apb_score_board
`endif
