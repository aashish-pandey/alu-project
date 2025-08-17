# ALU Project

## 📌 Overview
This project implements a **16-bit Arithmetic Logic Unit (ALU)** in Verilog with full **directed verification** and a quick **smoke synthesis** to validate RTL quality and get an estimate of gate count.  
The ALU supports arithmetic, logical, and shift operations, along with computation of standard flags.

---

## ⚡ Features
- **Arithmetic**: Addition, Subtraction (with Carry & Overflow detection)  
- **Logical**: AND, OR, XOR  
- **Shift Operations**:  
  - SLL (Shift Left Logical)  
  - SRL (Shift Right Logical)  
  - SRA (Shift Right Arithmetic)  
- **Flags Generated**:  
  - Zero (Z)  
  - Carry (C)  
  - Signed Overflow (V)  
  - Negative (N)  

---

## 🗂️ Project Structure
```
ALU_PROJECT/
│
├── rtl/                # RTL design files
│   └── alu.v
│
├── tb/                 # Testbenches
│   ├── alu_addsub_tb.v
│   ├── alu_logic_tb.v
│   ├── alu_shift_tb.v
│   └── alu_smoke_tb.v
│
├── runs/               # Simulation & synthesis outputs
│   ├── *.vcd           # Waveforms for GTKWave
│   ├── alu_netlist.v   # Synthesized netlist
│   ├── alu.json        # Yosys synthesis report
│   └── *_tb_*          # Compiled test runs
│
├── command_notes.txt   # Helpful commands for running
└── README.md
```

---

## ✅ Verification
- Each operation family has a **directed testbench**.  
- Edge cases covered:
  - ADD/SUB with carry and signed overflow  
  - Zero and negative results  
  - Shifts with MSB/LSB checks  
- Waveforms (`.vcd` files) can be viewed in **GTKWave**.

---

## 🛠️ Smoke Synthesis
A **quick synthesis with Yosys** was performed to:
- Confirm synthesizability of the RTL  
- Estimate gate count & area usage  
- Generate a netlist (`alu_netlist.v`)  

This helps validate that the design is not just functionally correct but also implementation-ready.

---

## 🚀 How to Run
### Simulation
```bash
# Example: run ADD/SUB testbench
iverilog -o alu_addsub_tb tb/alu_addsub_tb.v rtl/alu.v
./alu_addsub_tb
gtkwave runs/addsub_waves.vcd
```

### Smoke Synthesis
```bash
yosys -p "read_verilog rtl/alu.v; synth -top alu; write_verilog runs/alu_netlist.v; stat"
```

---

## 📊 Sample Output (Shift Test)
```
op=5, a=00000001, b=00000004 | y=00000010, C=0, V=0, Z=0, N=0   // SLL
op=6, a=00000010, b=00000002 | y=00000004, C=0, V=0, Z=0, N=0   // SRL
op=7, a=ffffffe0, b=00000003 | y=fffffffc, C=0, V=0, Z=0, N=1   // SRA
```

---

## 📖 Learnings
- RTL design for arithmetic/logic/shift datapath  
- Directed verification with corner-case testing  
- Understanding flag logic (Carry, Overflow, Negative, Zero)  
- RTL → Gate-level flow with smoke synthesis  

---

## 👨‍💻 Author
Aashish Pandey  
*(Graduate Student – Computer Engineering, UC)*  
