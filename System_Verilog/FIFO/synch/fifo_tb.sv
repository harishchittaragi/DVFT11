`include "fifo.sv"
module fifo_tb();
parameter FIFO_DEPTH=8;
parameter DATA_WIDTH=32;
 reg clk=0;
 reg rst_n;
 reg cs;
 reg wr_en;
 reg rd_en;
 reg [DATA_WIDTH-1:0] data_in;
 wire [DATA_WIDTH-1:0] data_out;
 wire full;
 wire empty;
 integer i;
fifo 
#(.FIFO_DEPTH(FIFO_DEPTH),.DATA_WIDTH(DATA_WIDTH))
dut (.clk(clk),.rst_n(rst_n),.cs(cs),.wr_en(wr_en),.rd_en(rd_en),.data_in(data_in),.data_out(data_out),.full(full),.empty(empty));

always begin #5 clk=~clk; end

task write_data(input[DATA_WIDTH-1:0]d_in);
begin 
@( posedge clk)
cs=1;wr_en=1;
data_in=d_in;
$display($time,"Write Data Data_in=%0d",data_in);
@(posedge clk);
cs=1;wr_en=0;
end
endtask

task read_data();
begin
   @(posedge clk);
   cs=1;rd_en=1;
   @ (posedge clk)
   $display($time,"Read_data data_out=%0d", data_out);
   cs =1;rd_en=0;
end
endtask

//create Stimulus
initial begin
   #1;
   rst_n=0;rd_en=0;wr_en=0;
   @(posedge clk)
   rst_n=1;
   $display($time, "\n SCENARIO 1");
   write_data(1);
   write_data(10);
   write_data(100);
   read_data();
   read_data();
   read_data();

   $display($time, "\n SCENARIO 2");
   for (i=0;i<FIFO_DEPTH;i=i+1) begin
      write_data(2**i);
      read_data();
   end

   $display($time, "\n SCENARIO 3");
   for (i=0;i<FIFO_DEPTH;i=i+1) begin
      write_data(2**i);
   end

   
   for (i=0;i<FIFO_DEPTH;i=i+1) begin
      read_data();
   end
   #40 $finish;
end

endmodule
