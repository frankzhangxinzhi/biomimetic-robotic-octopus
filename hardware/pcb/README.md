# Custom PCB Design

Custom PCB designed in KiCad for the compact electrical integration of the biomimetic robotic octopus.

## Design Purpose

The PCB replaces the prototype breadboard and loose wiring inside the waterproof enclosure. It integrates the Arduino Nano RP2040 Connect, four servo signal connections, two external battery inputs, and a shared electrical ground.

## Electrical Architecture

- Controller: Arduino Nano RP2040 Connect
- Actuators: Four high-torque servo motors
- Power: Two external 7.2 V Ni-MH battery packs
- Servo signal pins: `D3`, `D4`, `D9`, and `D10`
- Power trace width: 2 mm
- All battery, servo, and controller grounds share a common reference

The two battery packs divide the load across the four servos while avoiding the voltage-converter heating encountered in the earlier prototype.

## Connector and Pin Mapping

| Connector | Function | Arduino Signal | Power Rail |
|---|---|---:|---|
| J1 | Battery input 1 | - | `7vB1` |
| J2 | Battery input 2 | - | `7vB2` |
| J3 | Servo 1 | `D3` | `7vB1` |
| J4 | Servo 2 | `D4` | `7vB1` |
| J5 | Servo 3 | `D9` | `7vB2` |
| J6 | Servo 4 | `D10` | `7vB2` |

## Design Files

- `project0318.kicad_pro` - KiCad project file
- `project0318.kicad_sch` - Circuit schematic
- `project0318.kicad_pcb` - PCB layout

## Opening the Project

1. Install KiCad 9.0 or a compatible newer version.
2. Open `project0318.kicad_pro`.
3. Use Schematic Editor to inspect the circuit.
4. Use PCB Editor to inspect the component placement and routed traces.

## Attribution

PCB architecture, schematic capture, layout, fabrication coordination, soldering, and system integration were completed by Frank Zhang.