#include <Controllino.h>
#include <TimerThree.h>
/*=====================================================================================
ALP 'Control box' Controllino MAXI sketch.

Outputs (at 03/10/2016):
8x Digital outputs
1x Analogue PWM output

===================================================================================== */
float period = 1000000.0; // 1 Second = 10e6 uS
float frequency = 1.0;
String usbCommand;    // Command received through USB.
char incomingChar;     // Char received through Ethernet.
String ethernetCommand;   // The full command received through Ethernet. Each command ends with "!" (no quotes).
char comparator = '!';

void setup() {
  pinMode(13, OUTPUT);
  Timer3.initialize(250000);         // initialize timer1, and set a 1/2 second period
  Timer3.pwm(13, 512);                // setup pwm on pin 9, 50% duty cycle
  Timer3.attachInterrupt(callback);
  Timer3.stop();  
    // attaches callback() as a timer overflow interrupt
  Serial.begin(9600);
  initServer();
}

void callback()
{
  digitalWrite(13, digitalRead(13) ^ 1);
}

void loop() {  
  if (Serial.available() > 0) {    
    usbCommand = Serial.readString();
    processCommands(usbCommand);               
  }      
    
  processServer();     // Used to listen to new data from client(s). (In this case just the commands from GUI). 
  delay(50);  
}
 
