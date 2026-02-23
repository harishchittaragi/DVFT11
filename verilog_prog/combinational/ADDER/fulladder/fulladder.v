module fulladder (
   input a,b,c,
   output sum,carry);
assign sum=a^b^c;
assign carry=(a&b)|(b&c)|(c&a);
endmodule

/* for compiling this code
 vcs -full64 -V  test_bench.v

* for running this code
 vcs -full64 -V -R test_bench.v

* for running this code &debugging and accesing all
 vcs -full64 -V -R -debud_access+all test_bench.v
 
* for running this code to see waveforms 
 ./simv -gui=dve */
