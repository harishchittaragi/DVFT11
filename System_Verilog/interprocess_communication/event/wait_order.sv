/* wait_order type events will display wether the defined order is correct or
 not, it completely based on the delays specified before events triggering and order of initial blocks specified in the module 
 
 NOTE: if all the events accured at 0th time means it will display order is incorrect always
    but it consist of some specifed delay for all the events like #10 for all then if we write order     sequencially the it will be correct or it is incorrect*/

module wait_order_ex();
event e1,e2,e3,e4;
initial begin
//  #10;
    #10;
   ->e1;
end

initial begin
  // #2;
    #10;
   ->e2;
end

initial begin
 //  #3;
     #10;
   ->e3;
end

initial begin
 //  #1;
    #10;
   ->e4;
end

initial begin
   wait_order(e1,e3,e2,e4)
   $display("Order is correct");
   else
      $display("Order is incorrect");
end
endmodule:wait_order_ex
