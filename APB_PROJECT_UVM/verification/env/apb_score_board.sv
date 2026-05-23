//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: APB scoreboard that compares
//             transactions from active and
//             passive monitors, verifies data
//             integrity using reference memory,
//             and reports pass/fail results.
//Date: 08/05/2026 to 15/05/2026.
//*************************************************//

`ifndef _APB_SCORE_BOARD
`define _APB_SCORE_BOARD

// imp port declarations
`uvm_analysis_imp_decl(_ACTIVE)
`uvm_analysis_imp_decl(_PASSIVE)

class apb_score_board extends uvm_scoreboard;
//  factory registration
   `uvm_component_utils(apb_score_board)

//  imp port name specifications  
   uvm_analysis_imp_ACTIVE#(apb_sequence_item,apb_score_board)act_imp;
   uvm_analysis_imp_PASSIVE#(apb_sequence_item,apb_score_board)pas_imp;

   apb_sequence_item active_queue[$]; //transaction from active monitor
   apb_sequence_item passive_queue[$]; //transaction from passive monitor

   bit[31:0] mem [bit[31:0]];
// local variables for report specification
   int pass_count;
   int fail_count;
   int total_count;

   function new(string name="apb_score_board",uvm_component parent = null);
      super.new(name,parent);
//      local variables initializing with value 0;
      pass_count=0;
      fail_count=0;
      total_count=0;
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
//      memory declaration for imp ports.
      act_imp=new("act_imp",this);
      pas_imp=new("pas_imp",this);
   endfunction:build_phase

   function void write_ACTIVE(apb_sequence_item t);
      apb_sequence_item item;
      $cast(item,t.clone()); //clone to avoid overwrite
      active_queue.push_back(item);
      `uvm_info("[SB]",
         $sformatf("[ACTIVE] paddr=0x%0h pwrite=%0h pwdata=0x%0h prdata=0x%0h pslverr=%0b",
         item.paddr,item.pwrite,item.pwdata,item.prdata,item.pslverr),UVM_NONE);
      compare_transactions();
   endfunction:write_ACTIVE

   function void write_PASSIVE(apb_sequence_item t);
      apb_sequence_item item;
      $cast(item,t.clone());
      passive_queue.push_back(item);
      `uvm_info("[SB]",
         $sformatf("[PASSIVE] paddr=0x%0h pwrite=%0h pwdata=0x%0h prdata=0x%0h pslverr=%0b",
         item.paddr,item.pwrite,item.pwdata,item.prdata,item.pslverr),UVM_NONE);
      compare_transactions();
   endfunction:write_PASSIVE

   function void compare_transactions();
      apb_sequence_item act_t,pas_t;
      //Only compare when both queues have data
      if(active_queue.size()==0 || passive_queue.size()==0)
         return;

      //Pop one transaction from each queue
      act_t=active_queue.pop_front();
      pas_t=passive_queue.pop_front();
      
      total_count++;
      //--------------------------------------------
      //CHECK 1: Slave error flag
      //if pslverr is set ----log and skip data check
      //---------------------------------------------
      if(act_t.pslverr ||pas_t.pslverr) begin
         fail_count++;
         `uvm_error("[SB]",
            $sformatf("[%0t] SLAVE ERROR:paddr=0x%0h pwrite =0x%0h act_pslverr=%0b pas_pslverr=%0b",
         $time,act_t.paddr,act_t.pwrite,act_t.pslverr,pas_t.pslverr));
         return;
      end

      //------------------------------------------------
      //CHECK 2:Address match
      //Both monitors must see the same address
      //--------------------------------------------------
      if(act_t.paddr != pas_t.paddr) begin
         fail_count++;
         `uvm_error("[SB]",
         $sformatf("[%0t]ADDR MISMATCH:active_addr=0x%0h passive_addr=0x%0h",
      $time,act_t.paddr,pas_t.paddr));
      return;
     end

     //---------------------------------------------------
     //CHECK 3: Transfer direction match
     //Both monitors must see same pwrite
     //-------------------------------------------
     if(act_t.pwrite != pas_t.pwrite) begin
        fail_count++;
        `uvm_error("[SB]",
         $sformatf("[%0t]PWRITE MISMATCH:active_pwrite=0x%0h passive_pwrite=0x%0h",
      $time,act_t.pwrite,pas_t.pwrite));
        return;
     end

     //-----------------------------------------------
     //CHECK 4a: WRITE transaction
     //Compare pwdata seen by both monitors
     //Update reference memory mode1
     //----------------------------------
     if(act_t.pwrite) begin
        if(act_t.pwdata != pas_t.pwdata) begin
           fail_count++;
           `uvm_error("[SB]",
              $sformatf("[%0t]WRITE DATA MISMATCH:paddr=0x%0h active_pwdata=0x%0h passive_pwdata=0x%0h",$time,act_t.paddr,act_t.pwdata,pas_t.pwdata));
        end
        else begin
           pass_count++;
           mem[act_t.paddr]= act_t.pwdata;
           `uvm_info("[SB]",
              $sformatf("[%0t]WRITE PASS:mem[0x%0h]=0x%0h",
               $time,act_t.paddr,act_t.pwdata),UVM_NONE);
         end
      end

      //--------------------------------------
      //CHECK 4b: READ transaction
      //Step1 ---compare prdata from both monitors
      //Step2 ---compare passive prdata vs ref memory
      //-------------------------------------------
      else begin
         //Step 1: active vs passive prdata
         if(act_t.prdata != pas_t.prdata) begin
            fail_count++;
            `uvm_error("[SB]",
               $sformatf("[%0t] READ DATA MISMATCH (active vs passive): paddr=0x%0h active_prdata=0x%0h passive_prdata=0x%0h",$time,act_t.paddr,act_t.prdata,pas_t.prdata));
            return;
         end

         //Step 2: passive prdata vs ref memory
         if(!mem.exists(act_t.paddr)) begin
            `uvm_warning("[SB]",
               $sformatf("[%0t] READ from uninitialised addr 0x%0h --- no ref",
                $time,act_t.paddr));
             fail_count++;
             return;
          end

          if(mem[act_t.paddr]==pas_t.prdata) begin
             pass_count++;
             `uvm_info("[SB]",
                $sformatf("[%ot] READ PASS :paddr=0x%0h expected=0x%0h got=0x%0h",
                 $time,act_t.paddr,mem[act_t.paddr],pas_t.prdata),UVM_NONE);
           end
        end
     endfunction:compare_transactions

        //========================================//
        //check_phase ---flag leftover queue entries
        //If queues are not empty at of test,
        //transactions were dropped somewhere
        //========================================//

    function void check_phase(uvm_phase phase);
       if(active_queue.size()!=0)
          `uvm_error("[SB]",
             $sformatf("%0d unmatched transaction left in active_queue",
              active_queue.size()));
       if(passive_queue.size()!=0)
          `uvm_error("[SB]",
             $sformatf("%0d unmatched transaction left in passive_queue",
              passive_queue.size()));
    endfunction:check_phase

    //====================================//
    //report_phase --- print final summary
    //====================================//
    function void report_phase(uvm_phase phase);
       `uvm_info("SB","------------------------------",UVM_NONE);
       `uvm_info("SB","     SCOREBOARD SUMMARY      ",UVM_NONE);
       `uvm_info("SB","------------------------------",UVM_NONE);
       `uvm_info("SB",$sformatf(" TOTAL :%0d",total_count),UVM_NONE);
       `uvm_info("SB",$sformatf(" PASS :%0d",pass_count),UVM_NONE);
       `uvm_info("SB",$sformatf(" FAIL :%0d",fail_count),UVM_NONE);
       `uvm_info("SB","------------------------------",UVM_NONE);
       if(fail_count==0) begin
          `uvm_info("[SB]"," RESULT:** ALL TEST PASSED **",UVM_NONE);
       end
       else begin
          `uvm_info("[SB]"," RESULT:** TEST FAILED **",UVM_HIGH);
          `uvm_info("SB","------------------------------",UVM_NONE);
       end
    endfunction:report_phase
 endclass:apb_score_board
 `endif
