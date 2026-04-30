`include "full_add.v"
`include "interface.sv"
module tb_top();
full_add_inter fad();// intreface module assigned with handle.
//reg a,b,cin;
//wire sum,carry;
//full_add FA1(.a(a),.b(b),.cin(cin),.sum(sum),.caarry(carry));
full_add FA1 (fad); //using handle  we can connect ports to the dut through interface.

initial begin 
       fad.a=0;fad.b=0;fad.cin=0;
   #10 fad.a=0;fad.b=0;fad.cin=1;
   #10 fad.a=0;fad.b=1;fad.cin=0;
   #10 fad.a=0;fad.b=1;fad.cin=1;
   #10 fad.a=1;fad.b=0;fad.cin=0;
   #10 fad.a=1;fad.b=0;fad.cin=1;
   #10 fad.a=1;fad.b=1;fad.cin=0;
   #10 fad.a=1;fad.b=1;fad.cin=1;
end

initial begin
   $monitor("[%0t] a=%0d b=%0d cin=%0d sum=%0d carry=%0d",$time,fad.a,fad.b,fad.cin,fad.sum,fad.carry);
end
endmodule
