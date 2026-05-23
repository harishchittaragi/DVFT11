//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: This is Generator_file.
//Date: 04/03/2026 to  / /2026.
//*************************************************//

`ifndef _APB_SEQUENCER
`define _APB_SEQUENCER

class apb_sequencer extends uvm_sequencer#(apb_sequence_item);
   apb_sequence_item seq_h;
  `uvm_component_utils(apb_sequencer) 
   function new(string name = "apb_sequencer",uvm_component parent=null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
   endfunction:build_phase

   task run_phase(uvm_phase phase);
   endtask:run_phase
endclass:apb_sequencer
`endif

//class apb_generator;
//
//  apb_sequence_item packet;
//  mailbox gen_drv;
//  int count;
//  bit [1:0]write;
//  bit error;
//
//  function new(mailbox gen_drv);
//     this.gen_drv = gen_drv;
//  endfunction:new
//
//  task writing ();
//      packet=new();
//      $display("this is write block");
//      packet.randomize() with {pwrite == 1;
//                               paddr inside {[0:255]};
//                               pwdata inside {[32'h0000_0100 : 32'h0000_FFFF]};
//                               };
//      gen_drv.put(packet);
//   endtask:writing
//
//   task reading();
//      packet=new();
//      $display("this is read block");
//      packet.randomize() with {pwrite == 0;
//                               paddr inside {[0:255]};
//                              // pwdata inside {[32'h0000_0100 : 32'h0000_FFFF]};
//                              // prdata inside {[32'h0000_0100 : 32'hFFFF_FFFF]};
//                               };
//      gen_drv.put(packet);
//   endtask:reading
//
//   task error_inj();
//      packet=new();
//      $display($time,"error block");
//      packet.randomize() with {pwrite ==0;
//                               paddr == 32'hffff_ffff;
//                              };
//      gen_drv.put(packet);
//   endtask:error_inj
//
//   task run();
//     repeat(count) begin
//     if(write==2'b01 && !error) begin
//      writing();
//     end
//     else
//      if(write==2'b00 && !error)begin
//       reading();
//      end
//      else 
//       if(write ==2'b10 && !error) begin
//        writing();
//        packet.display("gen");
//        reading();
//       end
//       else
//        if(error) begin
//         error_inj();
//        end
//        else begin
//         packet=new();
//         packet.randomize();
//         gen_drv.put(packet);
//         packet.display("gen");
//        end
//        packet.display("gen");
//     end
//   endtask:run
//endclass:apb_generator`endif
