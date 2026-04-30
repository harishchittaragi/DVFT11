interface count_interface();
   logic clk;
   logic reset;
   logic [3:0]out;
   logic mode;

/* below is the clocking block where we can check with tesbench variable direction and remember the clock pin should be always universal so we cant call clk with cloking block it will be clear in testbench code*/
   clocking tb_cb @(posedge clk);
      input out;
      output clk,reset,mode;
   endclocking


   /* the below is the modport blocks where these blocks used by designers to
   * check there design variable directions if they drive any output variable
    * from there design then it will through an error same for tesbench also*/

   modport dut_mp (input clk,reset,mode,
                   output out); // designers modports

  // modport tb_mp (clocking tb_cb); // Testbenchers modports
endinterface
