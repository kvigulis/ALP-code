/*=============================================================================================
 Sketch to read the level sensor. 
 For meaning of pins us the Controllino MAXI's pinout. 
 Pinout link: http://controllino.biz/wp-content/uploads/2016/02/CONTROLLINO-MAXI-PINOUT-09-02-16.pdf 
=============================================================================================*/

bool levelActive;


void processDepth(void)
{  
  levelActive = digitalRead(pelletLevel_pin); //  Read the state of the level sensor pin.

  if (levelActive)
  {    
    pellet_level = 1;    
  }
  else
  {
    pellet_level = 0;
  }  
}

