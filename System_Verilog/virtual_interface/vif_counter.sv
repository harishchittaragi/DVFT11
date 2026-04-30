class driver;

   virtual count_interface intf; // here count_interface intf is static so using virtual keyword we declaring it as dynamic in nature.

/* this below function block hepls to write 
   - d_h =new(intf)   this line in testbench*/
   function new (virtual count_interface intf);
      this.intf=intf;
   endfunction

/* this task block defines the mode selection for upcounter or downclounter*/
   task run();
   intf.tb_cb.mode<=1;
   #100 intf.tb_cb.mode<=0;
   endtask

endclass

