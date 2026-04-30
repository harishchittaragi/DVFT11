module enum_ex();

enum{one=5,// here by default it starts from 0th index but if we mensioned like this 5 then it is the starting index of enum 
     two,
     three} e_type;

  initial begin
     e_type=0;// here we will define index values 
     $display(e_type.name());//it will simply display the above declared
     //index valued e_type
     e_type=6;
     $display(e_type.name());
     e_type=7;
     $display(e_type.name());
  end 
endmodule
