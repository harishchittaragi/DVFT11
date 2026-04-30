class generator;
   packet p_h;
   mailbox mb;

   function new(mailbox mb);
      this.mb=mb;
   endfunction

   task gen ();
      p_h=new();
      p_h.randomize();
      mb.put(p_h);
      p_h.display("Gen");
   endtask:gen
endclass:generator
