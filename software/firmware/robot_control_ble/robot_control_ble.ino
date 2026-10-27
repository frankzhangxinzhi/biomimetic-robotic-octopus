#include <Servo.h>
#include <ArduinoBLE.h>

Servo servo1;
Servo servo2;
Servo servo3;
Servo servo4;

// Sine wave parameters
float frequency = 1.9;
float amplitude = 30.0;
float offset = 90.0;

// BLE setup
BLEService motionService("180C");
BLEByteCharacteristic motionControlChar("2A56", BLEWrite | BLERead);

// Timing
unsigned long previousMillis = 0;
const unsigned long updateInterval = 5;
unsigned long motionStartTime = 0;
const unsigned long motionDuration = 60000;
bool motionActive = false;
bool motionWaiting = false;
unsigned long waitStartTime = 0;
const unsigned long motionDelay = 10000;

void setup() {
  BLE.begin();
  BLE.setLocalName("BT-ServoSwitch");
  BLE.setAdvertisedService(motionService);

  motionService.addCharacteristic(motionControlChar);
  BLE.addService(motionService);

  motionControlChar.writeValue(0);
  BLE.advertise();
}

void loop() {
  BLEDevice central = BLE.central();

  // Only read BLE input while connected
  if (central && central.connected()) {
    if (motionControlChar.written()) {
      byte val = motionControlChar.value();
      if (val == 1 && !motionActive && !motionWaiting) {
        prepareMotion();  // Start waiting
      }
      if (val == 0 && (motionActive || motionWaiting)) {
        stopMotion();  // Stop early
      }
    }
  }

  // Handle 10-second delay before motion
  if (motionWaiting && millis() - waitStartTime >= motionDelay) {
    startMotion();
  }

  // Handle motion even if Bluetooth disconnects
  if (motionActive) {
    unsigned long currentMillis = millis();
    if (currentMillis - previousMillis >= updateInterval) {
      previousMillis = currentMillis;

      float timeInSeconds = (currentMillis - motionStartTime) / 1000.0;
      float angle = amplitude * sin(2.0 * PI * frequency * timeInSeconds) + offset;
      angle = constrain(angle, 0.0, 180.0);

      servo1.write(angle);
      servo2.write(angle);
      servo3.write(angle);
      servo4.write(angle);
    }

    // Auto-stop after 60 seconds
    if (millis() - motionStartTime >= motionDuration) {
      stopMotion();
    }
  }
}

void prepareMotion() {
  servo1.attach(9);
  servo2.attach(10);
  servo3.attach(3);
  servo4.attach(4);

  servo1.write(offset);
  servo2.write(offset);
  servo3.write(offset);
  servo4.write(offset);

  delay(1000); // Allow servos to reach position

  servo1.detach();
  servo2.detach();
  servo3.detach();
  servo4.detach();

  waitStartTime = millis();
  motionWaiting = true;
}

void startMotion() {
  servo1.attach(9);
  servo2.attach(10);
  servo3.attach(3);
  servo4.attach(4);

  motionStartTime = millis();
  motionActive = true;
  motionWaiting = false;
}

void stopMotion() {
  if (!servo1.attached()) servo1.attach(9);
  if (!servo2.attached()) servo2.attach(10);
  if (!servo3.attached()) servo3.attach(3);
  if (!servo4.attached()) servo4.attach(4);

  servo1.write(offset);
  servo2.write(offset);
  servo3.write(offset);
  servo4.write(offset);

  delay(1000); 

  servo1.detach();
  servo2.detach();
  servo3.detach();
  servo4.detach();

  motionActive = false;
  motionWaiting = false;
}
