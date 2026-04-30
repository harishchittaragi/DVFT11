/* In this Parameterized_class we need define parameter as per below and we
* can gave value through module.
   * */
class parent #(int n);// here declaring parameter for class
   int a=0;
   function int count();
      do begin
         a=a+1;
         $display("the value of a=%0d",a);
         end 
         while(a<n);
    endfunction
endclass

module param_class();
parent #(10) p_h; // giving value of n from module to class.
initial begin
   p_h=new();
   p_h.count();
end
endmodule

