

void processPressure(void)
{
  // process pressure measurements  
  pressure1 = readPressureIFM(pressureIFM_pin);   // For getting a reading from the IFM PQ3809 Pressure Sensor.
  pressure2 = readPressure15PSI(pressureCheap15PSI_pin);  // For getting a reading from the Chinse 15 PSI Pressure Sensor.
}

int readPressureIFM(int pin)   
{
  int pressure10bit;
  float pressureVolts;
  int pressureBar;  

  pressure10bit = analogRead(pin);

  pressureVolts = pressure10bit * 26.4 / 1023.0;
  //Serial.println(pressureVolts);

  // The output of the IFM PQ3809 pressure sensor goes from 4mA to 20mA accross the full range of the pressure. 
  // There is a ~ 470 ohm resistor attached accros the Controllino's analog input to GND.
  // At pressure - 1000 bar the voltage is ~ 4 mA * 470 ohm = 1.88 Volts. 
  // After Controllino converion the voltage reading at 0bar = 4.88 Volts
  // The 'Analog end point' is at 1000 bar and the corresonding voltage for it is ~ 20mA * 470 ohm = 9.4 V.

  if (pressureVolts < 4.9)
  {
    pressureBar = 0.0;
  }
  else
  {
    pressureBar = 1000 * ((pressureVolts - 4.88) / 3);  // 9.4-4.88 = 4.52 V

  }
  return pressureBar;
}


// Following functions is for the 15psi/1000mbar Chinese pressure transducer.
const float minVolts = 0.52;
const float maxVolts = 4.52;

float readPressure15PSI(int pin)
  {
  int pressure10bit;
  float pressureVolts;
  int pressureBar; 

  // read voltage from analog pin
  //=============================
  pressure10bit = analogRead(pin);  // Output [Green wire]:  0.5-4.5V linear voltage output. 0 psi outputs 0.5V, 7.5 [500mbar] psi outputs 2.5V, 15 psi [1000mbar] outputs 4.5V.

  pressureVolts = pressure10bit * 5 / 1023.0;   

  // convert to pressure
  //====================
  if (pressureVolts < minVolts)
    pressureBar = 0;
  if (pressureVolts >= minVolts && pressureVolts <= maxVolts)
    pressureBar = 1000*(pressureVolts - minVolts)/4;     // 0psi=0.5V, 7.5psi=2.5V, 15psi=4.5V.    output[mbar] = 1000*(voltageReading-0.5)/4
  if (pressureVolts > maxVolts)
    pressureBar = 1000;  

  return pressureBar;
  }


/*
  float readPressure(int pin, int filter)
  {
  int i;
  float v;
  float volts;
  float pressure;

  // read voltage from analog pin
  //=============================
  v = updatePressure(pin,filter); //does not work for unknown reason


  if (verbose)
  {
    Serial.print("v[");
    Serial.print(pin);
    Serial.print("]: ");
    Serial.print(v);
  }

  // convert to voltage
  //===================
  volts = v*5*5.3/1023.0+0.1;  // Scalling (13.2/5) done because the Conrolline analogue inputs read from 0 to 13.2V if connected to a 12V power supply. Check in the 'Learning' section on their website.

  if (verbose)
  {
    Serial.print(" ");
    Serial.print(volts);
    Serial.print("volts");
  }

  // convert to pressure
  //====================
  if (volts < minVolts)
    pressure = 0;
  if (volts >= minVolts && volts <= maxVolts)
    pressure = ((volts - minVolts) * 25)*68.9476;
  if (volts > maxVolts)
    pressure = (100)*68.9476;
  if (verbose)
  {
    Serial.print(" pressure:");
    Serial.println(pressure);
  }

  return pressure;
  }
  // filtering output
  //===================
  //18/08/2016
  //
  //http://www.elcojacobs.com/eleminating-noise-from-sensor-readings-on-arduino-with-digital-filtering/

  float pressureActual;
  float y_pressureoutput[4][3], x_pressureinput[4][3];

  float updatePressure(int pin, int filter) {
  /*
    filter 2nd order
    sampling frequency 5hz
    cut off freqeuncy 0.03hz
    a numerator
    b denominator
    g gain
    x inputs
    y outputs
    y[2]=(b[1]*x[2]*g+b[2]*x[1]*g+b[3]*x[0]*g-a[2]*y[1]-a[3]*y[0])/a[1];

*/
/*
  float a[3], b[3], g;
  a[0] = 1;
  a[1] = -1.94669754075618;
  a[2] = 0.948081706106740;
  b[0] = 1;
  b[1] = 2;
  b[2] = 1;
  g = 3.460413376391039e-04;

  x_pressureinput[filter][0] = x_pressureinput[filter][1]; // only call once, or use different variables
  x_pressureinput[filter][1] = x_pressureinput[filter][2];
  int sum=0;
  int num=20;
  for (int i=0; i<num; i++){
  sum=sum+analogRead(pressurePins[pin]);
  }
  x_pressureinput[filter][2] = sum/num;

  y_pressureoutput[filter][0] = y_pressureoutput[filter][1];
  y_pressureoutput[filter][1] = y_pressureoutput[filter][2];
  y_pressureoutput[filter][2] = (b[0] * x_pressureinput[filter][2]*g + b[1] * x_pressureinput[filter][1] *g+ b[2] * x_pressureinput[filter][0]*g - a[1] * y_pressureoutput[filter][1] - a[2] * y_pressureoutput[filter][0]) / a[0];
  pressureActual = y_pressureoutput[filter][2];

  return pressureActual;

  }*/
