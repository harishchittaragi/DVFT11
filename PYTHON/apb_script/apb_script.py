#******************************************************************
# AUTHOR NAME : Harish Ramanna Chittaragi
# Batch       : DVFT11
# E-Mail      : chittaragiharish@gmail.com
# Description : This is PYTHON SCRIPT for APB_PROJECT files
#******************************************************************

# file mapping when you press any of the following number in terminal it will create only that files.
file_map = {
        0: ("ALL FILES", "all"),
        1: ("apb_transaction.sv", "apb_transaction"),
        2: ("apb_generator.sv",   "apb_generator"),
        3: ("apb_driver.sv",      "apb_driver"),
        4: ("apb_monitor.sv",     "apb_monitor"),
        5: ("apb_scoreboard.sv",  "apb_scoreboard"),
        6: ("apb_env.sv",         "apb_env"),
        7: ("apb_test.sv",        "apb_test"),
        8: ("apb_top.sv",         "apb_top"),
        9: ("apb_interface.sv",   "apb_interface"),
}

print("\n======= APB FILE GENERATOR ===========")
for num,(fname,_) in file_map.items():
    print(f" {num}. {fname}")

raw = input("\nEnter file number(s) to generate (e.g. 1 3 5): ")
choices = list(map(int, raw.split()))

if 0 in choices:
    choices = [1, 2, 3, 4, 5, 6, 7, 8, 9] # expand to all files

#*****************************************************************************
import os
# APB_PROJECT files all in one directory path is:
path="/home/dvft1103/dvft11/systemverilog/apb_project/"
os.makedirs(path,exist_ok=True)

#********************** TRANSACTION CLASS*********************
if 1 in choices:
    with open("apb_transaction.sv","w") as tr:
        tr.writelines(['//***************************************//\n'
                   '//Author:"write Your name here"\n'
                   '//E-Mail:  \n'
                   '//Description:This is apb_transaction file \n'
                   '//Date: \n'
                   '//**************************************//\n'

                   '\n`ifndef _APB_TRANSACTION\n'
                   '`define _APB_TRANSACTION\n'
                   'typedef enum logic[1:0] {\n'
                   "\t\tIDLE=2'b00,\n"
                   "\t\tSETUP=2'b01,\n"
                   "\t\tACCESS=2'b10\n"
                   '\t\t} apb_state_e;\n'
                   '\nclass apb_transaction;\n'
                   '\n\t\tbit       psel;\n'
                   '\t\tbit       penable;\n'
                   '\t\tbit       pwrite;\n'
                   '\t\tbit       pslverr;\n'
                   '\t\tbit       pready;\n'
                   '\t\tbit[31:0] paddr;\n'
                   '\t\tbit[31:0] pwdata;\n'
                   '\t\tbit[31:0] prdata;\n'
                   '\t\tapb_state_e apb_state;\n'
                   '\n\t\tconstraint c_paddr {soft paddr inside {[0:255]};}\n'
                   '\n\t\tfunction void display(string name);\n'
                   '\t\t\t$display("[%0t] [%0s] paddr=%0d pwrite=%0b pwdata=%0d prdata=%0d pslverr=%0b",\n'
                   '\t\t\t\t$time,name,paddr,pwrite,pwdata,prdata,pslverr);\n'
                   '\t\tendfunction:display\n'
                   'endclass:apb_transaction\n'
                   '`endif'
                   ])
    tr.close()
    print(" [OK] apb_transaction.sv file is created in provided path")
#---------------------------------------------------------------

