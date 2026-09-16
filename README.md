# 5-Stage Pipelined RISC-V Processor: RTL Sorting Implementation

This repository contains the complete Verilog implementation and Xilinx Vivado simulation workspace for a 5-stage pipelined RISC-V processor. Originally developed as a comprehensive Computer Engineering course project, this architecture was specifically designed and verified to natively execute a bubble sort algorithm on data memory arrays. 

Serving as a practical exploration of hardware-software co-design, this project demonstrates pipeline optimization, hazard resolution, and digital logic verification at the system level.

---

## 🏗️ Architecture & Core Features

The processor implements a classic RISC datapath, engineered to handle the rigorous control flow and memory operations required for iterative sorting algorithms.

*   **Classic 5-Stage Pipeline:** 
    *   **Instruction Fetch (IF) & Decode (ID):** Fetches instructions from memory and parses them through a centralized Control Unit.
    *   **Execute (EX):** Utilizes a modular Arithmetic Logic Unit (ALU) to perform core computations and calculate branch target addresses.
    *   **Memory (MEM) & Write Back (WB):** Interfaces with Data Memory for load/store operations and updates the Register File.
    *   *Significance:* Pipelining these stages significantly increases instruction throughput and reduces the overall Cycles Per Instruction (CPI) compared to a single-cycle design.
*   **Robust Hazard Resolution:**
    *   **Forwarding Unit:** Detects Read-After-Write (RAW) data hazards and routes computed values directly to the Execute stage, minimizing wasted clock cycles.
    *   **Hazard Detection Unit:** Monitors the pipeline for unavoidable load-use data hazards and control hazards (branches/jumps), intelligently stalling the pipeline or flushing instructions only when absolutely necessary.
*   **Algorithmic Execution (Bubble Sort):** 
    *   Sorting algorithms require continuous, nested looping (branching) and sequential memory accesses. Successfully executing bubble sort at the Register-Transfer Level (RTL) proves the stability of the processor's hazard detection, memory interfacing, and branch calculation logic under heavy computational loads.

---

## 🔬 Verification & Simulation Strategy

The architecture was rigorously tested and validated using Xilinx Vivado, employing a bottom-up verification approach to ensure zero data corruption during pipelined execution.

*   **Component-Level Unit Testing:** Independent testbenches validate the isolated functionality of critical modules, including the Program Counter, Data Memory, Instruction Memory, and ALU variants.
*   **Control & Decoding Validation:** Dedicated parser simulations ensure the Control Unit accurately decodes instruction formats (R-type, I-type, S-type, B-type) across various pipeline states.
*   **Top-Level Integration Testing:** System-level simulations verify the completely integrated datapath. By tracing waveform signals across all five stages simultaneously, the design ensures that data dependencies are correctly managed while the sorting algorithm runs to completion.

---

## 🚀 Project Outcomes & Architectural Insights

This implementation bridges the gap between high-level algorithmic logic and low-level hardware execution. By designing the pipelined datapath from scratch, the project emphasizes several critical principles of computer architecture:

*   **RTL Design & Modularity:** Translating theoretical ISA specifications into synthesizable, modular Verilog components that can be independently tested and integrated.
*   **Hardware-Level Problem Solving:** Designing forwarding and stalling mechanisms to resolve data and control hazards dynamically, prioritizing cycle efficiency over software-level NOP insertions.
*   **Systems-Level Verification:** Utilizing standard simulation methodologies to trace datapath signals, debug timing constraints, and validate memory operations under complex algorithmic loads.
