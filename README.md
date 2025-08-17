# Parametric ALU (ASIC-Ready)

A synthesizable, parameterized Arithmetic Logic Unit written in Verilog with functional testbenches.  
Designed as a learning project and as a portfolio piece for ASIC design engineering.

---

## Features Implemented
- **Parameterizable width** (`WIDTH`, default = 32)
- **Supported operations**:
  - ADD (with carry and overflow detection)
  - SUB (with borrow, carry, and overflow detection)
  - AND, OR, XOR
  - SLL (Shift Left Logical)
  - SRL (Shift Right Logical)
  - SRA (Shift Right Arithmetic, sign-preserving)
- **Flags**:
  - Zero (Z): `1` if result = 0
  - Negative (N): copy of result MSB
  - Carry (C): carry-out (or ~borrow for SUB)
  - Overflow (V): signed overflow in two’s complement arithmetic

---

## Project Structure
```
ALU_PROJECT/
│
├── rtl/               # RTL source
│   └── alu.v
│
├── tb/                # Testbenches
│   ├── alu_smoke_tb.v   # smoke test
│   ├── alu_addsub_tb.v  # ADD/SUB ops
│   ├── alu_logic_tb.v   # AND/OR/XOR
│   └── alu_shift_tb.v   # SLL/SRL/SRA
│
├── runs/              # Simulation outputs
│   ├── alu_smoke_1, alu_addsub_tb_1, alu_logic_tb_1, alu_shift_tb
│   ├── *.vcd (waveforms for GTKWave)
│
└── README.md
```

---

## Verification Status
- **ADD/SUB**: Directed tests check normal, carry wrap, and signed overflow cases.  
- **Logic ops**: AND/OR/XOR tested with representative bit patterns.  
- **Shifts**: SLL, SRL, SRA tested with positive and negative operands.  
- All tests pass with Icarus Verilog (`iverilog -g2012`).

---

## How to Run
1. Compile & run a testbench:
   ```bash
   iverilog -g2012 -o runs/alu_addsub tb/alu_addsub_tb.v rtl/alu.v
   vvp runs/alu_addsub
   ```
2. View waveforms:
   ```bash
   gtkwave runs/addsub_waves.vcd
   ```

---

## Next Steps
- Add comparison operations (SLT, SLTU).
- Integrate simple random testing.
- **Synthesis**: push RTL through Yosys/OpenROAD with sky130 to generate timing/area reports.
- Compare ripple-carry adder vs. carry-lookahead version for Fmax/area trade-offs.

---

**Author:** Aashish  
**Created:** 2025-08  
