`include "demux12.v"
module demux12_tb();
 reg a;
 reg s;
 wire y0,y1;
demux12 demux_inst(a,s,y0,y1);
initial 
 begin
    s=0;a=1;
    #10 s=0;a=0;
    #10 s=1;a=1;
    #10 s=1;a=0;
    #10 $finish;
 end
initial 
 begin
    $monitor($time,"The value of s=%b a=%b y0=%b y1=%b",s,a,y0,y1);
 end
endmodule
