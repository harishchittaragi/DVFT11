module mux21 (input a0,a1,sel,
   output out);
//assign out = (~sel&a0)|(sel&a1)
//if (sel==0&&sel!=x&&sel!=z)
//   out=a0;
//else
//   out=a1;
assign out =sel?a1:a0;
endmodule
