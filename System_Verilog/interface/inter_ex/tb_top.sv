`include "packet.sv"
`include "generator.sv"
`include "driver.sv"

module tb_top();
driver d_h;
generator g_h;
mailbox mb;

initial begin
   mb=new();
   d_h=new(mb);
   g_h=new(mb);
   g_h.gen();
   d_h.drive();
end
endmodule
