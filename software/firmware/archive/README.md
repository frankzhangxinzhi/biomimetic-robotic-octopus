# Earlier Four-Servo Robot Firmware

[`RoboOctoArduinoCode.ino`](RoboOctoArduinoCode/RoboOctoArduinoCode.ino) is a recovered four-servo variant associated with the AME 441b robot configuration. It uses pins 9, 10, 3 and 4, a 1.9 Hz sinusoidal command, 30-degree amplitude and 90-degree offset. The source waits 10 s before attaching the servos and stops issuing pulses after a 60 s run using `detach()`.

This variant has no BLE interface and starts automatically after the initial delay. It is retained for version history, not as a replacement for the documented [BLE firmware](../robot_control_ble). Its exact date and role in testing have not been established from source alone.

The downloaded `RoboOctoArduinoCode_copy_20250421160937.ino` is byte-identical, so only one copy is included. Source bytes were preserved. The same inherited 5 ms / `~50Hz` comment discrepancy appears here. No physical hardware upload or validation was performed.

Compile check on 2026-10-29: the unmodified four-servo sketch compiled successfully for Arduino Nano RP2040 Connect with Mbed Nano core 4.2.4 and Servo 1.2.2. This verifies compilation only.
