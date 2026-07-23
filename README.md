# DVFT11 – Design Verification Fundamentals Repository

## 📌 Overview

This repository contains my Design Verification learning work, including **Verilog, SystemVerilog, and UVM-based verification environments**, developed as part of my Design Verification training at ChipEdge Private Limited, Bangalore. The purpose of this repository is to document my hands-on practice, verification methodologies, and testbench development skills using industry-standard tools.

---

## 🎓 Training Program

This work is part of the **Design Verification Fundamentals Training (DVFT11)** conducted by **ChipEdge Private Limited**. The training focuses on building strong foundations in:

- Verilog and SystemVerilog
- Advanced Testbench Architecture
- Assertions and Functional Coverage
- Universal Verification Methodology (UVM)
- Industry-standard verification workflows

---

## 🛠 Tools Used

- **Synopsys VCS** – Simulation
- **Synopsys Verdi** – Waveform Debugging
- **Linux Environment** – Execution Platform
- **Git & GitHub** – Version Control

---

## 📁 Repository Structure

```
DVFT11/
├── System_Verilog/
├── UVM_CODES/
├── PYTHON/
├── APB_PROJECT_UVM/
├── APB_PROJECT_SV/
├── AXI4_LITE_PROJECT_UVM/
├── verilog_prog/
└── README.md
```

---

## 📂 System_Verilog

Practice codes covering core SystemVerilog concepts used in design verification:

| Folder | Description |
|--------|-------------|
| `assertion` | SystemVerilog Assertion (SVA) examples — immediate and concurrent assertions |
| `coverages` | Functional coverage groups, coverpoints, and cross-coverage |
| `FIFO` | FIFO design and verification using SystemVerilog |
| `interface` | Interface declarations, modports, and clocking blocks |
| `interprocess_communication` | IPC mechanisms — mailbox, semaphore, event |
| `memory` | Memory modeling and verification |
| `oops` | Object-Oriented Programming in SystemVerilog — classes, inheritance, polymorphism |
| `randomization` | Constrained random stimulus generation |
| `state_2_4` | State machine design and verification |
| `TimeScale` | Timescale directives and simulation precision |
| `virtual_interface` | Virtual interface usage in testbenches |

---

## 📂 UVM_CODES

Hands-on UVM component practice covering the full UVM methodology:

| Folder | Description |
|--------|-------------|
| `apb_project` | Full UVM testbench for APB Protocol (see featured project below) |
| `config_db` | `uvm_config_db` usage — set/get configuration objects |
| `objects` | UVM objects and field macros |
| `override` | Factory overrides — type and instance overrides |
| `phases` | UVM phase mechanism — build, connect, run, and cleanup phases |
| `seq_seqr_driver_communic` | Sequence–Sequencer–Driver communication flow |
| `tlm_fifo` | TLM FIFO — `uvm_tlm_fifo` for inter-component communication |
| `tlm_ports` | TLM ports and exports — `uvm_analysis_port`, `uvm_blocking_put_port` |
| `verbosity` | UVM verbosity levels and message control |
| `virt_seq_seqr` | Virtual sequences and virtual sequencers for multi-agent coordination |

---

## 📂 PYTHON

Python scripting for verification automation and tooling support:

| Folder | Description |
|--------|-------------|
| `apb_script` | Python automation scripts for APB verification flow |
| `data_types` | Python data types and structures |
| `def` | Function definitions and modular scripting |
| `oops` | Object-Oriented Programming in Python |
| `openfiles` | File handling — reading, writing, and parsing |
| `operators` | Python operators and expressions |
| `script` | General-purpose automation scripts |

---

## 🚀 Featured Project — APB Protocol Verification

A complete, industry-standard verification environment for the **APB (Advanced Peripheral Bus) Protocol**, implemented in two flavors:

- **APB_PROJECT_SV** – SystemVerilog-based testbench
- **APB_PROJECT_UVM** – Full UVM testbench

---

### 🔷 APB_PROJECT_SV — SystemVerilog Testbench Architecture

A structured, class-based SystemVerilog testbench for APB protocol verification.

