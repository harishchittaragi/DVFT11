//*************************************************//
//Author: HARISH RAMANNA CHITTARAGI
//E-mail: chittaragiharish@gmail.com
//Description: This file contains the compilation script
//             and file list for the APB verification project.
//             It specifies include directories, package files,
//             design files, and top-level testbench required
//             for simulation. Ensures proper compilation order
//             and integration of agent, environment, test,
//             interface, and DUT components.
//Date: 04/03/2026 to  20/04/2026.
//*************************************************//

+incdir+/home/dvft1103/dvft11/apb_proj_final/verification/agent/
+incdir+/home/dvft1103/dvft11/apb_proj_final/verification/env/
+incdir+/home/dvft1103/dvft11/apb_proj_final/verification/test/
+incdir+/home/dvft1103/dvft11/apb_proj_final/verification/tb/

/home/dvft1103/dvft11/apb_proj_final/verification/tb/apb_interface.sv
##/home/dvft1103/dvft11/apb_proj_final/verification/agent/apb_transaction.sv
##/home/dvft1103/dvft11/apb_proj_final/verification/agent/apb_generator.sv
##/home/dvft1103/dvft11/apb_proj_final/verification/agent/apb_driver.sv
##/home/dvft1103/dvft11/apb_proj_final/verification/agent/apb_monitor.sv

/home/dvft1103/dvft11/apb_proj_final/verification/agent/apb_agent_package.svp
/home/dvft1103/dvft11/apb_proj_final/verification/env/apb_env_package.svp
/home/dvft1103/dvft11/apb_proj_final/verification/test/apb_test_package.svp

##/home/dvft1103/dvft11/apb_proj_final/verification/env/apb_env.sv
##/home/dvft1103/dvft11/apb_proj_final/verification/env/apb_score_board.sv
##/home/dvft1103/dvft11/apb_proj_final/verification/test/apb_write_test.sv
##/home/dvft1103/dvft11/apb_proj_final/verification/test/apb_read_test.sv
##/home/dvft1103/dvft11/apb_proj_final/verification/test/apb_error_test.sv
/home/dvft1103/dvft11/apb_proj_final/design/apb_slave_design.sv
/home/dvft1103/dvft11/apb_proj_final/verification/tb/apb_top.sv
