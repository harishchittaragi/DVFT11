`include "fulladder.v"
module full_tb;
reg a,b,c;
wire sum,carry;
fulladder f_inst (a,b,c,sum,carry);// instantiating with position based.
initial begin 
#10 a=0;b=0;c=0;
#10 a=0;b=0;c=1;
#10 a=0;b=1;c=0;
#10 a=0;b=1;c=1;
#10 a=1;b=0;c=0;
#10 a=1;b=0;c=1;
#10 a=1;b=1;c=0;
#10 a=1;b=1;c=1;
#10;$finish;// this finish should be mandatory else it will run infinitely.
end
//this monitor statement will execute whenever the values of difined variable
//inside this monitor statement will change.
initial begin
$monitor ("At Time=%0t The values of a=%d b=%d c=%d sum=%d carry=%d",$time,a,b,c,sum,carry);
end
endmodule
