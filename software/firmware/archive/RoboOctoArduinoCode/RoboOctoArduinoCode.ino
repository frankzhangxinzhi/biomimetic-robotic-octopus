#include <Servo.h>
Servo servo1;
Servo servo2;
Servo servo3;
Servo servo4;
// Sine wave parameters
float frequency = 1.9;   // Frequency in Hz
float amplitude = 30.0;  // Amplitude in degrees (max swing from center)
float offset = 90.0;     // Offset in degrees (center position of the servo)

// Timing variables
unsigned long previousMillis = 0;  // Stores the last time the servos were updated
const unsigned long updateInterval = 5;  // Update interval in milliseconds (~50Hz)

// Motion control variables
unsigned long motionStartTime = 0;           // When motion started
const unsigned long motionDuration = 60000;  // 1 minute in ms
bool motionActive = true;

void setup() {
  // Attach the servos to their respective pins
  delay(10000);
  servo1.attach(9);   // Change the pin number if needed
  servo2.attach(10);  // Change the pin number if needed
  servo3.attach(3);
  servo4.attach(4);
  // Move servos to the initial position
  servo1.write(offset);
  servo2.write(offset);
  servo3.write(offset);
  servo4.write(offset);
  motionStartTime = millis();
}

void loop() {
  if (motionActive && millis() - motionStartTime >= motionDuration) {
    motionActive = false;

    // Optional: detach servos to cut power
    servo1.detach();
    servo2.detach();
    servo3.detach();
    servo4.detach();

  }
// If motion is active, continue sine wave motion
  if (motionActive) {
    unsigned long currentMillis = millis();
    if (currentMillis - previousMillis >= updateInterval) {
      previousMillis = currentMillis;

      // Time in seconds
      float timeInSeconds = currentMillis / 1000.0;

      // Sine wave angle calculation
      float angle = amplitude * sin(2.0 * PI * frequency * timeInSeconds) + offset;
      angle = constrain(angle, 0.0, 180.0);  // Ensure it's a valid servo angle

      // Apply to all servos
      servo1.write(angle);
      servo2.write(angle);
      servo3.write(angle);
      servo4.write(angle);
    }
  }
}