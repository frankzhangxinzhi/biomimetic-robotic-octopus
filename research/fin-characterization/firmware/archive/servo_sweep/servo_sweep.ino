#include <Servo.h>

Servo servo1;
Servo servo2;

int pos = 90;
int i = 0;
int secs = 15;

void setup() {

  servo1.attach(10);  // attaches the servo on pin 10 to the servo object
  servo2.attach(9);  // attaches the servo on pin 9 to the servo object
  servo1.write(30);
  servo2.write(30);
  delay(15000);
}


void loop() {

    for (pos = 0; pos <= 60; pos += 1) { // goes from 0 degrees to 180 degrees

	// in steps of 1 degree


	servo1.write(60 - pos);          	// tell servo to go to position in variable 'pos'
	//delay(1.75);
	servo2.write(pos);          	// tell servo to go to position in variable 'pos'
	//delay(1.75);

	delay(3.5);                   	// waits 2ms for the servo to reach the position

  }

  for (pos = 60; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees


    
  	servo1.write(60 - pos);          	// tell servo to go to position in variable 'pos'
	//delay(1.75);
	servo2.write(pos);          	// tell servo to go to position in variable 'pos'
	//delay(1.75);

	delay(3.5);                   	// waits 2ms for the servo to reach the position

  }



}
