module oops;
class person;
   string name ;
   int age;

  // function new (string n,int a);
  //    name=n;
  //    age=a;
  // endfunction

   function void display();
      input string name;
      input int age;
      $display("Name=%s Age=%0d",name,age);
   endfunction
endclass

initial begin
   person p1,p2;
   p1=new();// new("Harish",22);
   p2=new(); //new("Hari",22);
   p1.display("Harish",22);
   p2.display("Hari",22);
end 
endmodule
