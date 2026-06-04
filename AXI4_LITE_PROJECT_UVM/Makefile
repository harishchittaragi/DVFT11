#*************************************************#
#Description: Makefile for AXI4-Lite UVM testbench
#             to automate simulation, waveform
#             viewing, coverage analysis, and
#             cleanup. It provides commands to
#             compile and run using VCS, open
#             waveforms in Verdi/DVE, and manage
#             generated files efficiently.
#*************************************************#
CMD = vcs -full64 -sverilog -R -debug_access+all -ntb_opts uvm-1.2 axi4_lite_top.sv -l debug.log -cm line+tgl+assert+cond+fsm+branch
COV_WINDOW = verdi -cov -covdir simv.vdb &
WAVE_VERDI = ./simv -gui
WAVE_DVE = ./simv -gui=dve &
CLEAR = rm -rf csrc/ DVEfiles/ flex* simv* inter* ucli.key novas* vc_hdrs* *.log cm.log tr_db.log verdiLog/ .* 

run :
	${CMD}
wave :
	${WAVE_VERDI}
clear :
	${CLEAR}
cov_window :
	${COV_WINDOW}
help :
	@echo "To simulate give the command: make run"
	@echo "To open waveform in verdi give the command: make wave"
	@echo "To clear unwanted files give the command: make clear"
	@echo "To open coverage window give the command: make cov_window"
