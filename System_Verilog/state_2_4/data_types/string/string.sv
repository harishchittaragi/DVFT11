module string_ex();
string str1;
string str2;
string str3;
reg b;
string str4;
string str5;
string str6;
string str7;
string str8;

initial begin
   str1=" ";
   str2="Harish";
   str3="Chittaragi";
   
   $display($time,"str1=%s",str1);
   $display($time,"str2=%s",str2);
   $display($time,"str3=%s",str3);
   if (str1!=str2)// ==,!=
      $display("yes Equal");
   else
      $display("No");
    
   b=str1<=str3;// < > <= >=
   $display("b=%b",b);
   
   str4={str2,str1, str3};
   $display($time,"str4=%s",str4);
  #10; 
   str5={10{str2,str1}};
   $display($time,"str5=%s",str5);
   $display($time,"str2=%0d",str2.len());
   #1;
  // str6=str2.putc(1,"e");
   //$display($time,"str6=%0d",str6);
   $display($time,"str2=%s",str2.getc(0));
   $display($time,"str2=%s",str2.toupper());
   $display($time,"str2=%s",str2.tolower());
   $display($time,"str2=%0d",str2.compare("S"));
   $display($time,"str2=%0d",str2.icompare("h"));
   


end
endmodule

