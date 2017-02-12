#include <Controllino.h>

/*=====================================================================================
ALP 'Sensor box' Controllino MAXI sketch.

Inputs (at 03/10/2016):
8x - Type K T/C comming from eDAM-8018 DAQ through RS485 channel.
2x - Pt100 comming from NOVUS TxRail-USB Temp. transmitter's via Analogue inputs 0-10V.
2x - Flows. IFM SD8000 flow sensr and OMRON D6F-W10A1 flow sensor. Analogue inputs.
1x - Pressure.
1x - Level sensor.

===================================================================================== */

// Global variables
String edamDAQresponse;

int pressure1, pressure2;
float flow1, flow2, flow3;
float pt100;
float waterTemp1;
float waterTempDS18B20;
float waterTemp1_raw;
int pellet_level = 0;

// Global variables used only in this header file:
String strPressure1, strPressure2;
String strFlow1, strFlow2, strFlow3;
String strPellet_level;
String line = "";

void setup() {
  // Initialisation of all the setups for different sensors: 
  digitalWrite(2, HIGH); // For level sensor Soliphant T FTM20 on one side of the Relay. The other side goes to A9 with a pull down resistor to GND. When triggered the relay closes and brings A9 high (connects to Digital Input pin 2).
  digitalWrite(3, HIGH); // Used as 24V supply pin to power the IFM SD8000 flow sensor.
  digitalWrite(45, HIGH); 
  Serial.begin(9600);
  Serial3.begin(9600);  // Serial port used for RS485.
  Controllino_RS485Init();  
  initServer();  
  initSensorDS18B20();  
}

void loop() {  
  
  sendRS485command("#01");  // The address of the eDAM8018 is '01'. Command '#01' is used to receive readings of all 8 channels.
  // USB output formating for the GUI. (The GUI takes each element as 'Comma separated value'.)
  processFlow();  
  processPressure();  
  processDepth();  
  processSensorDS18B20();
  
  // Ethernet TCP output formating for the GUI. Was better to send a whole line. Therefore saving all the readings in one line.
  strFlow1 = String(flow1, 2);
  strFlow2 = String(flow2, 2);
  strPressure1 = String(pressure1);
  strPressure2 = String(pressure2);
  strPellet_level = String(pellet_level, DEC);
  line = edamDAQresponse + "+" + waterTempDS18B20 + "+" + strFlow1 + "+" + strFlow2 + "+" + strPressure1 + "+" + strPressure2 + "+" + strPellet_level;
  processServer(); // Send the line to the client over the Ethernet network (to the GUI).*/
  Serial.print(line);
  //Serial.print("\n");
  delay(100);
}
