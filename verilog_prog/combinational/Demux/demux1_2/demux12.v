module demux12 (input a,
                input s,
                output y0,y1);
assign y0=~s&a;
assign y1=s&a;
endmodule
