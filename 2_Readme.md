## 🎯 Architecture Roadmap & Next Steps
---
​[x] Environment setup & EDA simulator toolchain configuration
​[x] Program Counter (PC) module design & simulation verification
​[x] PC Adder module design & simulation verification
​[ ] Register File: 32-bit general-purpose register array (X0 - X31) with dual-read/single-write ports
​[ ] Arithmetic Logic Unit (ALU): Arithmetic, logical, and shift hardware execution block
​[ ] Control Unit & Instruction Decoder: Decoding opcode, funct3, and funct7 fields
​[ ] Instruction & Data Memory Interfaces: Memory mapping and fetch/store architecture
​[ ] Single-Cycle Processor Core Integration: Top-level integration and instruction suite execution
​[ ] 5-Stage Pipelined Architecture: Hazard detection, stall, and forwarding units
​[ ] FPGA Target Synthesis: Synthesis, place-and-route, and on-board testing
---

## 💻 Running Simulations
### Prerequisites
To run unit testbenches using open-source tools on Linux:

```bash
sudo apt update
sudo apt install iverilog gtkwave

### Running Testbenches (Icarus Verilog)
** 1. Clone the repository: **

```bash
git clone [https://github.com/your-username/riscv-rv32i-core.git](https://github.com/your-username/riscv-rv32i-core.git)
cd riscv-rv32i-core

** 2. Simulate the Program Counter (PC): **

```bash
iverilog -o sim/tb_pc.out rtl/pc.v tb/tb_pc.v
vvp sim/tb_pc.out
gtkwave sim/tb_pc.vcd

** 3. Simulate the PC Adder: **

```bash
iverilog -o sim/tb_pc_adder.out rtl/pc_adder.v tb/tb_pc_adder.v
vvp sim/tb_pc_adder.out

### 📜 License
This project is available as open-source hardware