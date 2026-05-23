#*************************************************#
#Author: HARISH RAMANNA CHITTARAGI
#E-mail: chittaragiharish@gmail.com
#Description: Makefile for automating compilation,
#             simulation, waveform viewing, and
#             coverage analysis of APB UVM project
#             using VCS, Verdi, and DVE tools.
#             Provides user-friendly commands for
#             run, debug, waveform, and cleanup.
#*************************************************#

CMD = vcs -full64 -sverilog -R -debug_access+all -ntb_opts uvm-1.2 -f files.f -l debug.log -cm line+tgl+cond+fsm+branch+assert -kdb 
COV_WINDOW = verdi -cov -covdir simv.vdb
WAVE_VERDI = ./simv -gui
WAVE_DVE = ./simv -gui=dve
CLEAR = rm -rf csrc/ DVEfiles/ flex* simv* inter* ucli.key novas* vc_hdrs* *.log


DESIGN_PATH = /home/dvft1103/dvft11/uvm/apb_project/design/apb_slave_design.sv
TOP_PATH = /home/dvft1103/dvft11/uvm/apb_project/verification/tb/apb_top.sv

run :
	${CMD}
wave :
	${WAVE_VERDI}
wave_dve :
	${WAVE_DVE}
clear :
	${CLEAR}

cov_window :
	${COV_WINDOW}
help :
	@echo "To simulate-------------------- give the command: make run"
	@echo "To open waveform in verdi------ give the command: make wave"
	@echo "To open waveform in DVE-------- give the command: make wave_dve"
	@echo "To see the coverage window----- give the command: make cov_window"        
	@echo "To clear unwanted files-------- give the command: make clear"