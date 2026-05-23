//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: This is Driver_file.
//Date: 04/03/2026 to  / /2026.
//*************************************************//

`ifndef _APB_DRIVER
`define _APB_DRIVER

class apb_driver extends uvm_driver#(apb_sequence_item);
   
   apb_sequence_item seq_h;
   apb_sequence_item resume_drv;
   virtual apb_interface vif;
   int wait_count;
//   bit has_resume;

   `uvm_component_utils(apb_driver)

   function new(string name="apb_driver",uvm_component parent= null);
      super.new(name,parent);
      wait_count =0;
//      has_resume =0;
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db #(virtual apb_interface)::get(this,"","vif",vif))
         `uvm_fatal("No_VIF","Virtual interface not found in config_db of [DRV]");
   endfunction:build_phase

   task reset_logic();
      `uvm_info("DRV","Entered to RESET LOGIC",UVM_NONE);
      do begin
         vif.master_cb.paddr   <= 32'b0;
         vif.master_cb.pwdata  <= 32'b0;
         vif.master_cb.psel    <= 1'b0;
         vif.master_cb.penable <= 1'b0;
         vif.master_cb.pwrite  <= 1'b0;
         @(vif.master_cb);
         end
         while(!vif.presetn || $isunknown(vif.presetn));
    endtask:reset_logic

// driver_logic        
    task driver_logic(apb_sequence_item seq_h);
       `uvm_info("DRIVER",$sformatf("Displaying from apb_driver=%0s",seq_h.sprint()),UVM_NONE);
//       seq_h.print();
       
       if(!vif.presetn || $isunknown(vif.presetn)) begin
          reset_logic();
          `uvm_info("[DRV]","Reset detected after Setup State -saving trans to resum_drv",UVM_NONE);
         // seq_item_port.put_response(seq_h);
         seq_h.has_resume=1;
          return;
       end
       else begin
//Setup state
          seq_h.apb_state = SETUP;
          `uvm_info("[DRV]","Entered SETUP State",UVM_NONE);
          vif.master_cb.psel <= 1'b1;
          vif.master_cb.penable <= 1'b0;
          vif.master_cb.paddr <= seq_h.paddr;
          vif.master_cb.pwdata <= seq_h.pwdata;
          vif.master_cb.pwrite <= seq_h.pwrite;
       end
       @(vif.master_cb);
       if(!vif.presetn || $isunknown(vif.presetn)) begin
          reset_logic();
          `uvm_info("[DRV]","Reset detected after Setup State -saving trans to resume_drv",UVM_NONE);
         // resume_drv = seq_h;
          seq_h.has_resume = 1;
          vif.master_cb.psel <= 1'b0;
          return;
       end
       else begin
//Access state
          seq_h.apb_state = ACCESS;
          `uvm_info("[DRV]","Entered ACCESS State",UVM_NONE);
          vif.master_cb.penable <= 1'b1;
       end
       @(vif.master_cb);
       if(!vif.presetn || $isunknown(vif.presetn)) begin
          reset_logic();
          `uvm_info("[DRV]"," Reset detected after access State before entering to ready state-saving trans to resum_drv",UVM_NONE);
        //  resume_drv = seq_h;
          seq_h.has_resume = 1;
          vif.master_cb.psel <= 1'b0;
          vif.master_cb.penable<=1'b0;
          seq_h.apb_state=IDLE;
          `uvm_info("[DRV]","Entered IDLE State",UVM_NONE);
          return;
       end
    while (!vif.pready) begin
       if(!vif.presetn || $isunknown(vif.presetn)) begin
          reset_logic();
          `uvm_info("[DRV]","Reset detected while waiting for pready-saving trans to resum_drv",UVM_NONE);
         // resume_drv = seq_h;
         seq_h.has_resume = 1;
          return;
       end
       wait_count++;
       if (wait_count >= 5)
          `uvm_error("[DRV]",$sformatf("[%0t] wait count reached maximum(%0d)",$time,wait_count));
       @(vif.master_cb);
    end
    `uvm_info("[DRV]",$sformatf("Pready occured at wait_count=%0d %0d %0d",wait_count,vif.paddr,vif.pwdata),UVM_NONE);
    wait_count = 1'b0;
    @(vif.master_cb);
//    @(vif.master_cb);
    `uvm_info("[DRV]","Transaction completed",UVM_NONE);

    if (seq_h.continuous_psel == 1) begin
    `uvm_info("[abc]","Transaction completed",UVM_NONE);
    vif.master_cb.psel <= 1'b1;
    vif.master_cb.penable <= 1'b0; 
    seq_h.apb_state = SETUP;
 end
 else begin
    `uvm_info("[abc1]","Transaction completed",UVM_NONE);
    `uvm_info("[abc1]",$sformatf(" %0d",seq_h.continuous_psel),UVM_NONE);
    vif.master_cb.psel <= 1'b0;
    vif.master_cb.penable <= 1'b0; 
    seq_h.apb_state= IDLE;
 end
 endtask:driver_logic
 
 task run_phase(uvm_phase phase);
    forever begin
//       seq_item_port.get_next_item(seq_h);
//       `uvm_info("DRIVER",$sformatf("Displaying from apb_driver=%0s",seq_h.sprint()),UVM_NONE);

       @(vif.master_cb);
       if(!vif.presetn || $isunknown(vif.presetn))
          reset_logic();
       else begin
