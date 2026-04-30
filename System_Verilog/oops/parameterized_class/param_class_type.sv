class parent #(type n=int);
function display(n n_h);
   /*here n is a dtatype passing from module but bydefault it is defined as int                         type  in line 1 now n_h is variable value will be assigned from module functon calling. */
   $display("The Value of n_h=%s",n_h);
endfunction
endclass

//module type_class();
//parent #(string) p_h;/* this will define in which format the output will execute passed to function d                         efined in class as (n n_h) */
//
//initial begin
//   p_h=new();
//   p_h.display(65);/* passing value 65 to the function defined in class*/
//end */
 module type_class();
 typedef parent p_h_int;            // here p_h_int is a new datatype we defined.
 typedef parent #(string) p_h_string;          // p_h_string is a new datatype we defined. and it ias                                                of string type defined as #(string).
 p_h_int a,b,c;                    // new variable assigned to declared data type. 
 p_h_string s1,s2,s3;              // new variable assigned to declared data type.
 initial begin
    a=new();
    b=new();
    c=new();
    s1=new();
    s2=new();
    s3=new();
    a.display(65);
    b.display(66);
    c.display(68);
    s1.display("Harish");
    s2.display("Hari");
    s3.display("Name");
 end
       
endmodule