#********************** GENERATOR CLASS **********************
if 2 in choices:
    with open("apb_generator.sv","w") as gen:
        gen.writelines(['//***************************************//\n'
                   '//Author:"write Your name here"\n'
                   '//E-Mail:  \n'
                   '//Description:This is apb_generator file \n'
                   '//Date: \n'
                   '//**************************************//\n'

                   '\n`ifndef _APB_GENERATOR\n'
                   '`define _APB_GENERATOR\n'
                   'class apb_generator;'
                   '\tapb_transaction packet;\n'
                   '\tmailbox gen_drv;\n'
                   '\tint count;\n'
                   '//\tdeclare local variable here as per you test logics\n'
                   '\n\tfunction new(mailbox gen_drv);\n'
                   '\t\tthis.gen_drv=gen_drv;\n'
                   '\tendfunction:new\n'
                   '\n\ttask run();\n'
                   '\t\trepeat(count) begin\n'
                   '//\tuse if- else conditions to execute your test cases\n'
                   '\t\tend\n'
                   '\tendtask:run\n'
                   'endclass:apb_generator\n'
                   '`endif'
                   ])
    gen.close()
    print(" [OK] apb_generator.sv file is created in provided path")
#---------------------------------------------------------------

#************************** DRIVER CLASS ***********************
if 3 in choices:
    with open("apb_driver.sv","w") as dr:
        dr.writelines(['//***************************************//\n'
                   '//Author:"write Your name here"\n'
                   '//E-Mail:  \n'
                   '//Description:This is apb_interface file \n'
                   '//Date: \n'
                   '//**************************************//\n'

                   '\n`ifndef _APB_DRIVER\n'
                   '`define _APB_DRIVER\n'
                   'class apb_driver;\n'
                   '\n//  mailbox creating (generator - driver & reset timed packate collector)\n'
                   '\tmailbox gen_drv;\n'
                   '\tmailbox resume_drv;\n'
                   '\n//  virtual apb_interface handle creating\n'
                   '\tvirtual apb_interface vif;\n'
                   '\tapb_transaction transaction_h;//creating transaction handle\n'
                   '\n//  local variable used in driver logic\n'
                   '\tint wait_count;\n'
                   '\n//inside function new pass these two args :mailbox gen_drv, virtual apb_interface vif\n'
                   '\n\tfunction new(mailbox gen_drv, virtual apb_interface vif);\n'
                   '\t  this.vif = vif;\n'
                   '\t  this.gen_drv = gen_drv;\n'
                   '//\t    memory creation for transaction and resume_drv\n'
                   '\t  transaction_h = new();\n'
                   '\t  resume_drv = new(1);\n'
                   '\tendfunction:new\n'
                   '\n//    Reset logic code\n'
                   '\ttask reset_logic();\n'
                   '\t  do begin\n'
                   '\t   $display("Entered to reset logic");\n'
                   "\t   vif.master_cb.paddr   <= 32'b0;\n"
                   "\t   vif.master_cb.pwdata  <= 32'b0;\n"
                   "\t   vif.master_cb.psel    <= 1'b0;\n"
                   "\t   vif.master_cb.penable <= 1'b0;\n"
                   "\t   vif.master_cb.pwrite  <= 1'b0;\n"
                   '\t   @(vif.master_cb);\n'
                   '\t  end\n'
                   '\t  while(!vif.presetn || $isunknown(vif.presetn));\n'
                   '\tendtask:reset_logic\n'
                   '\n//    DRIVER LOGIC\n'
                   '\ttask driver_logic(apb_transaction transaction_h);\n'
                   '\t  transaction_h.display("drv");\n'
                   '\n\t// write proper driver here according to protocol\n'
                   '\n\n\tendtask:driver_logic\n'
                   '\n//    TASK RUN LOGIC\n'
                   '\ttask run();\n'
                   '\t  forever begin\n'
                   '\t\t @(vif.master_cb);\n'
                   '\t\t\tif(!vif.presetn || $isunknown(vif.presetn))\n'
                   '\t\t\t reset_logic();\n'
                   '\t\t\telse begin\n'
                   '\t\t\t if(resume_drv.num>0) begin\n'
                   '\t\t\t\tresume_drv.get(transaction_h);\n'
                   '\t\t\t\t$display("[DRV] resume saved in transaction after reset");\n'
                   '\t\t\t end\n'
                   '\t\t\t else begin\n'
                   '\t\t\t\tgen_drv.get(transaction_h);\n'
                   '\t\t\t end\n'
                   '\t\t\t driver_logic(transaction_h);\n'
                   '\t\tend\n'
                   '\t end\n'
                   '\tendtask\n'
                   'endclass:apb_driver\n'
                   '`endif'
                   ])
    dr.close()
    print(" [OK] apb_driver.sv file is created in provided path")
