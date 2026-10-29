# BLE Servo Control Firmware

Arduino firmware used to control the four flexible fins of the biomimetic robotic octopus during pool testing.

## Target Hardware

- Arduino Nano RP2040 Connect
- Four servo-actuated flexible fins
- Servo pins: `9`, `10`, `3`, and `4`
- External 7.2 V Ni-MH servo power supplies with a shared ground

## Dependencies

- `Servo`
- `ArduinoBLE`

## BLE Interface

- Local device name: `BT-ServoSwitch`
- BLE service UUID: `180C`
- Control characteristic UUID: `2A56`
- Write `1` to begin the test sequence
- Write `0` to stop the test sequence

The firmware was operated through the nRF Connect mobile application during pool testing.

In nRF Connect, connect to `BT-ServoSwitch` and write a single byte to characteristic `2A56`: use `01` to start or `00` to stop when the input format is **ByteArray / Hex**. The characteristic expects a numeric byte, rather than the text character `1` or `0`.

## Opening the Sketch

Open `robot_control_ble.ino` in Arduino IDE, select **Arduino Nano RP2040 Connect** from the Arduino Mbed OS Nano Boards package, and install the `Servo` and `ArduinoBLE` libraries through Library Manager. The source includes servo motion control and BLE commands; IMU acquisition is not implemented in this sketch.

## Motion Profile

The four servos follow a synchronized sinusoidal trajectory defined by `angle = amplitude × sin(2π × frequency × time) + offset`.

Default parameters:

| Parameter | Value |
|---|---:|
| Frequency | 1.9 Hz |
| Amplitude | 30° |
| Center position | 90° |
| Update interval | 5 ms |
| Start delay | 10 s |
| Maximum run time | 60 s |

After a start command, the servos first move to the 90-degree center position for approximately 1 second, then detach during the 10-second waiting period. Motion therefore begins approximately 11 seconds after the command. A stop command returns all servos to center for approximately 1 second before detaching them. Repeated start commands are ignored while waiting or moving.

The 10-second waiting period allowed the operator to move away before the fins began moving. The firmware continues the active motion sequence if the BLE connection is interrupted and automatically stops after 60 seconds of motion. The 5 ms interval schedules angle commands; it does not specify the servo's PWM pulse rate.

## Attribution

Co-developed by USC AME 441b Group 25: Frank Zhang, Adrien Ramos, and Kaleigh Ray.
