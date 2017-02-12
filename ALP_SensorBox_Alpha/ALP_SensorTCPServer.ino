

#include <SPI.h>
#include <Ethernet.h>

byte mac[] = {
    0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED
  };
IPAddress ip(169, 254, 240, 101);
  
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
    }
    
    if (client.available()) {
      server.print(line); 
    }
  }
}



