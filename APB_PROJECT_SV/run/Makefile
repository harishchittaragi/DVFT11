#*************************************************#
#Author: HARISH RAMANNA CHITTARAGI
#E-mail: chittaragiharish@gmail.com
#Description: This Makefile automates compilation,
#             simulation, waveform viewing, and cleanup
#             for the APB verification project.
#             It uses VCS for simulation, Verdi/DVE for
#             waveform analysis, and supports coverage
#             configuration and viewing.
#             Provides easy-to-use targets such as run,
#             wave, clear, and coverage commands.
#Date: 04/03/2026 to  20/04/2026.
#*************************************************#

CMD = vcs -full64 -sverilog -debug_access+all -f files.f -l debug_final.log -kdb
COV = -cm line+tgl+cond+fsm+branch+assert
COV_WINDOW = verdi -cov -covdir simv.vdb
WAVE_VERDI = ./simv -gui
WAVE_DVE = ./simv -gui=dve
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
