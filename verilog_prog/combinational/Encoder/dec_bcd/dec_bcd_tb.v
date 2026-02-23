`include "dec_bcd.v"
module dec_bcd_tb();
reg [3:0] dec;
wire [3:0] bcd;

dec_bcd dec_bcd_inst (.dec(dec),.bcd(bcd));
initial begin
       dec=4'd0;
   #10 dec=4'd1;
   #10 dec=4'd2;
   #10 dec=4'd3;
   #10 dec=4'd4;
   #10 dec=4'd5;
   #10 dec=4'd6;
   #10 dec=4'd7;
   #10 dec=4'd8;
   #10 dec=4'd9;
   #10 $finish;
end
initial begin
   $monitor($time,"The value of dec=%d bcd=%b",dec,bcd);
end
endmodule
