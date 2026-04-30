class driver;
   packet p_h;
   mailbox mb;
   function new(mailbox mb);
      this.mb=mb;
   endfunction

   task drive();
      p_h=new();
      mb.get(p_h);
      p_h.display("Drive");
   endtask
endclass:driver

