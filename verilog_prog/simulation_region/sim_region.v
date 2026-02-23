module sim_region;
reg a,b,c;
wire d,e;
real r;
time t;
integer i;

initial begin
   $monitor($time,"the default value of reg:a=%b,b=%b,c=%b,t=%d",a,b,c,t);
   a=1;b=1;
   #10 a=3;c=1;
   #10 t="";
   //$monitor($time,"the default value of reg:a=%b,b=%b,c=%b",a,b,c);
end
endmodule
