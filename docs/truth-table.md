# Truth Table & Functional Specification

This document details the functional behavior and truth table for the **Dual 2-to-4 Decoder / Demultiplexer** module implemented in `src/Project.v`, modeled after the standard 74x139 (SN74LS139A) integrated circuit.

---

## 1. Module Ports

The design contains two identical, independent 2-to-4 line decoders with active-LOW enable inputs and active-LOW outputs.

### Decoder 1
| Signal | Direction | Active Level | Description |
| :--- | :--- | :--- | :--- |
| `G1` | Input | Active-LOW (`0`) | Enable input for Decoder 1 |
| `A1` | Input | Active-HIGH | Select line bit 0 (LSB) |
| `B1` | Input | Active-HIGH | Select line bit 1 (MSB) |
| `Y10` | Output | Active-LOW (`0`) | Output 0 (asserted when `sel1 = 2'b00`) |
| `Y11` | Output | Active-LOW (`0`) | Output 1 (asserted when `sel1 = 2'b01`) |
| `Y12` | Output | Active-LOW (`0`) | Output 2 (asserted when `sel1 = 2'b10`) |
| `Y13` | Output | Active-LOW (`0`) | Output 3 (asserted when `sel1 = 2'b11`) |

### Decoder 2
| Signal | Direction | Active Level | Description |
| :--- | :--- | :--- | :--- |
| `G2` | Input | Active-LOW (`0`) | Enable input for Decoder 2 |
| `A2` | Input | Active-HIGH | Select line bit 0 (LSB) |
| `B2` | Input | Active-HIGH | Select line bit 1 (MSB) |
| `Y20` | Output | Active-LOW (`0`) | Output 0 (asserted when `sel2 = 2'b00`) |
| `Y21` | Output | Active-LOW (`0`) | Output 1 (asserted when `sel2 = 2'b01`) |
| `Y22` | Output | Active-LOW (`0`) | Output 2 (asserted when `sel2 = 2'b10`) |
| `Y23` | Output | Active-LOW (`0`) | Output 3 (asserted when `sel2 = 2'b11`) |

---

## 2. Truth Table (74x139 Logic)

The selection vector is constructed as `sel = {B, A}` where `B` is the high-order select bit and `A` is the low-order select bit.

### Decoder 1 Operation
| Enable (`G1`) | Select MSB (`B1`) | Select LSB (`A1`) | `Y10` | `Y11` | `Y12` | `Y13` | Functional Description |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| `1` | `X` | `X` | `1` | `1` | `1` | `1` | Disabled (all outputs inactive/HIGH) |
| `0` | `0` | `0` | `0` | `1` | `1` | `1` | Output line 0 active |
| `0` | `0` | `1` | `1` | `0` | `1` | `1` | Output line 1 active |
| `0` | `1` | `0` | `1` | `1` | `0` | `1` | Output line 2 active |
| `0` | `1` | `1` | `1` | `1` | `1` | `0` | Output line 3 active |

### Decoder 2 Operation
| Enable (`G2`) | Select MSB (`B2`) | Select LSB (`A2`) | `Y20` | `Y21` | `Y22` | `Y23` | Functional Description |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| `1` | `X` | `X` | `1` | `1` | `1` | `1` | Disabled (all outputs inactive/HIGH) |
| `0` | `0` | `0` | `0` | `1` | `1` | `1` | Output line 0 active |
| `0` | `0` | `1` | `1` | `0` | `1` | `1` | Output line 1 active |
| `0` | `1` | `0` | `1` | `1` | `0` | `1` | Output line 2 active |
| `0` | `1` | `1` | `1` | `1` | `1` | `0` | Output line 3 active |

*Legend: `1` = Logic HIGH, `0` = Logic LOW, `X` = Don't Care.*

---

## 3. Demultiplexer Operation

When used as a 1-to-4 demultiplexer:
- The data input is fed to the active-LOW enable line `G` (or inverted data if positive logic is desired).
- The address lines are fed to select inputs `B` (MSB) and `A` (LSB).
- The binary address steers the input data to the selected output line, while non-selected output lines remain inactive (`HIGH`).

---

## 4. Verilog Implementation Note

In the original source file `src/Project.v`:
```verilog
always @(*) begin
    {Y10, Y11, Y12, Y13} = 4'b1111;
    if (G1 == 1'b0) begin
        case (sel1)
            2'b00: Y10 = 1'b0;
            2'b01: Y11 = 1'b0;
            2'b01: Y11 = 1'b0; // Redundant case branch in original source
            2'b10: Y12 = 1'b0;
            2'b11: Y13 = 1'b0;
        endcase
    end
end
```
The original source code contains a duplicate case item `2'b01: Y11 = 1'b0;` under Decoder 1. In standard Verilog, duplicate case items evaluate identically and are safely synthesized by XST without alterating functional behavior. To preserve the exact historical student project artifact without unauthorized refactoring, this duplicate line is maintained as originally committed.
