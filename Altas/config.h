#ifndef __ARDUCOPTER_CONFIG_H__
#define __ARDUCOPTER_CONFIG_H__

#include "defines.h"

// Hardware Definitions
// Outputs:
#define PPM_OUTPUT_PIN          12

// Ch5 Flight Mode LEDs
#define FLIGHT_MODE_1_LED_PIN   26
#define FLIGHT_MODE_2_LED_PIN   28
#define FLIGHT_MODE_3_LED_PIN   30
#define FLIGHT_MODE_4_LED_PIN   36
#define FLIGHT_MODE_5_LED_PIN   34
#define FLIGHT_MODE_6_LED_PIN   32

#define CH7_SWITCH_LED_PIN      38
#define CH8_SWITCH_LED_PIN      40
#define PIEZO_OUTPUT_PIN        42

// Inputs:

#define ROLL_GIMBAL_PIN         0
#define PITCH_GIMBAL_PIN        1
#define THROTTLE_GIMBAL_PIN     2
#define YAW_GIMBAL_PIN          3
#define CH6_POT_PIN             4
#define CH8_POT_PIN             5
#define V_BATT_PIN              6

// RAW inputs (range is 0-1023 for 10-bit analogue inputs). If your analogue inputs don't quite start
// at 0vdc, or don't quite hit the 5vdc max then you can tweak the ranges here for best operation.
// You can also specify the centre positions for the AEL/ELE/RUD sticks.
#define ROLL_MIN        0
#define ROLL_MID        512
#define ROLL_MAX        1023
#define PITCH_MIN       0
#define PITCH_MID       512
#define PITCH_MAX       1023
#define YAW_MIN         0
#define YAW_MID         512
#define YAW_MAX         1023
#define THROTTLE_MIN    0
#define THROTTLE_MAX    1023
#define CH6_MIN         0
#define CH6_MAX         1023
#define CH8_MIN         0
#define CH8_MAX         1023


// Button/Switch input pins.  These are the ones to move if you want to change button functionality
// or have a wiring problem.
#define HAT_SWITCH_UP_PIN       45
#define HAT_SWITCH_DOWN_PIN     47
#define HAT_SWITCH_LEFT_PIN     48
#define HAT_SWITCH_RIGHT_PIN    49
#define MFD_BUTTON_BACK_PIN     42
#define MFD_BUTTON_ENTER_PIN    44
#define MFD_BUTTON_MODE_PIN     46
#define CH7_SWITCH_PIN          39
#define THR_SWITCH_PIN          41
#define AUX1_SWITCH_PIN         23
#define AUX2_SWITCH_PIN         25

// Digital Pin Enumeration
#define MFD_BUTTON_MODE_NUM     0
#define HAT_SWITCH_UP_NUM       1
#define HAT_SWITCH_DOWN_NUM     2
#define MFD_BUTTON_BACK_NUM     3
#define HAT_SWITCH_LEFT_NUM     4
#define HAT_SWITCH_RIGHT_NUM    5
#define MFD_BUTTON_ENTER_NUM    6
#define AUX1_SWITCH_NUM         7
#define AUX2_SWITCH_NUM         8
#define CH7_SWITCH_NUM          9
#define THR_SWITCH_NUM          10

// Ch5 Flight Mode Button Inputs
#define FLIGHT_MODE_1_INPUT     27
#define FLIGHT_MODE_2_INPUT     29
#define FLIGHT_MODE_3_INPUT     31
#define FLIGHT_MODE_4_INPUT     37
#define FLIGHT_MODE_5_INPUT     35
#define FLIGHT_MODE_6_INPUT     33

#define ANALOG_INPUT_PINCOUNT   7
#define DIGITAL_INPUT_PINCOUNT  11

// Throttle Switch Functions
#define THR_SWITCH_NO_FUNC      0
#define THR_STICK_HOLD          1
#define THR_ON_CH8_HOLD         2
#define THR_SAFETY_OFFSET       10

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  PPM SETTINGS
//
// PPM Stream Generation
#define PPM_FREQUENCY           22500           // PPM frame length total in uS
#define PPM_CHANNEL_SPACING     300             // PPM frame padding LOW phase in uS

// Basic Endpoints.  These can be moved around with adjustable endpoints.
#define PWM_MIN     1100
#define PWM_MID     1500
#define PWM_MAX     1900

// Absolute Channel Endpoints.  Input/Output CANNOT go above or below these.
#define PWM_HARD_MIN     800
#define PWM_HARD_MAX     2100

// Ch5 Flight Mode Selections
// These are the PWM values that will be sent out on Ch5 when the operator requests a given flight mode
#define FLIGHT_MODE_1               1150
#define FLIGHT_MODE_2               1295
#define FLIGHT_MODE_3               1425
#define FLIGHT_MODE_4               1555
#define FLIGHT_MODE_5               1685
#define FLIGHT_MODE_6               1850
#define DEFAULT_ACTIVE_FLIGHT_MODE  2

// Min and Max allowable trim values.  In PWM.
#define MAX_TRIM    75
#define MIN_TRIM    -75

// Triple Rate Multipliers
#define LOW_RATE_MULTIPLIER        0.5
#define HIGH_RATE_MULTIPLIER       1.0

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  EEPROM SETTINGS
//
// EEPROM Storage
#define MODEL_MEMORY_NUM        7               // The number of model memories
#define MODEL_MEMORY_SPACE      256             // The number of bytes reserved for each model memory

#define ACTIVE_MODEL_LOC        1               // The active model memory
#define INIT_EEPROM_LOC         2               // Location to store the init state of EEPROM
#define INIT_CHECK_VAL          42              // The value to check to see if we have initialzied the EEPROM

#define DEFAULT_TIMER_VAL       5               // Minutes


// Display Control
#define MAIN_CONTROL_DISPLAY        0
#define MENU_1_DISPLAY              1
#define MENU_2_DISPLAY              2
#define MENU_3_DISPLAY              3
#define MENU_4_DISPLAY              4
#define MENU_5_DISPLAY              5
#define MENU_6_DISPLAY              6
#define MENU_7_DISPLAY              7
#define MENU_8_DISPLAY              8
#define MENU_9_DISPLAY              9
#define MODEL_MENU                  10
#define MODEL_SELECT_DISPLAY        11
#define MODEL_NAME_CHANGE_DISPLAY   12
#define MODEL_COPY_DISPLAY          13
#define MODEL_DELETE_DISPLAY        14
#define TRIM_DISPLAY                20
#define EXPO_DISPLAY                30
#define TIMER_ADJUST                40
#define ENDPOINT_DISPLAY            50
#define DUAL_RATES_DISPLAY          60
#define THROTTLE_SWITCH_DISPLAY     70






















#endif // __ARDUCOPTER_CONFIG_H__