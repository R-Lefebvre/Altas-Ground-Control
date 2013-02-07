/*
Altas Ground Control System
    By Robert Lefebvre
    
Adapted from RC Tx Program: RC Joystick PPM (8 channel)
  By Ian Johnston (www.ianjohnston.com)

Version V0.1 (7/2/2013
  
DISCLAIMER:
  With this design, including both the hardware & software I offer no guarantee that it is bug
  free or reliable. So, if you decide to build one and your plane, quad etc crashes and/or causes
  damage/harm to you, others or property then you are on your own. This work is experimental.

INFORMATION:
  See ReadMe.txt for lots of info including I/O allocation.  
*/

#include "EEPROM.h"

char* Version[]={"Version", "  0.1   "};

// User adjustable settings
int pulseMin = 700, pulseMid = 1200, pulseMax = 1700;	        // PPM Pulse widths in uS
float RateMultLO = 0.5, RateMultMI = 0.75, RateMultHI = 1.0;    // Rates LO, MI & HI multipliers

// RAW inputs (range is 0-1023 for 10-bit analogue inputs). If your analogue inputs don't quite start
// at 0vdc, or don't quite hit the 5vdc max then you can tweak the ranges here for best operation.
// You can also specify the centre positions for the AEL/ELE/RUD sticks.
int AEL_Min = 0,  AEL_Center = 512, AEL_Max = 1023;             // Aeleron
int ELE_Min = 0,  ELE_Center = 512, ELE_Max = 1023;             // Elevator
int RUD_Min = 0,  RUD_Center = 512, RUD_Max = 1023;             // Rudder
int THR_Min = 27, THR_Max = 1015;                               // Throttle (customized for IanJ's stick)
int AUX_Min = 0,  AUX_Max = 1023;                               // Aux pot
int AUX2_Min = 0, AUX2_Max = 1023;                              // Aux2 pot

// Assign analogue & digital I/O pins
int AI_Raw[7] = { 0, 1, 2, 3, 4, 5, 6 };                // actual analog input pins
int AI_Val[7];                                          // analogue input vars
int DI_Raw[10] = { 2, 3, 4, 5, 6, 7, 8, 9, 13, 11 };    // actual digital input pins
int DI_Val[10];                                         // digital input vars
unsigned char AI_pincount = 7;   // analogue pin count
unsigned char DI_pincount = 10;  // digital pin count
unsigned char outPinPPM = 10;    // PPM output pin (do not change - pin 10 tied to ISR)
unsigned char outPinBuzz = 12;   // Buzzer output pin

// Various vars
float RateMult;
int AI_Auxpot, AI_Auxpot2, AI_Throt, AI_Rudde, AI_Eleva, AI_Aeler, Auxsw_uS, Auxsw2_uS;
int DI_Onup_a = 0, DI_Onup_b = 0, DI_Onup_c = 0, DI_Onup_d = 0;

// Mode vars
int ChangeModeHIMIDLO = 0, ChangeMode = 0;
int trimMax = 75, trimMin = (~trimMax)+1;         // Trim limits +/- (Important: max = 127)
int Offset;
int ModeTest = 0, ElevonMode = 0, ExpoModeAEL = 0, ExpoModeELE = 0, ExpoModeRUD = 0, Timermode = 0, ModeDispSet = 0;
int ReverseAeleron = 0, ReverseElevator = 0, ReverseRudder = 0;
char* MenuDisplay[]={"        ", "AEL Trim", "ELE Trim", "RUD Trim", "ELEVON  ", "EXPO-AEL", "INVERT  ", "TESTMODE", "RAW&PPM ", "EXPO-ELE", "EXPO-RUD", "EXPO-OFF"};

// EEprom vars
int RatesHIMIDLOEEprom = 1;
int TrAelEEprom = 0, TrEleEEprom = 0, TrRudEEprom = 0, EpromPointer = 0;
int Epromvar, Address;

// Buzzer vars
long previousMillis = 0;         
unsigned long currentMillis;
unsigned char buzzeractivate = 0;

// Sub timing vars
int tick0 = 0, tick1 = 0, tick2 = 0, tick3 = 0;
unsigned char slowflag;

// Manual Timer, Interrupt Timer vars
unsigned char TimerStart = 0;    
int secflag = 0, minflag = 0;
int PPM_array[9];
int PPMFreq_uS = 22500;          // PPM frame length total in uS
int Fixed_uS = 300;              // PPM frame padding LOW phase in uS