#---------------------------------------------------------------
#
#
#************************ MONITOR CLASS *************************
if 4 in choices:
    with open("apb_monitor.sv","w") as mon:
        mon.writelines(['//***************************************//\n'
                   '//Author:"write Your name here"\n'
                   '//E-Mail:  \n'
                   '//Description:This is apb_interface file \n'
                   '//Date: \n'
                   '//**************************************//\n'

                   '\n`ifndef _APB_MONITOR\n'
                   '`define _APB_MONITOR\n'
                   'class apb_monitor;\n'
                   '\tvirtual apb_interface vif;\n'
                   '\tmailbox mon_sb;\n'
                   '\tapb_transaction transaction_h;\n'
                   '\n//inside function new pass these two args :mailbox mon_sb, virtual apb_interface vif\n'
                   '\n\tfunction new(virtual apb_interface vif, mailbox mon_sb);\n'
                   '\t\ttransaction_h = new();\n'
                   '\t\tthis.vif      = vif;\n'
                   '\t\tthis.mon_sb   = mon_sb;\n'
                   '//\t\tcreate memory for covergroups\n'
                   '\tendfunction:new\n'

                   '\n//\twrite covergroups here\n'
                   '\tcovergroup apb_protocols_cg;\n'
                   '\t\tcp_psel : coverpoint vif.monitor_cb.psel {\n'
                   "\t\t\tbins psel_high = {1'b1};\n"
                   "\t\t\tbins psel_low  = {1'b0};\n"
                   '\t\t }\n'

                   '\n\t\tcp_penable : coverpoint vif.monitor_cb.penable {\n'
                   "\t\t\tbins penable_high = {1'b1};\n"
                   "\t\t\tbins penable_low  = {1'b0};\n"
                   '\t\t }\n'

                   '\n\t\tcp_pready : coverpoint vif.monitor_cb.pready {\n'
                   "\t\t\tbins pready_high = {1'b1};\n"
                   "\t\t\tbins pready_low  = {1'b0};\n"
                   '\t\t }\n'

                   '\n\t\tcp_pwrite : coverpoint transaction_h.pwrite {\n'
                   "\t\t\tbins pwrite_high = {1'b1};\n"
                   "\t\t\tbins pwrite_low  = {1'b0};\n"
                   '\t\t }\n'
                   
                   '\n\t\tcp_pslverr : coverpoint transaction_h.pslverr {\n'
                   "\t\t\tbins pslverr_high = {1'b1};\n"
                   "\t\t\tbins pslverr_low  = {1'b0};\n"
                   '\t\t }\n'

                   '\n//\t\tADDRESS & DATA\n'

                   '\t\tcp_addr : coverpoint transaction_h.paddr {\n'
                   "\t\t\tbins low_range = {[32'h0 : 32'h64]};\n"
                   "\t\t\tbins mid_range = {[32'h65 : 32'hC8]};\n"
                   "\t\t\tbins high_range = {[32'hC9 : 32'hFF]};\n"
                   '\t\t}\n'

                   '\n\t\tcp_pwdata : coverpoint transaction_h.pwdata {\n'
                   "\t\t\tbins low_range = {[32'h0000_0000 : 32'h0000_00FF]};\n"
                   "\t\t\tbins mid_range = {[32'h0000_0100 : 32'h0000_FFFF]};\n"
                   "\t\t\tbins high_range = {[32'h0001_0000 : 32'hFFFF_FFFF]};\n"
                   '\t\t}\n'

                   '\n\t\tcp_prdata : coverpoint transaction_h.prdata {\n'
                   "\t\t\tbins zero = {32'h0};\n"
                   "\t\t\tbins low_range = {[32'h1 : 32'h64]};\n"
                   "\t\t\tbins high_range = {[32'h65 : 32'hFF]};\n"
                   '\t\t}\n'

                   '\n\t\tcp_transfer : coverpoint transaction_h.pwrite {\n'
                   "\t\t\tbins read = {1'b0};\n"
                   "\t\t\tbins write = {1'b1};\n"
                   '\t\t}\n'

                   '\n\t\tcp_wait : coverpoint vif.monitor_cb.pready {\n'
                   "\t\t\tbins pready_wait = {1'b0};\n"
                   "\t\t\tbins pready_no_wait = {1'b1};\n"
                   '\t\t}\n'
                   '\tendgroup:apb_protocols_cg\n'

                   '\n//\tCoverages for apb_states\n'
                   '\tcovergroup apb_stae_cg;\n'
                   '\t\tcp_state : coverpoint transaction_h.apb_state {\n'
                   "\t\t\tbins idle_state = {2'b00};\n"
                   "\t\t\tbins setup_state = {2'b01};\n"
                   "\t\t\tbins access_state = {2'b10};\n"
                   '\t\t}\n'
                   '\t\tcp_state_transition : coverpoint transaction_h.apb_state {\n'
                   "\t\t\tbins idle_setup = (2'b00 => 2'b01);\n"
                   "\t\t\tbins setup_access = (2'b01 => 2'b10);\n"
                   "\t\t\tbins access_idle = (2'b10 => 2'b00);\n"
                   '\t\t}\n'
                   '\tendgroup\n'

                   '\n//\tHere write logic codde for monitor task run block\n'
                   '\ttask run();\n'
                   '\t\tforever begin\n'
                   '\t\t\tapb_protocols_cg.sample();\n'
                   '\n//write the task run code properly as per protocol\n'
                   '\n\n\n\n\t\tend\n'
                   '\tendtask:run\n'
                   'endclass:apb_monitor\n'
                   '`endif'
                   ])
    mon.close()
    print(" [OK] apb_monitor.sv file is created in provided path")
