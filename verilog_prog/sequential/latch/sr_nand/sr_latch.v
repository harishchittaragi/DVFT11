module sr_latch(input s_bar,r_bar,
                output q,q_bar);
nand (q,r_bar,q_bar);
nand (q_bar, s_bar,q);
endmodule


//module sr_latch (input r,s,
//                 output q,q_bar);
//wire y1,y2;
//assign y1=~r;
//assign y2=~s;
//nand (q,y2,q_bar);
//nand (q_bar,y1,q);
//endmodule
