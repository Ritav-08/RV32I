# RISC-V RV32I Processor Core (FPGA & Verilog Implementation)
An open-source implementation and verification of a 32-bit RISC-V (RV32I) processor core. This repository tracks the modular design, simulation, verification, and hardware synthesis of the processor from foundational execution blocks to a complete single-cycle core.
---
## 📌 Project Overview
This project aims to build a fully functional, synthesizable RV32I base integer instruction set processor core using **Verilog HDL**. The development follows a modular hardware design approach, where each execution unit is individually modeled, simulated, and verified using industry-standard Electronic Design Automation (EDA) tools prior to top-level datapath integration.
### Core Architecture Highlights
- **Instruction Set Architecture:** RISC-V RV32I Base Integer Instruction Set
- **Design Paradigm:** Modular Datapath & Control Unit
- **Target Platform:** FPGA (AMD Xilinx / Intel FPGA architectures)
- **Primary Hardware Description Language:** Verilog HDL
- **Verification Method:** Unit testbenches, simulation wave inspection, and functional verification
---
## 🛠️ Toolchain & Environment
The project is developed on **Ubuntu Linux** using a multi-tool EDA workflow:

| Category | Tool / Utility | Purpose |
| :--- | :--- | :--- |
| **HDL Languages** | Verilog HDL, SystemVerilog | Hardware design and testbench verification |
| **Simulators** | Siemens Questa / Modelsim, Icarus Verilog (`iverilog`) | RTL simulation and wave generation |
| **Waveform Viewer** | GTKWave / Questa Wave Window | Signal inspection and timing verification |
| **Synthesis & FPGA Tool** | AMD Xilinx Vivado / Intel Quartus Prime | RTL synthesis, layout, and hardware targeting |
| **Environment** | VS Code, Git, Linux Terminal | Code editing, version control, and build automation |

---
## ⏱️ Progress & Completed Milestones
### 1. Environment Setup & Architecture Planning
- Configured EDA simulation toolchains (Questa Simulator, Icarus Verilog, GTKWave) on Ubuntu Linux.
- Established project directory structure, Git version tracking, and simulation scripts.
- Defined the RV32I architecture roadmap, instruction encoding formats (R, I, S, B, U, J), and datapath control flow.
### 2. Implemented & Verified RTL Modules
- **Program Counter (PC):**
  - Designed synchronous register logic managing the instruction address pointer.
  - Supports synchronous reset and load/increment logic.
  - Verified functional operation via dedicated simulation testbenches.
- **PC Adder / Incrementer:**
  - Implemented combinational hardware adder for sequential instruction address generation (PC + 4) and branch target calculations.
  - Functionally verified across address boundaries in simulation.
---
## 📂 Repository Structure
```text
.
├── rtl/                    # Verilog RTL source files
│   ├── pc.v                # Program Counter register logic
│   ├── pc_adder.v          # Program Counter incrementer/adder
│   ├── alu.v               # Arithmetic Logic Unit (In Progress)
│   └── regfile.v           # 32x32-bit Register File (In Progress)
├── tb/                     # Testbenches for functional unit verification
│   ├── tb_pc.v             # Program Counter testbench
│   └── tb_pc_adder.v       # PC Adder testbench
├── sim/                    # Simulation build artifacts and waveform files (.vcd / .wlf)
├── docs/                   # ISA specs, memory maps, and block diagrams
└── README.md               # Project documentation