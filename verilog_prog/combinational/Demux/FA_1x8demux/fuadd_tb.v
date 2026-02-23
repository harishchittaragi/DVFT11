`include "fulladder.v"
module fuadd_tb();
reg a,b,cin;
wire sum,cout;
 fulladder FA (.a(a),.sum(sum),.cout(cout), .b(b), .cin(cin));
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
    $monitor($time,  "a=%b b=%b cin=%b sum=%b cout=%b",a,b,cin,sum,cout);
 end
 endmodule
