# Five-Stage Pipelined RISC-V Processor

A 32-bit pipelined RISC-V processor implemented in Verilog/SystemVerilog as a Computer Architecture course project at the University of Tehran.

## Overview

This project implements a five-stage pipelined processor with instruction fetch, instruction decode, execution, memory access, and write-back stages.

The processor integrates a control unit, an ALU, a register file, an immediate generator, pipeline registers, and hazard detection and forwarding logic.

## Architecture

The processor follows a five-stage pipeline:

| Stage | Description |
|---|---|
| IF – Instruction Fetch | Fetches instructions and updates the program counter. |
| ID – Instruction Decode | Decodes instructions, reads source registers, and generates immediate values. |
| EX – Execute | Performs ALU operations, evaluates branch conditions, and calculates jump targets. |
| MEM – Memory Access | Handles data memory read and write operations. |
| WB – Write Back | Selects the result to be written back to the register file. |

The stages are separated by four pipeline registers:

- IF/ID
- ID/EX
- EX/MEM
- MEM/WB

## Supported Instructions

The instruction decoder supports the following instruction groups:

**Arithmetic and Logical Instructions**
- `ADD`, `SUB`
- `AND`, `OR`, `XOR`
- `SLT`

**Immediate Instructions**
- `ADDI`, `SLTI`
- `ORI`, `XORI`

**Memory Instructions**
- `LW`
- `SW`

**Control-Flow Instructions**
- `JAL`, `JALR`
- `BEQ`, `BNE`
- `BLT`, `BGE`

## Main Components

### ALU

The Arithmetic Logic Unit supports:

- Addition
- Subtraction
- Bitwise AND
- Bitwise OR
- Bitwise XOR
- Signed less-than comparison (`SLT`)

A zero flag is also generated based on the ALU result.

### Register File

The register file contains 32 registers, each 32 bits wide, with:

- Two independent read ports
- One write port
- Combinational register reads
- Negative-edge-triggered writes
- Asynchronous active-high reset
- Protection of register `x0` from writes

### Immediate Generator

The immediate generator extracts and sign-extends immediate values for four instruction formats:

- I-type
- S-type
- B-type
- J-type

### Control Unit

The controller decodes instructions and generates the control signals required by the pipeline stages. Branch decisions are made in the Execute stage using the corresponding branch control signals and ALU comparison result.

### Hazard Detection and Forwarding

**Data Forwarding**

The forwarding logic selects operands from the register file, MEM stage, or WB stage to resolve data dependencies without unnecessarily waiting for register write-back.

**Load-Use Hazard Detection**

The hazard detection unit identifies dependencies involving load instructions and generates stall, enable, and flush signals when required.

**Control Hazards**

When a branch or jump changes the program flow, the appropriate pipeline registers are flushed to prevent incorrect instructions from progressing through the pipeline.

## Main Modules

| Module | Responsibility |
|---|---|
| `RISCV` | Top-level processor integration |
| `IF` | Instruction fetch |
| `ID` | Instruction decode and register access |
| `EX` | Execution and operand selection |
| `M` | Data memory interface |
| `WB` | Write-back result selection |
| `Controller` | Instruction decoding and control-signal generation |
| `hazardDet` | Hazard detection and forwarding control |
| `ALU` | Arithmetic, logical, and comparison operations |
| `RF` | Register file |
| `IMM` | Immediate generation |
| `FDreg`, `DEreg`, `EMreg`, `MWreg` | Pipeline registers |

## Repository Structure

The repository contains the following main directories and files:

- `CA3_Codes/` — Processor implementation source files.
- `CA3_Design/` — Design-related project files.
- `CA3_Report.pdf` — Project report.

## Project Context

This processor was developed as a group project for a Computer Architecture course at the University of Tehran. The implementation focuses on pipelined processor organization, instruction control, data forwarding, and hazard management.
