module sem_ex();
semaphore sem;

task process_a();
#1;
sem.get(7);// it only execute based on number of keys available.
$display("[%0t]  The process a taken the keys",$time);
#5;
sem.put(5); //it can able to put back n number of keys.
$display("[%0t] The process_a returns the keys",$time);
endtask:process_a

task process_b();
//#1;
//sem.get(5);// it only execute based on number of keys available.
sem.try_get(10);
$display("[%0t] The process_b taken the keys",$time);
#10;
sem.put(5); //it can able to put back n number of keys.
$display("[%0t] The process_b returns the keys",$time);
endtask:process_b

task process_c();
//#1;
sem.get(6);// it only execute based on number of keys available.
$display("[%0t] The process_c taken the keys",$time);
#5;
sem.put(5); //it can able to put back n number of keys.
$display("[%0t] The process_c returns the keys",$time);
endtask:process_c

initial begin
   sem=new(1);
   fork
     process_a();
     process_c();
     process_b();
   join
end
endmodule