#---------------------------------------------------------------

#********************* SCOREBOARD CLASS ************************
if 5 in choices:
    with open("apb_scoreboard.sv","w") as sb:
        sb.writelines(['//***************************************//\n'
                   '//Author:"write Your name here"\n'
                   '//E-Mail:  \n'
                   '//Description:This is apb_scoreboard file \n'
                   '//Date: \n'
                   '//**************************************//\n'

                   '\n`ifndef _APB_SCOREBOARD\n'
                   '`define _APB_SCOREBOARD\n'
                   '\nclass apb_scoreboard;\n'
                   '\tmailbox mon_sb;\n'
                   '\tapb_transaction transaction_h;\n'
                   '\tbit[31:0] mem [bit[31:0]];\n'
                   '\n\tfunction new(mailbox mon_sb);\n'
                   '\t\tthis.mon_sb = mon_sb;\n'
                   '\tendfunction:new\n'
                   '\n\ttask run();\n'
                   '\t\tforever begin\n'
                   '\t\t  transaction_h=new();\n'
                   '\t\t  mon_sb.get(transaction_h);\n'
                   '\t\t  $display("[SB] Recieved packets");\n'
                   '//\t\t  write monitor logic here with proper display statements.\n'
                   '\t\tend\n'
                   '\tendtask:run\n'
                   'endclass:apb_scoreboard\n'
                   '`endif'
                   ])
    sb.close()
    print(" [OK] apb_scoreboard.sv file is created in provided path")
#---------------------------------------------------------------

