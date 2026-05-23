//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: APB driver responsible for driving
//             protocol transactions, handling
//             reset scenarios, managing pready
//             wait states, and resuming transfers.
//Date: 08/05/2026 to  15/05/2026.
//*************************************************//

`ifndef _APB_DRIVER
`define _APB_DRIVER

class apb_driver extends uvm_driver#(apb_sequence_item);
  // handle declaration for apb_sequence_item 
   apb_sequence_item seq_h;
   apb_sequence_item resume_drv;

   // handle declaration for virtual interface.
   virtual apb_interface vif;

   // local varibale for clock  pulse wait_count for pready occurance
   int wait_count;

   //factory registration
   `uvm_component_utils(apb_driver)

   function new(string name="apb_driver",uvm_component parent= null);
      super.new(name,parent);
      wait_count =0;
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db #(virtual apb_interface)::get(this,"","vif",vif))
         `uvm_fatal("No_VIF","Virtual interface not found in config_db of [DRV]");
   endfunction:build_phase

   //RESET LOGIC
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

    // DRIVER LOGIC        
    task driver_logic(apb_sequence_item seq_h);
       `uvm_info("DRIVER",$sformatf("Displaying from apb_driver=%0s",seq_h.sprint()),UVM_NONE);
       
       if(!vif.presetn || $isunknown(vif.presetn)) begin
          reset_logic();
          `uvm_info("[DRV]","Reset detected after Setup State -saving trans to resum_drv",UVM_NONE);
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
    `uvm_info("[DRV]","Transaction completed",UVM_NONE);

    // this condition will make psel high always
    if (seq_h.continuous_psel == 1) begin
    vif.master_cb.psel <= 1'b1;
    vif.master_cb.penable <= 1'b0; 
    seq_h.apb_state = SETUP;
 end
 else begin
    vif.master_cb.psel <= 1'b0;
    vif.master_cb.penable <= 1'b0; 
    seq_h.apb_state= IDLE;
 end
 endtask:driver_logic
 
 task run_phase(uvm_phase phase);
    forever begin
       @(vif.master_cb);
       if(!vif.presetn || $isunknown(vif.presetn))
          reset_logic();
       else begin
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
