class packet;
   rand int addr;
   rand int data;
        int wdata;

function  void display(string name);
   $display("[%s]  addr=%0d data=%0d wdata=%0d",name,addr,data,wdata);
endfunction:display

endclass:packet
