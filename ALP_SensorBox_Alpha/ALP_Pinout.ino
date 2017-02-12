/* Attention! : for connections to ribbon cable breakout board please consider the maximum current limit. Absolute max per pin 40mA, recommended 20mA; Absolute max 200mA for entire Pin Header. 
 *  Look at the Controllino Pinout diagram: https://controllino.biz/wp-content/uploads/2016/02/CONTROLLINO-MAXI-PINOUT-09-02-16.pdf */

#define pelletLevel_pin A10 // Add resistor > 1K Ohm from this pin to 5V.
#define flowIFM_pin A8    // Add resistor 470 Ohm from this pin to GND.
#define pressureIFM_pin A7  // Add resistor 470 Ohm from this pin to GND.
#define pressureCheap15PSI_pin A11  // Chinese 15 psi / 1000 mbar Gauge pressure sensor. 5V supply. Output [Green wire]: 0.5-4.5V linear voltage output. 0 psi outputs 0.5V, 7.5 psi outputs 2.5V, 15 psi outputs 4.5V.

#define DS18B20_pin 19  /*  Accessed through ribbon cable breakout board (GRAVITECH.US DB25 MALE BREAKOUT BOARD). 
                            Connect DS18B20 yellow wire to Controllino's 'Interrupt 0', which is pin 9 on the breakout board.
                            Put a 4.7 K Ohm pull up restistor to 5Vdc, which is Pin 1 on the breakout board.
                            Links for clarificaion: http://controllino.biz/wp-content/uploads/2016/02/CONTROLLINO-MAXI-PINOUT-09-02-16.pdf
                                                    http://www.tweaking4all.com/wp-content/uploads/2014/03/ds18b20-normal-power.jpg           */

