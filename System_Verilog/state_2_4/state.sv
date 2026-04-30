module state();
realtime a;//reg,integer=32bit,(time,real,realtime=64bit)
longint b;// bit=1bit byte=8bit shortint=16bit int=32bit longint=64bit 
initial begin
   a=1'bx;b=1'bx;
   $display("reg a=%b and B=%b",a,b);
   a=1'b1;b=1'bz;
   $display("reg a=%b and B=%b",a,b);
   a=1'bx;b=1'b1;
   $display("reg a=%b and B=%b",a,b);
   a=1'bx;b=1'b0;
   $display("reg a=%b and B=%b",a,b);
end
endmodule