| File | Component | Description |
|------|-----------|-------------|
| `apb_interface.sv` | Interface | APB signal bundle with modports and clocking block |
| `apb_transaction.sv` | Transaction | Data item with randomizable fields for APB transfers |
| `apb_generator.sv` | Generator | Constrained random stimulus generator |
| `apb_driver.sv` | Driver | Drives APB protocol signals onto the DUT interface |
| `apb_monitor.sv` | Monitor | Observes and captures DUT transactions |
| `apb_score_board.sv` | Scoreboard | Compares expected vs actual output with error reporting |
| `apb_agent.sv` | Agent | Encapsulates Driver, Monitor, and Generator |
| `apb_env.sv` | Environment | Top-level testbench environment |
| `apb_top.sv` | Top Module | Testbench top with interface binding and test instantiation |
| `apb_slave_design.sv` | DUT | APB Slave Design Under Test |

#### Test Cases (SV)

| Test | File | Description |
|------|------|-------------|
| Write Test | `apb_write_test.sv` | Verifies APB write transactions |
| Read Test | `apb_read_test.sv` | Verifies APB read transactions |
| Read-Write Test | `apb_rw_test.sv` | Verifies combined read/write operations |
| Error Test | `apb_error_test.sv` | Verifies error conditions and corner cases |

---

### 🔶 APB_PROJECT_UVM — Full UVM Testbench Architecture

A complete UVM verification environment for the APB Protocol with factory registration, config_db, TLM connections, and phase-based execution.

| File | UVM Component | Description |
|------|---------------|-------------|
| `apb_interface.sv` | Interface | APB signal bundle definition with clocking blocks |
| `apb_sequence_item.sv` | `uvm_sequence_item` | APB transaction data item with `uvm_field` macros |
| `apb_sequencer.sv` | `uvm_sequencer` | Routes sequences to the driver |
| `apb_driver.sv` | `uvm_driver` | Drives APB protocol signals to DUT via virtual interface |
| `apb_active_monitor.sv` | `uvm_monitor` (Active) | Captures transactions from the active agent side |
| `apb_passive_monitor.sv` | `uvm_monitor` (Passive) | Observes DUT outputs passively |
| `apb_active_agent.sv` | `uvm_agent` (Active) | Contains Driver + Sequencer + Active Monitor |
| `apb_passive_agent.sv` | `uvm_agent` (Passive) | Contains Passive Monitor only |
| `apb_score_board.sv` | `uvm_scoreboard` | Compares expected vs actual; raises UVM errors on mismatch |
| `apb_coverage.sv` | `uvm_subscriber` | Functional coverage collector with covergroups |
| `apb_env.sv` | `uvm_env` | Top-level UVM environment with agent, scoreboard, coverage |
| `apb_test.sv` | `uvm_test` | Base test class; extended by individual test scenarios |
| `apb_top.sv` | Top Module | Testbench top with `run_test()` and interface binding |
| `apb_slave_design.sv` | DUT | APB Slave Design Under Test |

#### Sequences

| File | Description |
|------|-------------|
| `apb_con_psel_seq.sv` | Sequence for continuous PSEL assertion |
| `apb_write_seq.sv` | Sequence for APB write transfers |
| `apb_read_seq.sv` | Sequence for APB read transfers |
| `apb_rw_seq.sv` | Sequence for combined read-write transfers |
| `apb_error_seq.sv` | Sequence for error condition stimulus |

#### Test Cases (UVM)

| Test | File | Description |
|------|------|-------------|
| Base Test | `apb_test.sv` | Base test class with environment instantiation and config |
| Write Test | via write sequence | Runs `apb_write_seq` on the sequencer |
| Read Test | via read sequence | Runs `apb_read_seq` on the sequencer |
| Read-Write Test | via rw sequence | Runs `apb_rw_seq` for combined operations |
| Error Test | via error sequence | Runs `apb_error_seq` for corner-case validation |

#### Results

- ✅ 100% Functional Coverage achieved
- ✅ All SVA assertions passing
- ✅ Full regression suite executed successfully
- ✅ All 4 test scenarios verified — Write, Read, Read-Write, Error

---
## ⭐ AXI4-Lite Protocol Verification (Latest)

A complete, industry-standard **UVM verification environment** for the **AXI4-Lite Protocol** (ARM AMBA), built as part of Design Verification training at ChipEdge Private Limited.

