`include "full_adder41.v"
module full_adder41_tb();
reg a,b,cin;
wire sum,cout;

full_adder41 fulladder_inst(.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout));
initial begin
       a=0;b=0;cin=0;
   #10 a=0;b=0;cin=1;
   #10 a=0;b=1;cin=0;
   #10 a=0;b=1;cin=1;
   #10 a=1;b=0;cin=0;
   #10 a=1;b=0;cin=1;
   #10 a=1;b=1;cin=0;
   #10 a=1;b=1;cin=1;
   #10 $finish;
end
initial begin
   $monitor($time,"The value of a=%b b=%b cin=%b sum=%b cout=%b",a,b,cin,sum,cout);
end
endmodule
