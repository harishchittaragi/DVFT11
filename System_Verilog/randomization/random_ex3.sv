/* Using Constarints*/

class packet;
   rand bit [15:0] a [7:0];
   rand bit [5:0] b;
   rand bit [3:0] c;
// constraints are concurrent i.e. runs parallaly.
   //constraint a_c{a<10;}   //syntax should be like this only.
   //constraint a_c{a<10;a>5;}
   //constraint a_c{a==10;}
   //constraint b_c{b<5;}
   
   /* using inside operator */
  // constraint a_c{a inside { 2,4,5,6};}
  // constraint b_c{b<5;}
  
  /* all this three lines are same */ 
  //constraint a_c{a inside {[0:8]};}
  //constarint a_c{a inside {[0:4],6,7,[10 :15]};} // this ios one more type declaration
  //constraint a_c{a inside {0,1,2,3,4,5,6,7,8};}
  //constraint a_c{a<=8; a>=0}

   //constraint a_c{a inside {b};}  // a and b are same a dependant on b;
   //constraint b_c{b<5;}

   /* Using constarint solver*/
   //constraint a_c{a inside {b};}  // a and b are same a dependant on b;
   //constraint b_c{b<5;}
   //constraint solve_a_before_b { solve a before b;}
   //constraint solve_a_before_b { solve b before a;}
   
   /* implication operator
    - this is bidirectional 
       -- if constraint execute first a value then it will display b value with resepect to condition          on a and vice versa */
     // constraint a_c{b>=10 -> a==5;}
      /*a=22153  b=8  c=9
        a=62811  b=4  c=11
        a=5  b=5472  c=10
        a=42182  b=4  c=7
        a=29888  b=2  c=0
        a=64651  b=8  c=3
        a=5  b=17284  c=10
        a=17062  b=7  c=3
        a=53727  b=0  c=0
        a=29664  b=2  c=9
        a=46319  b=9  c=5
       a=20910  b=6  c=0
       a=23729   b=9  c=3
       a=22933   b=1  c=10
       a=50013  b=5  c=5
           V C S   S i m u l a t i o n   R e p o r t 
         */
      
        // as it is bidirectional so wee need to define solver as below
      //constraint solve_b_before_a{ solve b before a;}
      /*
       a=5  b=53549  c=9
       a=5  b=22246  c=11
       a=5  b=24705  c=10
       a=5  b=12706  c=7
       a=5  b=24612  c=0
       a=5  b=51382  c=3
       a=5  b=14408  c=10
       a=5  b=21372  c=3
       a=5  b=30658  c=0
       a=5  b=61485  c=9
       a=5  b=20223  c=5
       a=5  b=55140  c=0
       a=5  b=38460  c=3
       a=5  b=51869  c=10
       a=5  b=55146  c=5
                  V C S   S i m u l a t i o n   R e p o r t 
      * */

     /*   if else block */
    /*  constraint a_c { if (b>=10)
                            a==5;
                         else
                            a==0;} 
   
                              */

    /* using foreach loop
    * -  should create some array.    */
   /* constraint a_c{ foreach (a[i])
                          a[i]==i;}
                         */
     constraint a_c { foreach (a[i])
                        if (i%2==0)
                           a[i]==1;
                        else 
                           a[i]==0;} // this will assign 1 for even position and 0 for odd position.
                     
                     
endclass

module packet_ex();
packet p_h;

initial begin
   p_h=new();
   repeat(15) begin
      p_h.randomize(a);
      $display("a=%0p  b=%0d  c=%0d",p_h.a,p_h.b,p_h.c);
   end
end
endmodule

   


