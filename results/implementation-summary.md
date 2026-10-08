# FPGA Implementation Summary

This report summarizes verified implementation results and resource utilization extracted directly from the official Xilinx ISE 14.7 synthesis, mapping, place-and-route, and bitstream generation reports (`Project.syr`, `Project_map.mrp`, `Project.par`, `Project.pad`, `project.bgn`).

---

## 1. Hardware & Tool Environment

| Parameter | Specification | Verified Source |
| :--- | :--- | :--- |
| **FPGA Device** | Xilinx Spartan-6 (`xc6slx45`) | `Project_map.mrp`, `Dixant.xise` |
| **Package** | CSG324 | `Project_map.mrp`, `Project.pad` |
| **Speed Grade** | -3 | `Project_map.mrp`, `Project.syr` |
| **Target Board** | Digilent Atlys Spartan-6 FPGA Trainer Board | Physical verification & board silkscreen LOCs |
| **EDA Toolchain** | Xilinx ISE Design Suite 14.7 (nt64) | `Project.syr`, `Project_map.mrp` |
| **Synthesis Tool** | Xilinx XST P.20131013 | `Project.syr` |
| **Implementation Date** | May 01, 2025 | `Project_map.mrp`, `Project.par` |

---

## 2. Synthesis & Device Utilization

The design represents a purely combinational dual 2-to-4 active-LOW decoder/demultiplexer.

### Resource Utilization (Post-Map)
Source: `Project_map.mrp`

| Resource | Used | Available | Utilization (%) |
| :--- | :---: | :---: | :---: |
| **Slice Registers** | 0 | 54,576 | 0% |
| **Slice LUTs** | 4 | 27,288 | < 1% |
| - *LUTs used as logic* | 4 | 27,288 | < 1% |
| - *LUTs using O5 and O6* | 4 | — | — |
| **Occupied Slices** | 4 | 6,822 | < 1% |
| **LUT-FF pairs** | 4 | 27,288 | < 1% |
| **Bonded IOBs** | 14 | 218 | 6% |
| - *LOCed (constrained) IOBs* | 14 | 14 | 100% |
| **RAMB16BWER / RAMB8BWER** | 0 | 348 | 0% |
| **Clock Buffers (BUFG/BUFGMUX)** | 0 | 16 | 0% |
| **DSP48A1 Slices** | 0 | 58 | 0% |

> **Architecture Note:** Each Spartan-6 slice contains 6-input LUTs that can operate as dual 5-input LUTs sharing inputs (`O5` and `O6` outputs). Because each 2-to-4 decoder requires 4 output functions depending on 3 input signals (`G`, `B`, `A`), the Xilinx mapper packed the 8 logic equations into just 4 physical LUTs.

---

## 3. Pin Mapping & Constraints

All 14 top-level I/O ports were 100% placed and constrained to physical package pins via `project.ucf` (`14 out of 14 LOCed` in `Project_map.mrp` and `Project.pad`). The pins correspond directly to onboard slide switches and LEDs of the Digilent Atlys board:

| Signal Name | Direction | FPGA Pin (LOC) | Board Component | Description |
| :--- | :---: | :---: | :--- | :--- |
| `G1` | INPUT | `A10` | Switch SW0 | Decoder 1 Enable (Active-LOW) |
| `A1` | INPUT | `D14` | Switch SW1 | Decoder 1 Select Line A (LSB) |
| `B1` | INPUT | `C14` | Switch SW2 | Decoder 1 Select Line B (MSB) |
| `Y10` | OUTPUT | `U18` | LED LD0 | Decoder 1 Output Line 0 (Active-LOW) |
| `Y11` | OUTPUT | `M14` | LED LD1 | Decoder 1 Output Line 1 (Active-LOW) |
| `Y12` | OUTPUT | `N14` | LED LD2 | Decoder 1 Output Line 2 (Active-LOW) |
| `Y13` | OUTPUT | `L14` | LED LD3 | Decoder 1 Output Line 3 (Active-LOW) |
| `G2` | INPUT | `P15` | Switch SW3 | Decoder 2 Enable (Active-LOW) |
| `A2` | INPUT | `P12` | Switch SW4 | Decoder 2 Select Line A (LSB) |
| `B2` | INPUT | `R5` | Switch SW5 | Decoder 2 Select Line B (MSB) |
| `Y20` | OUTPUT | `M13` | LED LD4 | Decoder 2 Output Line 0 (Active-LOW) |
| `Y21` | OUTPUT | `D4` | LED LD5 | Decoder 2 Output Line 1 (Active-LOW) |
| `Y22` | OUTPUT | `P16` | LED LD6 | Decoder 2 Output Line 2 (Active-LOW) |
| `Y23` | OUTPUT | `N12` | LED LD7 | Decoder 2 Output Line 3 (Active-LOW) |

- **I/O Standard:** `LVCMOS25`
- **Output Drive Strength:** `12 mA`
- **Slew Rate:** `SLOW`

---

## 4. Place & Route (PAR) Status

Source: `Project.par`

- **Overall PAR Status:** Completed with 0 errors, 0 warnings.
- **Routing Status:** All signals completely routed (`0 unrouted`).
- **Timing Score:** `0` (Setup: 0, Hold: 0).
- **Execution Time:** Real Time: 5s, CPU Time: 5s.

---

## 5. Bitstream Generation

Source: `project.bgn`

- **Command:** `bitgen -intstyle ise -w ... Project.ncd`
- **DRC Status:** 0 errors, 0 warnings.
- **Output:** Bitstream file `project.bit` created and saved successfully.
