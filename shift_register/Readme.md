# 4-Bit Shift Register on BASYS3 FPGA

## Overview
This project implements a **4-bit Serial-In, Parallel-Out (SIPO) Shift Register** using Verilog HDL on the **Digilent BASYS3 FPGA development board**.

The design shifts incoming serial data into a 4-bit register on every rising edge of the clock signal. The current register contents are continuously available on the output pins.

## Features
- 4-bit shift register
- Serial data input (`shift_in`)
- Parallel 4-bit output (`shift_out[3:0]`)
- Asynchronous reset
- Positive-edge triggered clock
- Synthesizable Verilog design
- Compatible with Xilinx Vivado and BASYS3 FPGA board

## Module Interface

| Signal | Direction | Description |
|----------|----------|----------|
| `clk` | Input | System clock |
| `reset` | Input | Asynchronous reset (active high) |
| `shift_in` | Input | Serial data input |
| `shift_out[3:0]` | Output | Current register contents |

## Verilog Description

The register is cleared when `reset` is asserted.

```verilog
if (reset)
    register <= 4'b0000;
```

On every rising edge of the clock, the incoming bit is shifted into the least significant position (LSB) while existing bits move left.

```verilog
register <= {register[2:0], shift_in};
```

## Operation Example

Initial state after reset:

```text
0000
```

Input sequence:

```text
1 → 0 → 1 → 1
```

Register contents after each clock pulse:

| Clock Cycle | shift_in | Register Value |
|------------|-----------|---------------|
| Reset | - | 0000 |
| 1 | 1 | 0001 |
| 2 | 0 | 0010 |
| 3 | 1 | 0101 |
| 4 | 1 | 1011 |

## Hardware Requirements

- Digilent BASYS3 FPGA Board
- Xilinx Vivado Design Suite
- USB programming cable

## Pin Assignment Suggestion

| Signal | BASYS3 Resource |
|----------|----------|
| `clk` | 100 MHz onboard clock |
| `reset` | Push Button (BTN0) |
| `shift_in` | Switch (SW0) |
| `shift_out[3:0]` | LEDs (LD3–LD0) |

## Simulation

Verify the design by:
1. Applying reset.
2. Driving a serial input sequence.
3. Observing the register contents after each clock edge.
4. Confirming that LEDs display the shifted data correctly on hardware.

## Project Structure

```text
shift_register/
│
├── shift_register.v
├── shift_register_tb.v
├── constraints.xdc
└── README.md
```

## Expected Output

When a bit stream is provided through `shift_in`, the data shifts through the 4-bit register one position per clock cycle. The LEDs connected to `shift_out` display the current contents of the register in real time.

## Author

Pradeep

## License

This project is open-source and available under the MIT License.
