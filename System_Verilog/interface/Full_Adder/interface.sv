/*  thsi is interface section where we can declare all the variables, which
     will interconnet testbench and design.
    - if once we declared this interface section means then we call use this block many times only wi     th its module name followed by handles defined in respective testbech or rtl design modules / cl      asses. */
interface full_add_inter();
   logic a;
   logic b;
   logic cin;
   logic sum;
   logic carry;
endinterface