> ⚠️ Note: The DUT (Design Under Test) is an industry-standard confidential design provided by ChipEdge Private Limited and is not included in this repository.

### 🔶 AXI4-Lite UVM Testbench Architecture

| File | UVM Component | Description |
|------|---------------|-------------|
| `axi4_lite_interface.sv` | Interface | AXI4-Lite signal bundle — all 5 channels |
| `axi4_lite_seq_item.sv` | `uvm_sequence_item` | AXI4-Lite transaction data item |
| `axi4_lite_sequencer.sv` | `uvm_sequencer` | Routes sequences to the driver |
| `axi4_lite_driver.sv` | `uvm_driver` | Drives all AXI4-Lite channel signals to DUT |
| `axi4_lite_act_monitor.sv` | `uvm_monitor` | Observes and captures DUT transactions |
| `axi4_lite_active_agent.sv` | `uvm_agent` | Contains Driver + Sequencer + Monitor |
| `axi4_lite_coverage.sv` | `uvm_subscriber` | Functional coverage collector |
| `axi4_lite_sb.sv` | `uvm_scoreboard` | Write/Read/Cross check with MATCH verification |
| `axi4_lite_env.sv` | `uvm_env` | Top-level UVM environment |
| `axi4_lite_test.sv` | `uvm_test` | Base test class |
| `axi4_lite_top.sv` | Top Module | Testbench top with run_test() and interface binding |
| `Makefile` | Regression | Automated regression execution |

### Sequences

| File | Description |
|------|-------------|
| `write_seq.sv` | Write Address + Write Data + Write Response channel sequence |
| `read_seq.sv` | Read Address + Read Data channel sequence |
| `wr_rd_seq.sv` | Combined Write followed by Read sequence |
| `slverr_seq.sv` | Slave error response sequence for error condition verification |

### Channels Verified

| Channel | Signals | Status |
|---------|---------|--------|
| Write Address (AW) | awaddr, awvalid, awready | ✅ Verified |
| Write Data (W) | wdata, wstrb, wvalid, wready | ✅ Verified |
| Write Response (B) | bresp, bvalid, bready | ✅ Verified |
| Read Address (AR) | araddr, arvalid, arready | ✅ Verified |
| Read Data (R) | rdata, rresp, rvalid, rready | ✅ Verified |

### Results

- ✅ 100% Functional Coverage achieved across all AXI4-Lite channels
- ✅ All SVA assertions passing — 573 attempts, 0 failures
- ✅ Scoreboard: WRITE PASS = 30, READ PASS = 30, CROSS CHECK MATCH verified
- ✅ UVM_FATAL = 0, UVM_ERROR = 0 (functional), UVM_WARNING = 0
- ✅ All 4 test sequences verified — Write, Read, Write-Read, Slave Error
- ✅ VCS Coverage Metrics monitored — line, cond, FSM, branch, tgl
- ✅ Simulation completed: Thu Jun 4 15:15:25 2026

---

## 🎯 Key Concepts Covered

- RTL Design Verification
- Testbench Architecture (SystemVerilog & UVM)
- Constrained Random Stimulus Generation
- Functional Coverage Modeling
- SystemVerilog Assertions (SVA)
- UVM Components: Driver, Monitor, Sequencer, Agent, Environment, Scoreboard, Test
- TLM Communication (Ports, Exports, FIFOs)
- UVM Factory, Config DB, Phases
- Virtual Sequences and Virtual Sequencers
- Python Scripting for Verification Automation
- Regression Testing & Automation
- AXI4-Lite Protocol — 5-channel AMBA verification
---

## 👨‍💻 Author

**Harish Ramanna Chittaragi**
Electronics and Communication Engineering (ECE)
Aspiring VLSI Design Verification Engineer

🔗 [LinkedIn](https://www.linkedin.com/in/harish-chittaragi-644a341b9)
🐙 [GitHub](https://github.com/harishchittaragi)

---

## 📌 Note

All files in this repository are created for **educational and training purposes** as part of Design Verification learning and practice at ChipEdge Private Limited.

⭐ *This repository will be continuously updated as I progress in my Design Verification journey.*
