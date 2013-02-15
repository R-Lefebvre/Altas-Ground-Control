/*
Altas Ground Control System
    By Robert Lefebvre
    
Adapted from RC Tx Program: RC Joystick PPM (8 channel)
  By Ian Johnston (www.ianjohnston.com)

Version V0.1 (7/2/2013)
  
DISCLAIMER:
  With this design, including both the hardware & software I offer no guarantee that it is bug
  free or reliable. So, if you decide to build one and your plane, quad etc crashes and/or causes
  damage/harm to you, others or property then you are on your own. This work is experimental.

INFORMATION:
  See ReadMe.txt for lots of info including I/O allocation.  
*/

#include "EEPROM.h"
#include "defines.h"
#include "config.h"

char* Version[]={"Version", "  0.1   "};

// Assign analogue & digital I/O pins
int AI_Raw[7] = { 0, 1, 2, 3, 4, 5, 6 };                // actual analog input pins
int AI_Val[7];                                          // analogue input vars
int DI_Raw[10] = { MFD_BUTTON_MODE_PIN, 3, 4, 5, 6, 7, 8, 9, 13, 11 };    // actual digital input pins
int DI_Val[10];                                         // digital input vars

// Various vars
float RateMult;
int AI_Auxpot, AI_Auxpot2, AI_Throt, AI_Rudde, AI_Eleva, AI_Aeler, Auxsw_uS, Auxsw2_uS;
int DI_Onup_a = 0, DI_Onup_b = 0, DI_Onup_c = 0, DI_Onup_d = 0;

// Mode vars
int ChangeModeHIMIDLO = 0, ChangeMode = 0;
int trimMax = 75, trimMin = (~trimMax)+1;         // Trim limits +/- (Important: max = 127)
int Offset;
int ExpoModeAEL = 0, ExpoModeELE = 0, ExpoModeRUD = 0, Timermode = 0, ModeDispSet = 0;
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


// *********************** Setup **************************
void setup() {

  init_input_output();             // Function to initialize the Input/Output
  bulb_check(1);
  init_beep();                     // Function to beep twice on boot-up
  init_PPM_array();                // Function to initialize the PPM Channel Array
  init_PPM_gen();                  // Function to initialize the PPM Generator
  Serial.begin(19200);             // For Serial Debugging
  ParallaxLCDSetup();
  HiMiLoRatesSetup();              // Pull Rates & Trim settings from EEprom
  ExpoModeSetup();                 // Pull AEL, ELE & RUD Expo Mode from EEprom
  InvertChannelsSetup();           // Pull AEL Invert Mode from EEprom   
  currentMillis = millis();        // Prepare keypress buzzer timing
  previousMillis = millis();
  bulb_check(0);
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
	  ExpoMode();                // Exponential Modes
	  InvertChannels();          // Invert Channels
	  batterymonitor();          // Battery check
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
          serial_debug();
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
