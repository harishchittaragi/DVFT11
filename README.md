# DVFT11 – Design Verification Fundamentals Repository

## 📌 Overview
This repository contains my Design Verification learning work, including **Verilog, SystemVerilog, and UVM-based verification environments**, developed as part of my Design Verification training at ChipEdge Private Limited, Bangalore. The purpose of this repository is to document my hands-on practice, verification methodologies, and testbench development skills using industry-standard tools.

## 🎓 Training Program
This work is part of the **Design Verification Fundamentals Training (DVFT11)** conducted by **ChipEdge Private Limited**. The training focuses on building strong foundations in:
- Verilog and SystemVerilog
- Advanced Testbench Architecture
- Assertions and Functional Coverage
- Universal Verification Methodology (UVM)
- Industry-standard verification workflows

## 🛠 Tools Used
- **Synopsys VCS** – Simulation
- **Synopsys Verdi** – Waveform Debugging
- **Linux Environment** – Execution Platform
- **Git & GitHub** – Version Control

---

## 🚀 Featured Project — APB Protocol Verification

### Project Overview
A complete, industry-standard **UVM verification environment** for the **APB (Advanced Peripheral Bus) Protocol**, built as part of Design Verification training at ChipEdge Private Limited.

### UVM Testbench Architecture

| File | Component | Description |
|------|-----------|-------------|
| apb_interface.sv | Interface | APB signal bundle definition |
| apb_transaction.sv | Transaction | APB data item / sequence item class |
| apb_generator.sv | Generator | Stimulus generator |
| apb_driver.sv | Driver | Drives APB protocol signals to DUT |
| apb_monitor.sv | Monitor | Observes and captures DUT transactions |
| apb_score_board.sv | Scoreboard | Compares expected vs actual output |
| apb_agent.sv | Agent | Contains Driver + Monitor + Generator |
| apb_env.sv | Environment | Top-level UVM environment |
| apb_top.sv | Top Module | Testbench top with interface binding |
| apb_slave_design.sv | DUT | APB Slave Design Under Test |

### Test Cases

| Test | File | Description |
|------|------|-------------|
| Base Test | apb_base_test.sv | Base test class with common config |
| Write Test | apb_write_test.sv | Verifies APB write transactions |
| Read Test | apb_read_test.sv | Verifies APB read transactions |
| Read-Write Test | apb_rw_test.sv | Verifies combined read/write operations |
| Error Test | apb_error_test.sv | Verifies error conditions and corner cases |

### Results
- ✅ 100% Functional Coverage achieved
- ✅ All SVA assertions passing
- ✅ Full regression suite executed successfully
- ✅ All 4 test scenarios verified — Write, Read, Read-Write, Error

---

## 🎯 Key Concepts Covered
- RTL Design Verification
- Testbench Architecture (UVM)
- Constrained Random Stimulus Generation
- Functional Coverage Modeling
- SystemVerilog Assertions (SVA)
- UVM Components: Driver, Monitor, Sequencer, Agent, Environment, Scoreboard, Test
- Regression Testing & Automation

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
