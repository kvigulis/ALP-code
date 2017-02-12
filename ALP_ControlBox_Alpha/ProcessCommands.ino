
int channel;
int action;
int relayChannels[7] = {topValeve, bottomValve, vacuum, reactorIgnition, flareIgnition, waterPump, fans};

char motor;
char motorDirection;
String motorSpeedString;
int motorSpeedInt;
float motorSpeedFloat;

/* The incoming commands, either via USB or Ethernet are taken as strings of characters. For example, "X 5 0" of "S B + 30".
   The first character of the command stands for the type of command: 
      'X' is for ON/OFF relay commands.
      'S' is for changing motor speed and directon. (Stepper and Blower's VFD)                                            */

void processCommands(String command){
  /* Change relay channel state(ON/FF). [ Incoming command format: X 3 1    ---  for relay channel Three on.] 
                                                  String indexes: [0 2 4]                                  */ 
  if (command[0] == 'X'){                                        
    channel = command[2]-'0';               
    action = command[4]-'0';              //  added -'0' to convert the actual command[4] character/digit to int and not to the corresponding ASCII number.
    digitalWrite(relayChannels[channel], action);  
    Serial.print("Command sent. Channel  "); 
    Serial.print(channel);      
    Serial.print("  Action: ");
    Serial.println(action);                 
  } 
  else if (command[0] == 'S'){  
    /* Change motor speed (Used for Stepper and VFD blower.) [ Incoming command format: S S + 200   ---  for Stepper speed 200 steps/min clockwise]     
                                                                       String indexes: [0 2 4 678]                                               */
    motor = command[2]-'0';                 
    motorDirection = command[4];   
    motorSpeedString = command.substring(6,(command.length()));     // Read three charaters from sixth index which will stand for speed. 
    motorSpeedInt = atoi(motorSpeedString.c_str()); 
    motorSpeedFloat = (float)motorSpeedInt;
    if(motorSpeedInt<1){
      Timer3.stop();
    }
    else{
      frequency = period/motorSpeedInt;
      Timer3.start(); 
      Timer3.setPeriod(frequency);
      
    }
    if(motorDirection == '+'){
      digitalWrite(stepperDir, HIGH);
    }
    else if(motorDirection == '-'){
      digitalWrite(stepperDir, LOW);
    }
    Serial.print("Command sent. Dir  "); 
    Serial.print(motorDirection);      
    Serial.print("  Speed: ");
    Serial.println(motorSpeedInt);  
                                        
  }                                                  
}



