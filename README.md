# Traffic Light Controller with Pedestrian Crossing Button

A four-road traffic light controller (T1–T4) with a pedestrian crossing
button, modelled at RTL in Verilog/SystemVerilog as a finite state machine.
Done as part of an RTL Design and Verification project.

## Features
- Round-robin control of four roads: green for 5 units, then a 2-unit
  yellow overlap between the road that is stopping and the next one that is starting
- Pedestrian button request is latched, so a short press is not lost
- The running state finishes first, then a pedestrian state starts
  (all roads red, pedestrian signal ON for 5 units)
- The cycle then resumes from the state that would have come next
- `en` input enables the controller; when low, all roads show red

## Design overview
| Module | Description |
|--------|-------------|
| `traffic` (design.sv) | Top module: FSM, pedestrian request latch, output decoder |
| `count5` | Timer for the 5-unit states (green and pedestrian) |
| `count2` | Timer for the 2-unit states (yellow) |
| `clk_div` | Clock divider, instantiated for deriving a slow clock |

### Ports
| Name | Dir | Width | Description |
|------|-----|-------|-------------|
| `sysclk` | in | 1 | System clock |
| `en` | in | 1 | Enable (active high) |
| `ped_req` | in | 1 | Pedestrian button |
| `R`, `Y`, `G` | out | 4 each | Lamps of T1–T4 (bit 0 = T1, bit 3 = T4) |
| `ped_sig` | out | 4 | `1111` = pedestrian walk |

### States
S0–S7 alternate between a green state (S0, S2, S4, S6) and a yellow
state (S1, S3, S5, S7). A ninth state, `PED`, handles pedestrian crossing.

## Files
- `design.sv` – top module
- `clk_div.v`, `count5.v`, `count2.v` – sub-modules
- `testbench.sv` – testbench (10 ns clock, one pedestrian press at 60 ns, runs to 1500 ns)


## How to simulate
**EDA Playground (used in this project):**
1. Paste `design.sv` and `testbench.sv`, and add the three sub-module files
2. Choose Cadence Xcelium or Synopsys VCS
3. Tick "Open EPWave after run" and click Run

**Local (example with Xcelium):**

xrun -sysv design.sv testbench.sv -access +rw


## Results
The EPWave waveform shows the correct order of states, the pedestrian
phase entered after the running state finishes, and the normal sequence
resuming afterwards.

## Future work
- Drive the timers from the divided clock so times are real seconds on an FPGA
- Self-checking testbench with assertions and multiple pedestrian requests
- Flashing pedestrian signal, vehicle sensors, emergency override
- Synthesis and physical design flow

## Tools
Verilog / SystemVerilog, EDA Playground, Cadence Xcelium 25.03,
Synopsys VCS 2025.06, EPWave
