module dynamic_array();
int a[];// shortint,longint,byte,bit are all possible
initial begin
   $display($time,"The size of dynamic array=%d",a.size());
   $display($time,"The content of dynamic array=%p",a);
   #10;
   a=new[5];
   $display($time,"The size of dynamic array=%d",a.size());
   $display($time,"The content of dynamic array=%p",a);
   a='{1,2,3,4,5};// line 7 and 10 are same only 7 will be overwritten in line 10.
   $display($time,"The size of dynamic array=%d",a.size());
   $display($time,"The content of dynamic array=%p",a);
   #20
   foreach(a[i])
      a[i]=i;
   $display($time,"The size of dynamic array=%d",a.size());
   $display($time,"The content of dynamic array=%p",a);
   
  
  // a.insert(2,10);      this is wrong method of inserting we cant able to
  //                      insert anything here
  // $display($time,"The size of dynamic array=%d",a.size());
  // $display($time,"The content of dynamic array=%p",a);
  
  
  a.delete();   // a.delete(2)   wrong method of deleting
   $display($time,"The size of dynamic array=%d",a.size());
   $display($time,"The content of dynamic array=%p",a);
  end
endmodule
   
