module events();
event e;
initial begin 
   $display($time,"Before event occured");
   #10;
   ->e;
end

initial begin
   @(e)
   $display($time,"After event occured");
end
endmodule
