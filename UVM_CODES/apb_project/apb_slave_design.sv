//**********************************************
/*
   DESIGN BY CHIPEDGE TECHNOLOGIES PVT LTD

*/
//**********************************************
module apb_slave(apb_interface dif);

  logic [31:0] mem [0:256];
  logic [1:0] apb_st;
  const logic [1:0] SETUP=0;
  const logic [1:0] W_ENABLE=1;
  const logic [1:0] R_ENABLE=2;
  reg                busy_rand_enable = 1; //enable random busy
  integer            busy_min         = 0; //min busy cycles
  integer            busy_max         = 5; //max busy cycles
  integer            busy_delay       = 1; //fixed delay for
   reg               err_enable       = 1;
   reg [31:0] err_addr = {32{1'b1}};       //error address
  
   reg [3:0]      ctl_reg;    // profile, blink_red, blink_yellow, mod_en RW
   reg [1:0]      stat_reg;   // state[1:0] 
   reg [31:0]     timer_0;    // timer_g2y[31:20], timer_r2g[19:8], timer_y2r[7:0] RW
   reg [31:0]     timer_1;    // timer_g2y[31:20], timer_r2g[19:8], timer_y2r[7:0] RW

   reg [31:0]     data_in;
   reg [31:0]     rdata_tmp;

   // Set all registers to default values
  always @ (posedge dif.pclk) begin
    if (!dif.presetn) begin
         data_in  <= 0;
         ctl_reg  <= 0; 
         stat_reg <= 0; 
         timer_0  <= 32'hcafe_1234; 
         timer_1  <= 32'hface_5678;
      end
   end


   // Provide read data
   always @ (dif.penable) begin
      if (dif.psel & !dif.pwrite) 
         case (dif.paddr)
            'h0 : rdata_tmp <= ctl_reg;
            'h4 : rdata_tmp <= timer_0;
            'h8 : rdata_tmp <= timer_1;
            'hc : rdata_tmp <= stat_reg;
         endcase
   end

  
   always@(posedge dif.pclk) begin
   	dif.pslverr   <= err_enable && (dif.paddr == err_addr);
    
   end
   
   initial 
      begin
            if ($test$plusargs("zerowaitstate"))begin   //argument to disable wait states
                   busy_rand_enable = 0;
                   busy_delay       = 0;
                end
      end

   always @(negedge dif.pclk)
     begin
        #1ps;
        if (dif.psel)
          begin
             if (busy_rand_enable)
               begin
                  busy_delay = $urandom_range(busy_min, busy_max);
               end
             if (busy_delay > 0)
               begin
                  dif.pready = 1'b0;
                  repeat (busy_delay)
                    begin
                      @(posedge dif.pclk); 
                    end
                  dif.pready = 1'b1;
                 @(posedge dif.pclk); 
               end
          end
     end


   task set_random_delay;
      input [31:0] delay_min;
      input [31:0] delay_max;
      begin
         busy_rand_enable = 1;
         busy_min = delay_min;
         busy_max = delay_max;
      end
   endtask

   task set_fixed_delay;
      input [31:0] delay;
      begin
         busy_rand_enable = 0;
         busy_delay = delay;
      end
   endtask

   task set_slverr;
      input [31:0] addr;
      begin
         err_enable = 1;
         err_addr = addr;
      end
   endtask

  always @(posedge dif.pclk or negedge dif.presetn) begin
//    $display("inside dut %0d %0d",dif.paddr,dif.pwdata);
    if (dif.presetn==0) begin
      apb_st <=0;
      dif.prdata <=0;
      dif.pready <=1;
      for(int i=0;i<256;i++) mem[i]=i;
    end
    else begin
      case (apb_st)
        SETUP: begin
          dif.prdata <= 0;
          if (dif.psel && !dif.penable) begin
            if (dif.pwrite) begin
              apb_st <= W_ENABLE;
            end
            else begin
              apb_st <= R_ENABLE;
            end
          end
        end
        W_ENABLE: begin

    $display("inside dut %0d %0d",dif.paddr,dif.pwdata);
	 if(dif.pready) begin
          if (dif.psel && dif.penable && dif.pwrite) begin
            if((dif.paddr == 'h0) || 
               (dif.paddr == 'h4) ||
               (dif.paddr == 'h8) ||
               (dif.paddr == 'hC) ) begin
              case (dif.paddr)
               'h0   : ctl_reg  <= dif.pwdata;
               'h4   : timer_0  <= dif.pwdata;
               'h8   : timer_1  <= dif.pwdata;
               'hc   : stat_reg <= dif.pwdata;
              endcase
            end else begin
            mem[dif.paddr] <= dif.pwdata;
            end
          end
          apb_st <= SETUP;
         end
         else begin
         apb_st <= W_ENABLE;
         end
        end
        R_ENABLE: begin
          if(dif.pready) begin
          apb_st <= SETUP;
	     if((dif.paddr == 'h0) || 
               (dif.paddr == 'h4) ||
               (dif.paddr == 'h8) ||
               (dif.paddr == 'hC) ) begin
	    mem[dif.paddr] <= rdata_tmp;
            end else begin
          dif.prdata <= mem[dif.paddr];
          end
          end
	  else begin
         apb_st <= R_ENABLE;
         end
        end
     endcase
    end
  end
  
endmodule
