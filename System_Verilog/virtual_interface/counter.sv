/* this is Design part where it includes with interface and modports connection
 - modports connection means all variables have correct direction with input and output terminals from design point of view*/

module counter(count_interface.dut_mp  intf);

always @(posedge intf.clk)
   if(intf.reset)
      intf.out<=0;
   else begin
      if (intf.mode)
         intf.out=intf.out+1;
      else
         intf.out=intf.out-1;
   end
endmodule

/* here the below code is not included with interface so this is pure design without interface*/

//module counter(input clk,reset,mode,output reg out);
//
//always @(posedge clk)
//   if(reset)
//      out<=0;
//   else begin
//      if (mode)
//         out=out+1;
//      else
//         out=out-1;
//   end
//endmodule
