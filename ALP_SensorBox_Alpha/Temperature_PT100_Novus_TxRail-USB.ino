/* To read the PT100 temperature probes. Read the 0-10Vdc output from Novus TxRail-USB and convert it to degrees celsius.
    10V will mean 100 degrees C which we will set in the Novus's settings.*/

void processPT100()
{
  waterTemp1_raw = analogRead(A0);
  waterTemp1 =  waterTemp1_raw*13.2/1023*10;  // The '*13.2/1023' converts to voltage and the '*10' at the end converts the 10V to 100C. Need to set 0V = 0C and 10V = 100C in the Novus unit.
}

