

#include <SPI.h>
#include <Ethernet.h>

byte mac[] = {
    0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xEE
  };
IPAddress ip(169, 254, 240, 102);
  
EthernetServer server(23);
boolean alreadyConnected = false; // whether or not the client was connected previously


void initServer() {

    // Enter a MAC address and IP address for your controller below.
  // The IP address will be dependent on your local network.
  // gateway and subnet are optional:
  
  
  // initialize the ethernet device
  Ethernet.begin(mac, ip);
  // start listening for clients
  server.begin();  
}

void processServer() {
  // wait for a new client:
  EthernetClient client = server.available();

  // when the client sends the first byte, say hello:
  if (client) {
    if (!alreadyConnected) {
      // clear out the input buffer:
      client.flush();      
      alreadyConnected = true;
      Serial.print("Client connected");
    }
    
    if (client.available()) {              
      incomingChar = client.read();
      
      ethernetCommand += incomingChar;
      if(incomingChar == 33){  // The GUI puts an ! after each command.  Number 33 stands for ! in ASCII code. 
        Serial.println(ethernetCommand);
        processCommands(ethernetCommand);
        ethernetCommand = "";
      }     
      
    }
  }
}





