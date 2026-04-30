module tb();
//bit [3:0] wild;
logic [3:0] wild;

covergroup cg;
  // coverpoint wild;
  // coverpoint wild {bins w_bin = {[12:15]};}
 coverpoint wild {wildcard bins w_bin={4'bxx00,4'dx,4'bz};
                  wildcard ignore_bins w_ib={4'd0,4'd4};}
                // wildcard illegal_bins w_ilb={3};}

endgroup

initial begin 
cg cg_h=new();

//repeat(10) begin
//wild= $urandom_range(11,16);
wild=4'b0011;
cg_h.sample();
$display(wild);

#10 wild=4'b0000;
cg_h.sample();
$display(wild);

#10 wild=4'bzz00;
cg_h.sample();
$display(wild);

#10 wild=4'b1000;
cg_h.sample();
$display(wild);

#10 wild=4'b1100;
cg_h.sample();
$display(wild);
//end
end
endmodule
