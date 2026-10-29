# Recovered Dual-Servo Firmware (AME 441a)

## Sinusoidal Candidate

[`sinusoidal_input_v2.ino`](sinusoidal_input_v2/sinusoidal_input_v2.ino) was recovered from Frank Zhang's downloaded project files. It directly specifies two servos, a 1.9 Hz sinusoidal angle command and a 30-degree amplitude, consistent with the motion parameters described in the AME 441a report. It is preserved as a recovered candidate. Its use during every formal test has not been independently established.

| Parameter | Value in source |
| --- | --- |
| Servo pins | 9 and 10 |
| Frequency | 1.9 Hz |
| Amplitude | 30 degrees |
| Offset | 90 degrees |
| Commanded angle range | 60-120 degrees |
| Nominal command update interval | 5 ms |
| Commands sent to the two servos | Same angle value |
| Start delay / automatic stop | Neither implemented |
| Dependency | Servo |

The command is `angle = 30 * sin(2 * PI * 1.9 * time) + 90`. Physical fin direction depends on the mechanical installation. The 5 ms interval corresponds to at most 200 command updates/s. The original `~50Hz` comment is inconsistent with this interval; the servo pulse refresh rate is a separate matter. Source comments have been preserved rather than silently corrected.

The report identifies an Arduino Uno R4 Minima for AME 441a. That board's core is not installed in the local Arduino CLI environment at the time of recovery. Compilation on a different board, if performed, is only a portability check and cannot establish R4 compatibility or historical hardware behavior. The unmodified sinusoidal candidate compiled successfully for the installed Arduino Uno AVR core 1.8.6 using Servo 1.2.2. This is an alternate-board compile check, not verification for the reported R4 Minima. No firmware has been uploaded to physical hardware.

## Earlier Sweep Variants

- [`servo_sweep.ino`](archive/servo_sweep/servo_sweep.ino): complementary, linear angle sweeps between 0 and 60 degrees, centered initially at 30 degrees, followed by a 15 s startup wait.
- [`kaleighs_Prac_Code.ino`](archive/kaleighs_Prac_Code/kaleighs_Prac_Code.ino): a related sweep variant with the initial positioning commands commented out.

These sweep variants are not sinusoidal commands and are not labeled as the final report's firmware. They include `delay(3.5)`, which supplies an integer millisecond delay after argument conversion, and have several inherited comments that do not match the code. No timing or motion corrections were made to these recovered sources.

## Provenance

All three source files are preserved byte for byte. [The recovery manifest](../docs/recovered-firmware.json) records hashes and duplicate downloads. The identical `servo_sweep/servo_sweep.ino` download is represented once. Firmware was co-developed; the filename alone does not establish individual authorship for a particular section.

The four-servo `RoboOctoArduinoCode.ino` belongs with the [later robot firmware archive](../../../software/firmware/archive), rather than this dual-servo experiment.
