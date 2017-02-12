/* To read the DS18B20 one wire temperature probes. */
#include <OneWire.h>
#include <DallasTemperature.h>

OneWire oneWire(DS18B20_pin);
DallasTemperature DS18B20sensors(&oneWire);
DeviceAddress Probe01 = { 0x28, 0xFF, 0x56, 0xC1, 0x74, 0x16, 0x03, 0x22 }; 

void initSensorDS18B20(){  
  DS18B20sensors.begin();
  DS18B20sensors.setResolution(Probe01, 10);
}

void processSensorDS18B20()
{
  // call sensors.requestTemperatures() to issue a global temperature
  // request to all devices on the bus  
  DS18B20sensors.requestTemperatures(); // Send the command to get temperatures  
  waterTempDS18B20 = DS18B20sensors.getTempC(Probe01); 
    // You can have more than one IC on the same bus.     
}

