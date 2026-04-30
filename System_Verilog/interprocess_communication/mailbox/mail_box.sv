module mail_box();
mailbox mb;
int a;
//string s;
initial begin
   mb=new();
   mb.put(100);
   mb.put(200);
   mb.try_put(300);
   mb.put(400);
   mb.put(500);
   mb.put(600);
   mb.put(700);
   mb.try_put("Harish");
   $display("The size of the mailbox is : %0d",mb.num());
   $display("The content inside the mailbox is %p",mb);
   mb.get(a);
   $display("Recieved =%0d",a);
   $display("The size of the mailbox is : %0d",mb.num());
   mb.try_get(a);
   $display("Recieved =%0d",a);
   $display("The size of the mailbox is : %0d",mb.num());
   mb.peek(a); 
   $display("Recieved =%0d",a);
   $display("The size of the mailbox is : %0d",mb.num());

   repeat(6) begin
   mb.get(a); 
   $display("Recieved =%0d",a);
   $display("The size of the mailbox is : %0d",mb.num());
   end
  // mb.get(a); 
  // $display("Recieved =%0d",a);
  // $display("The size of the mailbox is : %0d",mb.num());
  // mb.get(a);
  // $display("Recieved =%0d",a);
  // $display("The size of the mailbox is : %0d",mb.num());
  // mb.get(a);
  // $display("Recieved =%0d",a);
  // $display("The size of the mailbox is : %0d",mb.num());
  // mb.get(a);
  // $display("Recieved =%0d",a);
  // $display("The size of the mailbox is : %0d",mb.num());
  // mb.get(s);
  // $display("Recieved =%0d",a);
  // $display("The size of the mailbox is : %0d",mb.num());
end
endmodule
