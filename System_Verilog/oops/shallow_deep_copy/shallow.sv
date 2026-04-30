class one;
   int a;
   logic l;
endclass

class two;
   one v1,v2;// we can call variables in this class directly,
   int a;
   logic l;
   function new();
      v1=new(); //defining objects.
   endfunction
endclass

module shallow();
two t1,t2;
initial begin
   t1=new();
   t1.a=10;
   t1.l=1;
   t1.v1.a=15;
   t1.v1.l=0;
   $display("t1.a=%0d t1.l=%0d t1.v1.a=%0d t1.v1.l=%0d",t1.a,t1.l,t1.v1.a,t1.v1.l);

   t2=new t1; // this will create new memory for t2 and will assign the values of t1 but alters only               agregated memory space  //shallow copy if we define it like t2=t1 then simply t1&t2 han               dler direct to the same memory
   t2.a=100;
   t2.l=1'bx;
   t2.v1.a=155;
   t2.v1.l=1'bz;
   $display("t2.a=%0d t2.l=%0d t2.v1.a=%0d t2.v1.l=%0d",t2.a,t2.l,t2.v1.a,t2.v1.l);
   $display("t1.a=%0d t1.l=%0d t1.v1.a=%0d t1.v1.l=%0d",t1.a,t1.l,t1.v1.a,t1.v1.l);

end
endmodule


