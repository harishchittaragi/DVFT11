CMD = vcs -full64 -sverilog -R -debug_access+all -ntb_opts uvm-1.2 apb_top.sv -l debug.log +continuous_psel=1
COV = -cm line+tgl+cond+fsm+branch+assert
COV_WINDOW = verdi -cov -covdir simv.vdb &
WAVE_VERDI = ./simv -gui
WAVE_DVE = ./simv -gui=dve &
CLEAR = rm -rf csrc/ DVEfiles/ flex* simv* inter* ucli.key novas* vc_hdrs* *.log
TEST = apb_write_test.sv

run :
	${CMD}
wave :
	${WAVE_VERDI}
clear :
	${CLEAR}

cov :
	${COV}

cov_window :
	${COV_WINDOW}
help :
	@echo "To simulate give the command: make run"
	@echo "To open waveform in verdi give the command: make wave"
	@echo "To clear unwanted files give the command: make clear"
