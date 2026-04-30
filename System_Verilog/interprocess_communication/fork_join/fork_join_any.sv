module fork_join();
initial begin
   $display($time,"This is starting");
   fork 
     #1 $display($time,"Task1:");
     begin
     #1 $display($time,"Task2:");
     #1 $display($time,"Task3:");
     end
     #1 $display($time,"Task4:");
 // join_any
    join_none
  fork
     #1 $display($time,"Task5:");
     #1 $display($time,"Task6:");
  join
  $display($time,"This is the end");
end
endmodule
