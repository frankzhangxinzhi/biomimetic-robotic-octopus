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

The 10-second delay allowed the operator to initiate the test and move away before the fins began moving. The firmware continues the active motion sequence if the BLE connection is interrupted and automatically stops after 60 seconds.

## Attribution

Co-developed by USC AME 441b Group 25: Frank Zhang, Adrien Ramos, and Kaleigh Ray.