module associative_array();
int a [int];// int a[string],string a[int],string a [string].

initial begin
   $display($time,"The size of associative array=%d",a.size());
   $display($time,"The content of associative array=%p",a);
   #10;
   a[2]=5;
   $display($time,"The size of associative array=%d",a.size());
   $display($time,"The content of associative array=%p",a);
   
   // a='{1,2,3,4,5};// impossible to assign values like this
   
   #20;
   foreach(a[i])
      a[i]=i;
   $display($time,"The size of associative array=%d",a.size());
   $display($time,"The content of associative array=%p",a);
  #10; 
  
  // a.insert(2,10);     // this is wrong method of inserting we cant able to
                      //  insert anything here
  // $display($time,"The size of associative array=%d",a.size());
  // $display($time,"The content of associative array=%p",a);
  //#30;
  
  a.delete();   // a.delete(2)   wrong method of deleting
   $display($time,"The size of associative array=%d",a.size());
   $display($time,"The content of associative array=%p",a);
  end
endmodule

