`include "fifo.sv"
module fifo_tb();

parameter FIFO_DEPTH = 8;
parameter DATA_WIDTH = 32;

reg clk = 0;
reg rst_n;
reg cs;
reg wr_en;
reg rd_en;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;
wire full;
wire empty;
integer i;

// ----------------------------------------------------------------
// DUT Instantiation
// ----------------------------------------------------------------
fifo #(.FIFO_DEPTH(FIFO_DEPTH), .DATA_WIDTH(DATA_WIDTH))
dut (
   .clk(clk), .rst_n(rst_n), .cs(cs),
   .wr_en(wr_en), .rd_en(rd_en),
   .data_in(data_in), .data_out(data_out),
   .full(full), .empty(empty)
);

always begin #5 clk = ~clk; end

// ================================================================
// COVERGROUP 1: Individual signal coverage (sampled explicitly)
// ================================================================
covergroup fifo_signal_cg;

   // Write enable coverage
   cp_wr_en : coverpoint wr_en {
      bins wr_active   = {1};
      bins wr_inactive = {0};
   }

   // Read enable coverage
   cp_rd_en : coverpoint rd_en {
      bins rd_active   = {1};
      bins rd_inactive = {0};
   }

   // Chip select coverage
   cp_cs : coverpoint cs {
      bins cs_active   = {1};
      bins cs_inactive = {0};
   }

   // FIFO full flag coverage
   cp_full : coverpoint full {
      bins fifo_full     = {1};
      bins fifo_not_full = {0};
   }

   // FIFO empty flag coverage
   cp_empty : coverpoint empty {
      bins fifo_empty     = {1};
      bins fifo_not_empty = {0};
   }

   // Cross: write enable vs full -- catches write-when-full scenario
   cx_wr_full : cross cp_wr_en, cp_full {
      bins write_normal    = binsof(cp_wr_en.wr_active)   && binsof(cp_full.fifo_not_full);
      bins write_when_full = binsof(cp_wr_en.wr_active)   && binsof(cp_full.fifo_full);
      bins no_write        = binsof(cp_wr_en.wr_inactive);
   }

   // Cross: read enable vs empty -- catches read-when-empty scenario
   cx_rd_empty : cross cp_rd_en, cp_empty {
      bins read_normal     = binsof(cp_rd_en.rd_active)   && binsof(cp_empty.fifo_not_empty);
      bins read_when_empty = binsof(cp_rd_en.rd_active)   && binsof(cp_empty.fifo_empty);
      bins no_read         = binsof(cp_rd_en.rd_inactive);
   }

   // Cross: simultaneous write and read (both enabled at same time)
   cx_wr_rd : cross cp_wr_en, cp_rd_en {
      bins wr_only   = binsof(cp_wr_en.wr_active)   && binsof(cp_rd_en.rd_inactive);
      bins rd_only   = binsof(cp_wr_en.wr_inactive) && binsof(cp_rd_en.rd_active);
      bins wr_and_rd = binsof(cp_wr_en.wr_active)   && binsof(cp_rd_en.rd_active);
      bins neither   = binsof(cp_wr_en.wr_inactive) && binsof(cp_rd_en.rd_inactive);
   }

endgroup // fifo_signal_cg

// ================================================================
// COVERGROUP 2: Data pattern coverage (sampled explicitly)
// ================================================================
covergroup fifo_data_cg;

   // data_in value range coverage
   cp_data_in : coverpoint data_in {
      bins zero    = {0};
      bins low     = {[1:255]};
      bins mid     = {[256:65535]};
      bins high    = {[65536:32'hFFFFFFFE]};
      bins max_val = {32'hFFFFFFFF};
   }

   // data_out value range coverage
   cp_data_out : coverpoint data_out {
      bins zero    = {0};
      bins low     = {[1:255]};
      bins mid     = {[256:65535]};
      bins high    = {[65536:32'hFFFFFFFE]};
      bins max_val = {32'hFFFFFFFF};
   }

endgroup // fifo_data_cg

// ================================================================
// COVERGROUP 3: State transition coverage (clocked, auto-sampled)
// ================================================================
covergroup fifo_state_cg @(posedge clk);

   // Reset state
   cp_rst : coverpoint rst_n {
      bins in_reset     = {0};
      bins out_of_reset = {1};
   }

   // Full flag transitions
   cp_full_trans : coverpoint full {
      bins becomes_full  = (0 => 1);
      bins becomes_nfull = (1 => 0);
      bins stays_full    = (1 => 1);
      bins stays_nfull   = (0 => 0);
   }

   // Empty flag transitions
   cp_empty_trans : coverpoint empty {
      bins becomes_empty  = (0 => 1);
      bins becomes_nempty = (1 => 0);
      bins stays_empty    = (1 => 1);
      bins stays_nempty   = (0 => 0);
   }

   // Cross: full and empty transitions together
   cx_full_empty_trans : cross cp_full_trans, cp_empty_trans;

endgroup // fifo_state_cg

// ================================================================
// Instantiate all covergroups
// ================================================================
fifo_signal_cg  signal_cg = new();
fifo_data_cg    data_cg   = new();
fifo_state_cg   state_cg  = new();  // auto-sampled @posedge clk

// ================================================================
// TASK: sample_coverage -- call after every meaningful operation
// ================================================================
task sample_coverage();
begin
   signal_cg.sample();
   data_cg.sample();
   // state_cg is auto-sampled @posedge clk, no explicit call needed
end
endtask

// ================================================================
// TASK: write_data -- with FULL detection + coverage sampling
// ================================================================
task write_data(input [DATA_WIDTH-1:0] d_in);
begin
   @(posedge clk);
   cs      = 1;
   wr_en   = 1;
   data_in = d_in;

   if (full) begin
      $display("ERROR: WRITE_WHEN_FULL | attempted_data=%0d | time=%0t", d_in, $time);
      sample_coverage();   // capture write_when_full cross bin
      cs    = 1;
      wr_en = 0;
   end else begin
      if (dut.write_pointer + 1 == {~dut.write_pointer[$clog2(FIFO_DEPTH)],
                                     dut.write_pointer[$clog2(FIFO_DEPTH)-1:0]}) begin
         $display("INFO: WRITE | data=%0d | time=%0t", d_in, $time);
         sample_coverage();
         @(posedge clk);
         cs    = 1;
         wr_en = 0;
         $display("INFO: FIFO FULL at time %0t", $time);
         sample_coverage();   // capture full=1 after write completes
      end else begin
         $display("INFO: WRITE | data=%0d | time=%0t", d_in, $time);
         sample_coverage();
         @(posedge clk);
         cs    = 1;
         wr_en = 0;
      end
   end
end
endtask

// ================================================================
// TASK: read_data -- with EMPTY detection + coverage sampling
// ================================================================
task read_data();
begin
   @(posedge clk);
   cs    = 1;
   rd_en = 1;

   if (empty) begin
      $display("ERROR: READ_WHEN_EMPTY | time=%0t", $time);
      sample_coverage();   // capture read_when_empty cross bin
      cs    = 1;
      rd_en = 0;
   end else begin
      @(posedge clk);
      $display("INFO: READ | data=%0d | time=%0t", data_out, $time);
      sample_coverage();   // capture after data available on output
      cs    = 1;
      rd_en = 0;
      if (empty) begin
         $display("INFO: FIFO EMPTY at time %0t", $time);
         sample_coverage();  // capture empty=1 after last read
      end
   end
end
endtask

// ================================================================
// TASK: force_write_when_full -- error injection + coverage
// ================================================================
task force_write_when_full(input [DATA_WIDTH-1:0] d_in);
begin
   @(posedge clk);
   cs      = 1;
   wr_en   = 1;
   data_in = d_in;
   if (full)
      $display("ERROR: WRITE_WHEN_FULL | attempted_data=%0d | time=%0t", d_in, $time);
   else
      $display("WARNING: FIFO was not full when force-write attempted | time=%0t", $time);
   sample_coverage();   // capture write_when_full cross bin
   @(posedge clk);
   cs    = 1;
   wr_en = 0;
end
endtask

// ================================================================
// TASK: force_read_when_empty -- error injection + coverage
// ================================================================
task force_read_when_empty();
begin
   @(posedge clk);
   cs    = 1;
   rd_en = 1;
   if (empty)
      $display("ERROR: READ_WHEN_EMPTY | time=%0t", $time);
   else
      $display("WARNING: FIFO was not empty when force-read attempted | time=%0t", $time);
   sample_coverage();   // capture read_when_empty cross bin
   @(posedge clk);
   cs    = 1;
   rd_en = 0;
end
endtask

// ================================================================
// TASK: print_coverage -- display summary at end of simulation
// ================================================================
task print_coverage();
begin
   $display("\n============================================");
   $display("  FUNCTIONAL COVERAGE REPORT");
   $display("============================================");
   $display("  fifo_signal_cg  coverage : %0.2f%%", signal_cg.get_coverage());
   $display("  fifo_data_cg    coverage : %0.2f%%", data_cg.get_coverage());
   $display("  fifo_state_cg   coverage : %0.2f%%", state_cg.get_coverage());
   $display("  TOTAL coverage           : %0.2f%%",
      (signal_cg.get_coverage() + data_cg.get_coverage() + state_cg.get_coverage()) / 3.0);
   $display("============================================\n");
end
endtask

// ================================================================
// STIMULUS
// ================================================================
initial begin
   #1;
   rst_n = 0; rd_en = 0; wr_en = 0; cs = 0;
   @(posedge clk);
   sample_coverage();   // sample reset state (rst_n=0, empty=1)
   rst_n = 1;
   @(posedge clk);
   sample_coverage();   // sample post-reset / empty state

   // ----------------------------------------------------------
   $display("\n===== SCENARIO 1: Basic Write then Read =====");
   // ----------------------------------------------------------
   write_data(10);
   write_data(15);
   write_data(100);
   read_data();
   read_data();
   read_data();

   // ----------------------------------------------------------
   $display("\n===== SCENARIO 2: Interleaved Write and Read =====");
   // ----------------------------------------------------------
   for (i = 0; i < FIFO_DEPTH; i = i + 1) begin
      write_data(2**i);
      read_data();
   end

   // ----------------------------------------------------------
   $display("\n===== SCENARIO 3: Fill FIFO completely then drain =====");
   // ----------------------------------------------------------
   for (i = 0; i < FIFO_DEPTH; i = i + 1) begin
      write_data(2**i);
   end
   for (i = 0; i < FIFO_DEPTH; i = i + 1) begin
      read_data();
   end

   // ----------------------------------------------------------
   $display("\n===== SCENARIO 4: ERROR -- Write when FIFO is FULL =====");
   // ----------------------------------------------------------
   for (i = 0; i < FIFO_DEPTH; i = i + 1) begin
      write_data(i + 50);
   end
   force_write_when_full(99);   // ERROR: WRITE_WHEN_FULL
   for (i = 0; i < FIFO_DEPTH; i = i + 1) begin
      read_data();
   end

   // ----------------------------------------------------------
   $display("\n===== SCENARIO 5: ERROR -- Read when FIFO is EMPTY =====");
   // ----------------------------------------------------------
   force_read_when_empty();     // ERROR: READ_WHEN_EMPTY
   force_read_when_empty();     // second consecutive empty read

   // ----------------------------------------------------------
   $display("\n===== SCENARIO 6: Boundary -- Single write and read =====");
   // ----------------------------------------------------------
   write_data(42);
   read_data();
   force_read_when_empty();     // empty after last read

   // ----------------------------------------------------------
   $display("\n===== SCENARIO 7: Max and zero value data patterns =====");
   // ----------------------------------------------------------
   write_data(32'hFFFFFFFF);    // max value  --> hits max_val bin in data_cg
   read_data();
   write_data(32'h00000000);    // zero value --> hits zero bin in data_cg
   read_data();
   write_data(32'h0000ABCD);    // mid range  --> hits mid bin in data_cg
   read_data();

   // ----------------------------------------------------------
   print_coverage();
   // ----------------------------------------------------------

   #40;
   $display("\n===== SIMULATION COMPLETE =====");
   $finish;
end

endmodule