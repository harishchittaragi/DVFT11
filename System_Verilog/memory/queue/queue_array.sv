module queue_array();
//int a [$];
int a [$:10];
initial begin 
   $display($time,"The size of a is ==%0d",$size(a));
   $display($time,"The content inside this is ==%p",a);
   #10;
   foreach (a[i])
      a[i]=i;
   $display($time,"The size of a is ==%0d",$size(a));
   $display($time,"The content inside this is ==%p",a);
   a.push_front(1);
   $display($time,"The size of a is ==%0d",$size(a));
   $display($time,"The content inside this is ==%p",a);
   a.push_front(2);
   $display($time,"The size of a is ==%0d",$size(a));
   $display($time,"The content inside this is ==%p",a);
   a.push_back(3);
   $display($time,"The size of a is ==%0d",$size(a));
   $display($time,"The content inside this is ==%p",a);
   a.push_back(4);
   $display($time,"The size of a is ==%0d",$size(a));
   $display($time,"The content inside this is ==%p",a);
   #10;
   a.insert(3,100);
   $display($time,"The size of a is ==%0d",$size(a));
   $display($time,"The content inside this is ==%p",a);
   #20;
   foreach (a[i])
      a[i]=i;
   $display($time,"The size of a is ==%0d",$size(a));
   $display($time,"The content inside this is ==%p",a);
   #10;
   a.delete(1);// here we need to gave index number inside paranthesis.
   $display($time,"The size of a is ==%0d",$size(a));
   $display($time,"The content inside this is ==%p",a);
   #10;
   a.pop_front();
   $display($time,"The size of a is ==%0d",$size(a));
   $display($time,"The content inside this is ==%p",a);
   a.pop_front();
   $display($time,"The size of a is ==%0d",$size(a));
   $display($time,"The content inside this is ==%p",a);
   a.pop_back();
   $display($time,"The size of a is ==%0d",$size(a));
   $display($time,"The content inside this is ==%p",a);
   a.pop_back();
   $display($time,"The size of a is ==%0d",$size(a));
   $display($time,"The content inside this is ==%p",a);
   
end
endmodule
