import uvm_pkg ::*;
`include "uvm_macros.svh"
`include "transaction.sv"
`include "consumer.sv"
`include "producer.sv"
`include "test.sv"

module tb();
initial 
   run_test("test");
endmodule:tb
/* NOTE:
*  here The port is declared for consumer and implementation port is declared
   for producer.
*  but in test class connection should happens from port to implemenatation
*  and the data flows from producer(imp) to consumer(port)
*  get method declared in producer and calling this in consumer class*/