//          if(has_resume) begin
             //TODO resume_drv : i should send this pkt to seq
//             seq_h = resume_drv; //Restore interrupted data
//             has_resume = 0;
//             `uvm_info("[DRV]","resume saved in transaction after reset",UVM_NONE);
//          end
//          else begin
//             seq_item_port.get_next_item(seq_h);
//             `uvm_info(get_type_name(),$sformatf("Displaying from apb_driver=%0s",seq_h.sprint()),UVM_NONE);
//          end
//          driver_logic(seq_h);
//          if(!has_resume)
//             seq_item_port.item_done();
//
            seq_item_port.get_next_item(seq_h);
            // here below cloning the seq_h to resume_drv
            driver_logic(seq_h);
            seq_item_port.item_done();
            //now checking for reset occurance if occured has_resume become
               //high then we were putting resume_drv to sequence and getting
               //it inside the sequences.
               if(seq_h.has_resume) begin
               $cast(resume_drv,seq_h.clone());
               resume_drv.set_id_info(seq_h);
               seq_item_port.put_response(resume_drv);
            end
            else
               seq_item_port.put_response(seq_h);//not reset then putting seq_h.
       end
    end
 endtask:run_phase
 endclass:apb_driver
`endif



//   mailbox gen_drv;
//   mailbox resume_drv;
//   virtual apb_interface vif;
//   apb_sequence_item seq_h;
//   int wait_count;
//
//   function new(mailbox gen_drv,virtual apb_interface vif);
//      this.vif = vif;
//      this.gen_drv = gen_drv;
//      seq_h = new();
//      resume_drv=new(1);
//   endfunction
//  
//// Reset Logic code
//   task reset_logic();
//      do begin
//         $display("Entered to RESET LOGIC");
//         vif.master_cb.paddr   <= 32'b0;
//         vif.master_cb.pwdata  <= 32'b0;
//         vif.master_cb.psel    <= 1'b0;
//         vif.master_cb.penable <= 1'b0;
//         vif.master_cb.pwrite  <= 1'b0;
//         @(vif.master_cb);
//         end
//         while(!vif.presetn || $isunknown(vif.presetn));
//    endtask
//
//// driver_logic        
//        task driver_logic(apb_sequence_item seq_h);
//          seq_h.display("Drv");
//
//          if(!vif.presetn || $isunknown(vif.presetn)) begin
//             reset_logic();
//             $display("[DRV] Reset detected after Setup State - saving trans to resum_drv");
//             resume_drv.put(seq_h);
//             return;
//             end
//
//         else begin
////Setup state
//           seq_h.apb_state = SETUP;
//          // $display("Entered to setup state, current_state=%s",vif.apb_state.name());
//           vif.master_cb.psel <= 1'b1;
//           vif.master_cb.penable <= 1'b0;
//           vif.master_cb.paddr <= seq_h.paddr;
//           vif.master_cb.pwdata <= seq_h.pwdata;
//           vif.master_cb.pwrite <= seq_h.pwrite;
//           end
//
//           @(vif.master_cb);
//         if(!vif.presetn || $isunknown(vif.presetn)) begin
//            reset_logic();
//            $display("[DRV] Reset detected after Setup State - saving trans to resum_drv");
//            resume_drv.put(seq_h);
//            vif.master_cb.psel <= 1'b0;
//            return;
//         end
//
//         else begin
////Access state
//          seq_h.apb_state = ACCESS;
//          $display("entered to access state");
//          vif.master_cb.penable<=1'b1;
//         end
//
//         @(vif.master_cb);
//         if(!vif.presetn || $isunknown(vif.presetn)) begin
//            reset_logic();
//            $display("[DRV] Reset detected after access State before entering to ready state- saving                      trans to resum_drv");
//            resume_drv.put(seq_h);
//            vif.master_cb.psel <= 1'b0;
//            vif.master_cb.penable<=1'b0;
//            seq_h.apb_state=IDLE;
//            return;
//         end
//         
//         while (!vif.pready)
//           begin
//              if(!vif.presetn || $isunknown(vif.presetn)) begin
//                 reset_logic();
//                 $display("[DRV] Reset detected while waiting for pready-saving trans to resum_drv");
//                 resume_drv.put(seq_h);
//                 return;
//              end
//             wait_count++;
//             if (wait_count >= 5)
//               $error($time,"wait count reached maximum");
//               @(vif.master_cb);
//               $display($time,"came out of while loop"); 
//          end
//          $display("Pready occured at=%0d clock pulse",wait_count);
//          wait_count = 1'b0;
//          @(vif.master_cb);
//          $display("Transaction completed");
//          vif.master_cb.psel <= 1'b0;
//          vif.master_cb.penable <= 1'b0;
//          seq_h.apb_state= IDLE;
//   endtask
//
//   task run();
//      forever begin
//       @(vif.master_cb);
//        if(!vif.presetn || $isunknown(vif.presetn))
//          reset_logic();
//        else begin
//           if(resume_drv.num()>0) begin
//              resume_drv.get(seq_h); //Restore interrupted data
//              $display("[DRV] resume savedn transaction after reset");
//            end 
//           else begin
//             gen_drv.get(seq_h);
//            end
//             driver_logic(seq_h);
//        end
//      end
//    endtask
//endclass:apb_driver
//`endif
