/*    This header is used to send commands to the eDAM-8018 DAQ unit. 
 *  Normally used just to receive the DAQ's response with the readings 
 *  of the type K Thermocouples. But any command can be sent. E.g. to  
 *  configure the DAQ. For the command meanings look in the manufactu-
 *  rers datasheet.                                                   */


#include <SPI.h>
char commandChar;


void sendRS485command(String command){
  
  DDRJ = DDRJ | B01100000;
  PORTJ = PORTJ & B10011111;  // Look in the Controllino RS485 example code.
  PORTJ = PORTJ | B01100000;  
  delay (10);
      
  for (int i=0; i < command.length(); ++i) {      
     
    Serial3.print(command[i]);    
    delay (10);    
  }  
  Serial3.write(13);
  Serial.print("\n");  /*  <---- !!! This is really weird. Had troble making the RS485 response work, but discovered that it will work adding by 'Serial.print("\n");' or 'Serial.println();' at this line. It does not make sense. 
                                     But if YOU whoever is reading this know why this is so, please let me know on: k.vigulis@alp-technologies.com                                                                    */
  PORTJ &= B10011111; 
  delay (10);  
  while (Serial3.available())
  {   // To clear the serial buffer so that the command would not be read back to "Serial" terminal. After cleared wait 100ms till the buffer is filled with the DAC's response. Then save it in a String variable.
    Serial3.read();
  }
  delay(100);
  edamDAQresponse = "";
  while (Serial3.available()>1) 
  {
    edamDAQresponse += (char)Serial3.read();   
  } 
  while (Serial3.available()) 
  {
    Serial3.read();   
  }  
  //Serial.print(edamDAQresponse);   
}
