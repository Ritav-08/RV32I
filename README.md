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

## 📂 Repository Structure
```text
.
├── rtl/                    # Verilog RTL source files pc,adder,imem
│   ├── pc.v                # Program Counter register logic
│   ├── adder.v             # Program Counter incrementer/adder
│   ├── imem.v              # Combinational Read Only Instruction Memory
│   ├── fetch_stage.v       # wired first three modules (PC, Adder, Imem) into a single unit
│   └── regfile.v           # 32x32-bit Register File
│   ├── alu.v               # Arithmetic Logic Unit
│   └── imm_ext.v           # The 32-bit Signed Immediate Extender/ Immediate Extractor
│   └── dmem.v              # Synchronous Write, and Read Data Memory
│   └── control_unit.v      # The Control Unit
│   └── riscv_top.v         # The Final Integration/ Top Level Instantiation

├── sim/                     # Testbenches for functional unit verification
│   ├── tb_pc.sv            # Program Counter testbench
│   └── tb_pc_adder.sv      # PC Adder testbench
│   └── tb_imm_ext.sv       # Self Checking Scoreboard testbench for Immediate Extender
│   └── tb_fetch_stage.sv   # Fetch Stage verification testbench
│   └── tb_reg_file.sv      # Self Checking Scoreboard testbench for Register File
│   └── tb_alu.sv           # Self Checking Scoreboard testbench for the ALU
│   └── tb_riscv_top.sv     # Top Level System Simulation Testbench (Pending)
├── wav/                    # Simulation build artifacts and waveform files (.vcd / .wlf) (pending)
├── docs/                   # ISA specs, memory maps, and block diagrams (pending)
└── README.md               # Project documentation (current)
