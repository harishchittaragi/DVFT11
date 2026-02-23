`include "full_adder.v"
module full_adder_tb();
reg a,b,cin;
wire sum,carry;

full_adder FA1 (.a(a),
                .b(b),
                .cin(cin),
                .sum(sum),
                .carry(carry));
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
   $monitor($time,"The value of a=%d b=%d cin=%d sum=%d carry=%d",a,b,cin,sum,carry);
end
endmodule
