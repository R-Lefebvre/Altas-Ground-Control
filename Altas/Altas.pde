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

#include <EEPROMEx.h>
#include "defines.h"
#include "config.h"

char* Version[]={"Version", "  0.1   "};

// Assign analogue & digital I/O pins
int AI_Pin[7] = {                       // actual analog input pins
    ROLL_GIMBAL_PIN,
    PITCH_GIMBAL_PIN,
    THROTTLE_GIMBAL_PIN,
    YAW_GIMBAL_PIN,
    CH6_POT_PIN,
    CH8_POT_PIN,
    V_BATT_PIN
};                

int AI_Val[7];                          // analogue input vars

int DI_Raw[DIGITAL_INPUT_PINCOUNT] = { 
    MFD_BUTTON_MODE_PIN,                    //0
    HAT_SWITCH_UP_PIN,                      //1
    HAT_SWITCH_DOWN_PIN,                    //2
    MFD_BUTTON_BACK_PIN,                    //3
    HAT_SWITCH_LEFT_PIN ,                   //4
    HAT_SWITCH_RIGHT_PIN,                   //5
    MFD_BUTTON_ENTER_PIN,                   //6
    AUX1_SWITCH_PIN,                        //7
    AUX2_SWITCH_PIN,                        //8
    CH7_SWITCH_PIN,                         //9
    CH8_SWITCH_PIN                          //10
};    // actual digital input pins



int DI_Val[DIGITAL_INPUT_PINCOUNT];                                         // digital input vars

// Various vars
float RateMult;
int AI_Auxpot1, AI_Auxpot2, AI_Throt, AI_Rudde, AI_Eleva, AI_Aeler, Auxsw_uS, Auxsw2_uS;
int DI_Onup_a = 0, DI_Onup_b = 0, DI_Onup_c = 0, DI_Onup_d = 0;

bool FMB_State[7]; 
bool FMB_State_Old[7];
bool FMB_State_Falling[7];
int Active_Flight_Mode = DEFAULT_ACTIVE_FLIGHT_MODE;
int Old_Flight_Mode =  0;
int Active_Flight_Mode_PWM;

int Flight_Mode_Inputs[] = {
    0,
    FLIGHT_MODE_1_INPUT,
    FLIGHT_MODE_2_INPUT,
    FLIGHT_MODE_3_INPUT,
    FLIGHT_MODE_4_INPUT,
    FLIGHT_MODE_5_INPUT,
    FLIGHT_MODE_6_INPUT
};

int Flight_Mode_PWM[] = {
    0,
    FLIGHT_MODE_1,
    FLIGHT_MODE_2,
    FLIGHT_MODE_3,
    FLIGHT_MODE_4,
    FLIGHT_MODE_5,
    FLIGHT_MODE_6
};

int Flight_Mode_LED[] = {
    0,
    FLIGHT_MODE_1_LED_PIN,
    FLIGHT_MODE_2_LED_PIN,
    FLIGHT_MODE_3_LED_PIN,
    FLIGHT_MODE_4_LED_PIN,
    FLIGHT_MODE_5_LED_PIN,
    FLIGHT_MODE_6_LED_PIN,
};

// Mode vars
int ModeDispSet = 0;


// Buzzer vars
long previousMillis = 0;         
unsigned char buzzeractivate = 0;

// Sub timing vars
int tick0 = 0, tick1 = 0, tick2 = 0, tick3 = 0;
unsigned char slowflag;

// Manual Timer, Interrupt Timer vars
bool timer1_running = true;
bool timer2_running = false;   
int timer1_seconds = 0, timer1_minutes = 0;

int PPM_array[9];

byte active_model_num;
bool ToDo = 0;

struct model_struct {
    byte model_name[20];
    bool channel_reverse[8];
    int trim[4];
    int expo_high[4];
    int expo_low[4];
    byte dual_rate[4];
    int EP_high[8];
    int EP_low[8];
    byte timer2_min;
    byte timer2_sec;    
} active_model, peek_model; 




// *********************** Setup **************************
void setup() {

    Serial.begin(19200);                                            // For Serial Debugging
    init_input_output();                                            // Function to initialize the Input/Output
    bulb_check(1);
    init_beep();                                                    // Function to beep twice on boot-up
    init_PPM_array();                                               // Function to initialize the PPM Channel Array
    init_PPM_gen();                                                 // Function to initialize the PPM Generator
    ParallaxLCDSetup();
    EEPROM_Setup();
    previousMillis = millis();
    bulb_check(0);
    digitalWrite (Flight_Mode_LED[Active_Flight_Mode], HIGH);
}


// *********************** Main Loop **************************
void loop() { // Main loop

  buzzer();                      // Refresh buzzer
  readanalogue();                // Read analogue I/O
  control_flight_mode();
  checklimitsmodessetouputs();

  if (tick0 >= 25) {             // Run these subs every 124.8mS
	  tick0 = 0;
	  readdigital();             // Read digital I/O
	  batterymonitor();          // Battery check
	  Display();            // Timer
      
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
  
    if (tick2 >= 160) {  // 1000mS
        if (timer1_running) {
            timer1_seconds++;
        }
        if (timer2_running){
            active_model.timer2_sec--;
        }
	    tick2 = 0;
    } 
    if (timer1_seconds >= 60) {
	    timer1_seconds = 0;
	    timer1_minutes++;
    }  
    if (timer1_minutes >= 100) {
	    timer1_minutes = 0;
        
    }
    if (active_model.timer2_sec < 0) {
	    active_model.timer2_sec = 59;
	    active_model.timer2_min--;
    }  
    if (active_model.timer2_min < 0) {
	    active_model.timer2_min = 8;
    }
}  
