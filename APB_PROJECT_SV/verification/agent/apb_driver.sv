//*************************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: This file implements the APB Driver.
//             It drives APB transactions from generator
//             to DUT using a virtual interface.
//             Includes reset handling, setup and access
//             phase execution, wait-state management,
//             and transaction resume capability after reset.
//Date: 04/03/2026 to  20/04/2026.
//************************************************************//

`ifndef _APB_DRIVER
`define _APB_DRIVER
class apb_driver;

   mailbox gen_drv;
   mailbox resume_drv;
   virtual apb_interface vif;
   apb_transaction transaction_h;
   int wait_count;

   function new(mailbox gen_drv,virtual apb_interface vif);
      this.vif = vif;
      this.gen_drv = gen_drv;
      transaction_h = new();
      resume_drv=new(1);
   endfunction
  
// Reset Logic code
   task reset_logic();
      do begin
         $display("Entered to RESET LOGIC");
         vif.master_cb.paddr   <= 32'b0;
         vif.master_cb.pwdata  <= 32'b0;
         vif.master_cb.psel    <= 1'b0;
         vif.master_cb.penable <= 1'b0;
         vif.master_cb.pwrite  <= 1'b0;
         @(vif.master_cb);
         end
         while(!vif.presetn || $isunknown(vif.presetn));
    endtask

// driver_logic        
        task driver_logic(apb_transaction transaction_h);
          transaction_h.display("Drv");

          if(!vif.presetn || $isunknown(vif.presetn)) begin
             reset_logic();
             $display("[DRV] Reset detected after Setup State - saving trans to resum_drv");
             resume_drv.put(transaction_h);
             return;
             end

         else begin
//Setup state
           transaction_h.apb_state = SETUP;
          // $display("Entered to setup state, current_state=%s",vif.apb_state.name());
           vif.master_cb.psel <= 1'b1;
           vif.master_cb.penable <= 1'b0;
           vif.master_cb.paddr <= transaction_h.paddr;
           vif.master_cb.pwdata <= transaction_h.pwdata;
           vif.master_cb.pwrite <= transaction_h.pwrite;
           end

           @(vif.master_cb);
         if(!vif.presetn || $isunknown(vif.presetn)) begin
            reset_logic();
            $display("[DRV] Reset detected after Setup State - saving trans to resum_drv");
            resume_drv.put(transaction_h);
            vif.master_cb.psel <= 1'b0;
            return;
         end

         else begin
//Access state
          transaction_h.apb_state = ACCESS;
          $display("entered to access state");
          vif.master_cb.penable<=1'b1;
         end

         @(vif.master_cb);
         if(!vif.presetn || $isunknown(vif.presetn)) begin
            reset_logic();
            $display("[DRV] Reset detected after access State before entering to ready state- saving trans to resum_drv");
            resume_drv.put(transaction_h);
            vif.master_cb.psel <= 1'b0;
            vif.master_cb.penable<=1'b0;
            transaction_h.apb_state=IDLE;
            return;
         end
         
         while (!vif.pready)
           begin
              if(!vif.presetn || $isunknown(vif.presetn)) begin
                 reset_logic();
                 $display("[DRV] Reset detected while waiting for pready-saving trans to resum_drv");
                 resume_drv.put(transaction_h);
                 return;
              end
             wait_count++;
             if (wait_count >= 5)
               $error($time,"wait count reached maximum");
               @(vif.master_cb);
               $display($time,"came out of while loop"); 
          end
          $display("Pready occured at=%0d clock pulse",wait_count);
          wait_count = 1'b0;
          @(vif.master_cb);
          $display("Transaction completed");
          vif.master_cb.psel <= 1'b0;
          vif.master_cb.penable <= 1'b0;
          transaction_h.apb_state= IDLE;
   endtask

   task run();
      forever begin
       @(vif.master_cb);
        if(!vif.presetn || $isunknown(vif.presetn))
          reset_logic();
        else begin
           if(resume_drv.num()>0) begin
              resume_drv.get(transaction_h); //Restore interrupted data
              $display("[DRV] resume savedn transaction after reset");
            end 
           else begin
             gen_drv.get(transaction_h);
            end
             driver_logic(transaction_h);
        end
      end
    endtask
endclass:apb_driver
`endif
