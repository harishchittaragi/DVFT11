//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: This file implements the APB Generator.
//             It generates randomized APB transactions
//             (read, write, mixed, and error scenarios)
//             based on control variables and sends them
//             to the driver via mailbox communication.
//             Supports constrained random stimulus and
//             error injection for verification coverage.
//Date: 04/03/2026 to  20/04/2026.
//*************************************************//

`ifndef _APB_GENERATOR
`define _APB_GENERATOR
class apb_generator;

  apb_transaction packet;
  mailbox gen_drv;
  int count;
  bit [1:0]write;
  bit error;

  function new(mailbox gen_drv);
     this.gen_drv = gen_drv;
  endfunction:new

  task writing ();
      packet=new();
      $display("this is write block");
      packet.randomize() with {pwrite == 1;
                               paddr inside {[0:255]};
                               pwdata inside {[32'h0000_0100 : 32'h0000_FFFF]};
                               };
      gen_drv.put(packet);
   endtask:writing

   task reading();
      packet=new();
      $display("this is read block");
      packet.randomize() with {pwrite == 0;
                               paddr inside {[0:255]};
                               };
      gen_drv.put(packet);
   endtask:reading

   task error_inj();
      packet=new();
      $display($time,"error block");
      packet.randomize() with {pwrite ==0;
                               paddr == 32'hffff_ffff;
                              };
      gen_drv.put(packet);
   endtask:error_inj

   task run();
     repeat(count) begin
     if(write==2'b01 && !error) begin
      writing();
     end
     else
      if(write==2'b00 && !error)begin
       reading();
      end
      else 
       if(write ==2'b10 && !error) begin
        writing();
        packet.display("gen");
        reading();
       end
       else
        if(error) begin
         error_inj();
        end
        else begin
         packet=new();
         packet.randomize();
         gen_drv.put(packet);
         packet.display("gen");
        end
        packet.display("gen");
     end
   endtask:run
endclass:apb_generator`endif