# ************** Environment file script *******************
if 6 in choices:
    with open("apb_env.sv", "w") as env:
        env.writelines(['//**************************//\n',
                  '//Author:"write Your name here"\n'
                  '//E-Mail:  \n'
                  '//Description:This is apb_env file \n'
                  '//Date: \n'
                  '//**************************//'

                   '\n`ifndef _APB_ENV\n'
                   '`define _APB_ENV\n'
                  '\nclass apb_env;\n'
                  '\tapb_generator gen;\n'
                  '\tmailbox gen_drv;\n'
                  '\tmailbox mon_sb;\n'
                  '\tapb_driver drv;\n'
                  '\tapb_monitor mon;\n'
                  '\tapb_scoreboard sb;\n'
                  '\tvirtual apb_interface vif;\n'
                   '\n//inside function new pass this argument :virtual apb_interface vif\n'
                  '\n\tfunction new(virtual apb_interface vif);\n'
                  '\t    this.vif = vif;\n'
                  '\t    gen_drv  = new();\n'
                  '\t    mon_sb   = new();\n'
                  '\t    gen      = new(gen_drv);\n'
                  '\t    drv      = new(gen_drv,vif);\n'
                  '\t    mon      = new(vif,mon_sb);\n'
                  '\t    sb       = new(mon_sb);\n'
                  '\tendfunction:new\n'
                  '\n\ttask run();\n'
                  '\t  fork\n'
                  '\t   gen.run();\n'
                  '\t   drv.run();\n'
                  '\t   mon.run();\n'
                  '\t   sb.run();\n'
                  '\t  join_any\n'
                  '\t  #500;\n'
                  '\t  disable fork;\n'
                  '\tendtask:run\n'
                  'endclass:apb_env\n'
                  '`endif'
                  ])
    env.close()
    print(" [OK] apb_env.sv file is created in provided path")
#---------------------------------------------------------------------

#**************** Test File Script ************************
if 7 in choices:
    with open("apb_test.sv", "w") as test:
        test.writelines(['//***********************************//\n',
                   '//Author:"write Your name here"\n'
                   '//E-Mail:  \n'
                   '//Description:This is apb_test file \n'
                   '//Date: \n'
                   '//***********************************//'

                   '\n`ifndef _APB_TEST\n'
                   '`define _APB_TEST\n'
                   '\nclass apb_test;\n'
                   '\tapb_env env;\n'
                   '\tvirtual apb_interface vif;\n'
                   '\n//inside function new pass this argument :virtual apb_interface vif\n'
                   '\n\tfunction new(virtual apb_interface vif);\n'
                   '\t   this.vif=vif;\n'
                   '\tendfunction:new\n'
                   '\n\tvirtual task run();\n'
                   '\n\tendtask:run\n'
                   'endclass:apb_test\n'
                   '`endif'
                   ])
    test.close()
    print(" [OK] apb_test.sv file is created in provided path")
#-----------------------------------------------------------


#************** Top Module Script  ***********************
if 8 in choices:
    with open("apb_top.sv","w") as tm:
        tm.writelines(['//***************************************//'
                   '//Author:"write Your name here"\n'
                   '//E-Mail:  \n'
                   '//Description:This is apb_top file \n'
                   '//Date: \n'
                   '//**************************************//\n'

                   '\n`ifndef _APB_TOP\n'
                   '`define _APB_TOP\n'
                   '`include "apb_interface.sv"\n'
                   '`include "apb_transaction.sv"\n'
                   '`include "apb_generator.sv"\n'
                   '`include "apb_driver.sv"\n'
                   '`include "apb_monitor.sv"\n'
                   '`include "apb_scoreboard.sv"\n'
                   '`include "apb_env.sv"\n'
                   '`include "apb_test.sv"\n'
                   '//`include "apb_error_test.sv"\n'
                   '//`include "apb_read_test.sv"\n'
                   '//`include "apb_write_test.sv"\n'
                   '//`include "dut_module_name"\n'
                   '\nmodule apb_top();\n'
                   '\treg pclk,presetn;\n'
                   '\tapb_interface intf_h(pclk,presetn);\n'
                   '\t//declare handle for dut\n'
                   '\tapb_test test_h;\n'
                   '\t//apb_read_test read_test_h;\n'
                   '\t//apb_write_test write_test_h;\n'
                   '\t//apb_error_test error_test_h;\n'
                   '\n\talways #5 pclk=~pclk;\n'
                   '\n\tinitial begin\n'
                   '\t       pclk=0;\n'
                   '\t       presetn=1;\n'
                   '\t   #3  presetn=0;\n'
                   '\t   #10 presetn=1;\n'
                   '\t   #500 $finish;\n'
                   '\tend\n'
                   '\n\tinitial begin\n'
                   '//\tone example for error_test case written here follow same for other test cases also\n'
                   '//\t\ttest_h = new(intf_h);//dont create this memory one more time anywhere below.\n'
                   '//\t\t$display($time,"Entering Error Operation");\n'
                   '//\t\terror_test_h = new(intf_h);\n'
                   '//\t\ttest_h = error_test_h;\n'
                   '//\t\ttest_h.run();\n'
                   '\n\t // write test case logics of handle assignments'
                   '\n\tend\n'
                   'endmodule:apb_top\n'
                   '`endif'
                   ])
    tm.close()
    print(" [OK] apb_top.sv file is created in provided path")
