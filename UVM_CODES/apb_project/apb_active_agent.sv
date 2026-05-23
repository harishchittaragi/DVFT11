`ifndef _APB_ACTIVE_AGENT
`define _APB_ACTIVE_AGENT
class apb_active_agent extends uvm_agent;

   apb_sequencer seqr_h;
   apb_driver drv_h;
   apb_active_monitor act_mon_h;
   
   `uvm_component_utils(apb_active_agent)

   function new(string name = "apb_active_agent",uvm_component parent =null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(get_is_active()==UVM_ACTIVE) begin
         seqr_h=apb_sequencer::type_id::create("seqr_h",this);
         drv_h=apb_driver::type_id::create("drv_h",this);
         act_mon_h=apb_active_monitor::type_id::create("act_mon_h",this);
         `uvm_info("[ACTIVE_AGNET]","Memory created for [DRV] [SEQR] [ACT_MON]",UVM_HIGH);
      end
      else
         `uvm_error("[ACTIVE_AGNET]","Memorynot created for [DRV] [SEQR] [ACT_MON]");
   endfunction:build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      drv_h.seq_item_port.connect(seqr_h.seq_item_export);
   endfunction:connect_phase
endclass:apb_active_agent
`endif



//   function new(virtual apb_interface vif,mailbox mon_sb);
//     this.vif = vif;
//     this.mon_sb=mon_sb;
//     gen_drv = new();
//     gen = new(gen_drv);
//     drv = new(gen_drv,vif);
//     mon = new(vif,mon_sb);
//  endfunction
//  
//  task run();
//     fork
//        gen.run();
//        drv.run();
//        mon.run();
//     join_any
//     #500;
//     disable fork;
//  endtask
//endclass
//`endif
