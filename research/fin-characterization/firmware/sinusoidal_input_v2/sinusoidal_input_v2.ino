#include <Servo.h>

Servo servo1;
Servo servo2;

// Sine wave parameters
float frequency = 1.9;   // Frequency in Hz
float amplitude = 30.0;  // Amplitude in degrees (max swing from center)
float offset = 90.0;     // Offset in degrees (center position of the servo)

// Timing variables
unsigned long previousMillis = 0;  // Stores the last time the servos were updated
const unsigned long updateInterval = 5;  // Update interval in milliseconds (~50Hz)

void setup() {
  // Attach the servos to their respective pins
  servo1.attach(9);   // Change the pin number if needed
  servo2.attach(10);  // Change the pin number if needed

  // Move servos to the initial position
  servo1.write(offset);
  servo2.write(offset);
}

void loop() {
  // Get the current time in milliseconds
  unsigned long currentMillis = millis();

  // Check if it's time to update the servos
  if (currentMillis - previousMillis >= updateInterval) {
    previousMillis = currentMillis;

    // Calculate the time in seconds
    float timeInSeconds = currentMillis / 1000.0;

    // Calculate the sine wave value
    float angle = amplitude * sin(2.0 * PI * frequency * timeInSeconds) + offset;

    // Constrain the angle to valid servo values (0 to 180 degrees)
    angle = constrain(angle, 0.0, 180.0);

    // Write the angle to the servos
    servo1.write(angle);
    servo2.write(angle);
  }
}