// *********************** Setup **************************
void setup() {

  // Setup Digital I/O
  pinMode(outPinPPM, OUTPUT);   // sets as output
  pinMode(outPinBuzz, OUTPUT);  // sets as output
  for(char i=0; i<DI_pincount; i++) { pinMode(DI_Raw[i], INPUT); }      // set digital inputs
  for(char i=0; i<DI_pincount; i++) { digitalWrite(DI_Raw[i], HIGH); }  // turn on pull-up resistors

  // Beep-Beep
  digitalWrite(outPinBuzz, HIGH);
  delay(50);
  digitalWrite(outPinBuzz, LOW);
  delay(50);
  digitalWrite(outPinBuzz, HIGH);
  delay(50);
  digitalWrite(outPinBuzz, LOW);
  
  // Initialize PPM channel array
  char i=0;
  for(i=0; i<8; i++) { PPM_array[i] = pulseMin; }
  PPM_array[i] = -1;   // Mark end

  // Initialise ISR Timer 1 - PPM generation
  TCCR1A = B00110001;  // Compare register B used in mode 3
  TCCR1B = B00010010;  // WGM13 & CS11 set to 1
  TCCR1C = B00000000;  // All set to 0
  TIMSK1 = B00000010;  // Interrupt on compare B
  TIFR1  = B00000010;  // Interrupt on compare B
  OCR1A = PPMFreq_uS;  // PPM frequency
  OCR1B = Fixed_uS;    // PPM off time (lo padding)
  
  // Initialise ISR Timer 2 - Subroutine timing
  // Interrupt rate =  16MHz / (prescaler * (255 - TCNT2))
  // period [sec] = (1 / f_clock [sec]) * prescale * (255-count)
  //                (1/16000000)  * 1024 * (255-178) = .004992sec = 4.992mS
  TCCR2B = B00000000;   // Disable Timer2 while we set it up
  TCNT2  = 178;         // Reset Timer Count  (255-"178")
  TIFR2  = B00000000;   // Timer2 INT Flag Reg: Clear Timer Overflow Flag
  TIMSK2 = B00000001;   // Timer2 INT Reg: Timer2 Overflow Interrupt Enable
  TCCR2A = B00000000;   // Timer2 Control Reg A: Wave Gen Mode normal
  TCCR2B = B00000111;   // Timer2 Control Reg B: Timer Prescaler set to 1024
 
  // Run Various Setup subs
  LCDSetup();                      // Initialize Serial LCD - Baud, initial settings and write opening message
  HiMiLoRatesSetup();              // Pull Rates & Trim settings from EEprom
  ElevonModeSetup();               // Pull Elevon Mode from EEprom
  ExpoModeSetup();                 // Pull AEL, ELE & RUD Expo Mode from EEprom
  InvertChannelsSetup();           // Pull AEL Invert Mode from EEprom
   
  // Other
  currentMillis = millis();        // Prepare keypress buzzer timing
  previousMillis = millis();
}


// *********************** Main Loop **************************
void loop() { // Main loop

  buzzer();                      // Refresh buzzer
  readanalogue();                // Read analogue I/O
  checklimitsmodessetouputs();

  if (tick0 >= 25) {             // Run these subs every 124.8mS
	  tick0 = 0;
	  readdigital();             // Read digital I/O
      HiMiLoRates();             // Rates
	  TrimSettings();            // Trims
	  ElevonExpoMode();          // Elevon & Exponential Modes
	  InvertChannels();          // Invert Channels
	  batterymonitor();          // Battery check
	  ModeTesting();             // Mode Test
	  TimerDisplay();            // Timer
  }
  
  // Generate slow changing flag
  if (tick1 <= 50) {
	  slowflag = 0;
  }
  if (tick1 >= 50 && tick1 <=100) {
	  slowflag = 1;
  }
  if (tick1 >= 100) {
	  slowflag = 0;
	  tick1 = 0;
  } 
  
  // generate 1sec tick
  if (TimerStart == 0) {
      if (tick2 >= 160) {  // 1000mS
	      secflag++;
	      tick2 = 0;
      } 
      if (secflag >= 60) {
	      secflag = 0;
	      minflag++;
      }  
      if (minflag >= 100) {
	      minflag = 0;
      }
  }  

}
