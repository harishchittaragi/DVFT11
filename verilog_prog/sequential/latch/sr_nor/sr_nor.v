module sr_nor(input s,r,
   output q,q_bar);
nor (q,s,q_bar);
nor (q_bar,r,q);
endmodule
