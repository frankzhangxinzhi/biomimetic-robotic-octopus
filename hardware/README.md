# Mechanical CAD

This directory contains the mechanical CAD package for the biomimetic robotic octopus.

## Files

- `solidworks/RoboOctoV4.SLDASM` — top-level SolidWorks assembly.
- `solidworks/` — referenced SolidWorks part and subassembly files collected using Pack and Go.
- `step/RoboOctoV4_Assembly.step` — neutral-format assembly for viewing in other CAD applications.

## Design Overview

The mechanical system integrates four servo-actuated flexible fins, an internal electronics enclosure, two battery packs, and a streamlined outer shell. The assembled prototype is approximately 320 mm long, including the fins, and uses a 200 mm-diameter base plate.

SolidWorks mass-property and buoyancy models were used during component placement. The predicted center of buoyancy was positioned approximately 14 mm above the center of mass to promote passive restoring stability.

## Model Notes

- Open `RoboOctoV4.SLDASM` with all files in the `solidworks` directory kept together.
- The STEP file contains the complete assembly geometry in a software-independent format.
- The Arduino, power electronics, and wiring components are represented using simplified envelope geometry for packaging and layout purposes; they are not manufacturing-accurate electronic models.
- The production PCB design files are available separately under `hardware/pcb`.

## Attribution

The mechanical system was developed by a three-person USC engineering team. Frank Zhang led the SolidWorks mechanical design and independently performed the buoyancy calculations.