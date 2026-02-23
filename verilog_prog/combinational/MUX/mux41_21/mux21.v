module mux21 (input in0,in1,sel,
   output out);
//assign out = (~sel&in0)|(sel&in1)
//if (sel==0&&sel!=x&&sel!=z)
//   out=in0;
//else
//   out=in1;
assign out =sel?in1:in0;
endmodule
