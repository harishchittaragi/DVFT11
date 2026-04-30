module events();
event e1;

   task display1();
      #5;
      $display("[%0t] before event e1 triggering",$time);
      #10;
      -> e1;
      //->>e1;// non-blocking event triggering at NBA region
      $display("[%0t] e1 triggered",$time);
   endtask:display1

   task display2();
      #0;
      $display("[%0t] waiting for e1 triggering",$time);
      //@e1;// edge triggered 
      wait(e1.triggered); // level triggered
      $display("[%0t] e1 triggered and event occurs",$time);
   endtask:display2


initial begin
 fork
    display1();
    display2();
 join
end
 endmodule:events

    