#---------------------------------------------------------

#************** Interface Module Script ******************
if 9 in choices:
    with open("apb_interface.sv", "w") as vf:
        vf.writelines(['//***************************************//\n'
                   '//Author:"write Your name here"\n'
                   '//E-Mail:  \n'
                   '//Description:This is apb_interface file \n'
                   '//Date: \n'
                   '//**************************************//\n'
                   '\n`ifndef _APB_INTERFACE\n'
                   '`define _APB_INTERFACE\n'
                   '\ninterface apb_interface(input logic pclk,input logic presetn);\n'
                   '\n\t// control signals\n'
                   '\n\t     logic       psel;\n'
                   '\t     logic       penable;\n'
                   '\t     logic       pready;\n'
                   '\n\t// side band signals\n'
                   '\n\t     logic       pwrite;\n'
                   '\t     logic       pslverr;\n'
                   '\t     logic[31:0] paddr;\n'
                   '\t     logic[31:0] prdata;\n'
                   '\t     logic[31:0] pwdata;\n'
                   '\n\t// This signals are for APB4/5.\n'
                   '\n\t     //logic       pport;\n'
                   '\t     //logic       pstrb;\n'
                   '\t     //logic       pauser;\n'
                   '\t     //logic       pwuser;\n'
                   '\t     //logic       pbuser;\n'
                   '\t     //logic       pruser;\n'
                   '\n\t//Clocking Block\n'
                   '\n\t    clocking master_cb @(posedge pclk);\n'
                   '\t\t\t// default input #2 output #2;\n'
                   '\t\t\tinput pready, prdata, pslverr;\n'
                   '\t\t\toutput psel, penable, pwdata, paddr, pwrite;\n'
                   '\t      endclocking\n'
                   '\n\t    clocking monitor_cb @(negedge pclk);\n'
                   '\t\t\t// default input #2 output #2;\n'
                   '\t\t\tinput pready, prdata, pslverr;\n'
                   '\t\t\tinput psel, penable, pwdata, paddr, pwrite;\n'
                   '\t      endclocking\n'
                   '\t//Modports\n'
                   '\n\t     modport slave_mp (input  psel, penable, pwrite, pwdata, paddr,\n'
                   '                          output pready, prdata, pslverr\n'
                   '                          );\n'
                   'endinterface:apb_interface\n'
                   '`endif'
                    ])
    vf.close()
    print(" [OK] apb_interface.sv file is created in provided path")


print("""       NOTE 1: 
         =>create all test cases like apb_error_test.sv,
         apb_write_test.sv, apb_read_test.sv files as mentioned 
         in apb_top.sv file (commented in `include blocks).
         =>All the test cases should extend from apb_test class only.

      NOTE 2: 
         include the design file in apb_top.sv file as mentioned.
                                                                 """)

#----------------------------------- THE END -------------------------------

#______________UNWANTED__________________________________________________________________
#name=["apb_transaction", "apb_generator", "apb_driver", "apb_monitor", "apb_score_board"]
#for i in name:
#   # var=path+i+".sv"
#    var=i+".sv"
#    f=open(var,"w")
#    # with open(var,"w") as f: // add one tab space for next lines.
#    f.writelines([f"class {i};\n",
#                  "\nfunction new(// add arguments here);\n",
#                  "\nendfunction:new\n",
#                  f"\nendclass:{i}"])
#    f.close()
#
##with open(var,"r")as f1:
##    print(f1.read())
##var_1="apb_top"
##var1=path+var_1+".sv"
#________________________________________________________________________________________

