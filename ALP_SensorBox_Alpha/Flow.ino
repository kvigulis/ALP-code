/*=============================================================================================
Flow sensor D6F-W10A1 
Datasheet link: https://www.omron.com/ecb/products/pdf/en-d6f_w.pdf

Supply 12 V DC 15 mA

output
m/s volts
0   1.00
2   1.94
4   3.23
6   4.25
8   4.73
10  5.00

min  max  flow/volt
1.00 1.94 0.47
1.94 3.23 0.645 
3.23 4.25 0.51
4.25 4.73 0.24
4.73 5.00 0.135

calculation from velocity [m/s]to volume flow [Nm3/h]is with factor=POW(0.08/2,2)*3.1415926*3600

=============================================================================================
connector

---------
|       |
| 1 2 3 |
|-------|

1 = Vcc
2 = Vout
3 = Ground

=============================================================================================*/

int flowPins[2] = {flowIFM_pin, A3};

#define flowPointCountomron 20
float flowPointsomron[flowPointCountomron] = {  2.8  ,
4.7 ,
6.7 ,
8.5 ,
10.1  ,
12.2  ,
14.0  ,
15.9  ,
18.2  ,
20.4  ,
21.6  ,
23.2  ,
24.9  ,
26.9  ,
29.2  ,
32.3  ,
72.4  ,
108.6 ,
144.8 ,
181.0 
};
//points 1-16 are from measurements with IFM sensor, 17-20 are calculated from the datasheet
float voltagePointsomron[flowPointCountomron] = {0.98 ,
1.01  ,
1.07  ,
1.14  ,
1.21  ,
1.30  ,
1.41  ,
1.52  ,
1.65  ,
1.77  ,
1.88  ,
1.99  ,
2.11  ,
2.21  ,
2.34  ,
2.51  ,
3.23  ,
4.25  ,
4.73  ,
5 
};
//points 1-16 are from measurements with IFM sensor, 17-20 are calculated from the datasheet

#define flowPointCount 6
float flowPoints[flowPointCount]= {  2.2, 9.8, 17.2,24.5, 32.4, 61.3
};

float voltagePoints[flowPointCount] = {194,207,212,215,219,229};
//points 1-10 are from measurements (median) with IFM sensor


void processFlow(void)
{
  // process flow measurements
  //==========================
  flow1 = readFlowIFM(0,3);   
  flow2 = readFlowOmron(1, 0);
  
}

float readFlowIFM(int pin, int filter)
{
  float volts;
  int volts_volts;
  float flow;
  int out;
  
  volts_volts = analogRead(A8);
  
  volts = volts_volts*26.4/1023.0;  
  
  // The output of the IFM flow sensor goes from 4mA to 20mA accross the full range of the flow. The manual states the output is linear acrros the flow range.
  // There is a 470 ohm resistor soldered accros the Controllino's analog input. 
  // Therfore at flow 0 m^3/h the voltage is 4 mA * 470 ohm = 1.88 Volts. (Has been tweaked a little to match the reading on LCD)
  // The 'Analog end point'(see IFM SD8000 manual) is set at 225 m^3/h and the corresonding voltage for it is 20mA * 470 ohm = 9.4 V. 
   
  if(volts < 1.6)
  {
    flow = 0.0;
  }
  else 
  {
    flow = 225.0*((volts-1.5)/7.3);
     
  }
  return flow;
}


float readFlowOmron(int pin, int filter)
{
  int i;
  int v;
  float volts;
  float flow;
  
  // read filtered! voltage from analog pin 
  //=============================
  v=updateVoltageSlow(pin, filter);  
  

  // convert to voltage
  //===================
  volts = v * 5.0 / 1023;  

  // convert to flow
  //================
  if (volts < voltagePointsomron[0])
    flow = 0.0;
  else if (volts >= voltagePointsomron[flowPointCountomron-1])
    flow = flowPointsomron[flowPointCountomron-1];
  else
  {
    for (i=0; i<flowPointCountomron-1; i++)
    {
      if (volts >= voltagePointsomron[i] && volts < voltagePointsomron[i+1])
      {
        flow = flowPointsomron[i] + (flowPointsomron[i+1] - flowPointsomron[i] )* (volts - voltagePointsomron[i])/(voltagePointsomron[i+1] - voltagePointsomron[i]);        
        break;
      }
    }
  }  

  return flow;
}

/*==========================================================================================
    Description:     
    Functions to read filtered the analogue inputs with Digital filtering. 
    Read more on: http://www.elcojacobs.com/eleminating-noise-from-sensor-readings-on-arduino-with-digital-filtering/  
   
    filter 2nd order
    sampling frequency 5hz (every 200ms)
    cut off freqeuncy 0.06hz
    a numerator
    b denominator
    g gain
    x inputs
    y outputs
    y[2]=(b[1]*x[2]*g+b[2]*x[1]*g+b[3]*x[0]*g-a[2]*y[1]-a[3]*y[0])/a[1]; 
==========================================================================================*/  
  
float voltageActualSlow[4],voltageActualFast[4];
float y_flowoutput[4][3], x_flowinput[4][3];
  
float updateVoltageSlow(int pin,int filter) {
  
    float a[3], b[3], g;
    a[0] = 1;
    a[1] = -1.89346414636183;
    a[2] = 0.898858994155253;
    b[0] = 1;
    b[1] = 2;
    b[2] = 1;
    g = 0.001348711948356;

    x_flowinput[filter][0] = x_flowinput[filter][1];
    x_flowinput[filter][1]= x_flowinput[filter][2];
    x_flowinput[filter][2] = analogRead(flowPins[pin]);

    y_flowoutput[filter][0] = y_flowoutput[filter][1];
    y_flowoutput[filter][1] = y_flowoutput[filter][2];
    y_flowoutput[filter][2] = (b[0] * x_flowinput[filter][2]*g + b[1] * x_flowinput[filter][1] *g+ b[2] * x_flowinput[filter][0]*g - a[1] * y_flowoutput[filter][1] - a[2] * y_flowoutput[filter][0]) / a[0];
    voltageActualSlow[filter] = y_flowoutput[filter][2];

    return voltageActualSlow[filter];
  }

float updateVoltageFast(int pin,int filter) {
  
  float a[3], b[3], g;
  a[0] = 1;
  a[1] = -0.369527377351241;
  a[2] = 0.195815712655833;
  b[0] = 1;
  b[1] = 2;
  b[2] = 1;
  g = 0.206572083826148;

  x_flowinput[filter][0] = x_flowinput[filter][1];
  x_flowinput[filter][1]= x_flowinput[filter][2];
  x_flowinput[filter][2] = analogRead(flowPins[pin]);

  y_flowoutput[filter][0] = y_flowoutput[filter][1];
  y_flowoutput[filter][1] = y_flowoutput[filter][2];
  y_flowoutput[filter][2] = (b[0] * x_flowinput[filter][2]*g + b[1] * x_flowinput[filter][1] *g+ b[2] * x_flowinput[filter][0]*g - a[1] * y_flowoutput[filter][1] - a[2] * y_flowoutput[filter][0]) / a[0];
  voltageActualFast[filter] = y_flowoutput[filter][2];

  return voltageActualFast[filter];

}
