`include "interface.sv"// always this should be include first.
`include "counter.sv" // including design file.
`include "vif_counter.sv" //including virtual interface file.

module tb_top();
count_interface intf();

//counter DUT(.clk(intf.clk), .reset(intf.reset), .mode(intf.mode), .out(intf.out)); // this line is for pure design where the design not included with any interface block
counter DUT(intf);// this line is for interface included design modules.

driver d_h;// this handle assigning for class defined in virtual interface file.

always #5 intf.clk=~intf.clk;// here we cant able to call modport or clocking block clk we define it logic method clock only.

initial begin
intf.clk<=0; // here clock starts generating with logic based definig clk only.
intf.tb_cb.reset<=1; // for reset,mode,out we can use clocking block to check there directions.

#20 intf.tb_cb.reset<=0;
#200 $finish;
end

initial begin
   d_h=new(intf);// if we defined memory with handle used in virtual interface file then we need to write function block in vif_driver.sv file as there mentioned.
  // d_h.intf=intf;
   d_h.run();//task calling.
end
/* this mode selection block id transferred to the virtual interface driver*/

//initial begin
//   intf.tb_cb.mode<=1;
//   #100 intf.tb_cb.mode<=0;
//end

endmodule
