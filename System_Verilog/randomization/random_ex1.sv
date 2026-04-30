class packet;
  rand reg [15:0] addr;
  rand reg [7:0] data;
   function void display(reg [15:0] addr, reg [7:0] data);
      $display("addr=%0d  data=%0d",this.addr,this.data);
      $display("addr=%0d  data=%0d",addr,data);
   endfunction
endclass:packet

module random_ex();
 packet p_h;
 initial begin
    p_h=new();
    p_h.randomize();
    p_h.display(20,7);
 end
 endmodule

