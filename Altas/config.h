#ifndef __ARDUCOPTER_CONFIG_H__
#define __ARDUCOPTER_CONFIG_H__

#include "defines.h"

// Hardware Definitions
// Outputs:
#define PPM_OUTPUT_PIN          10

// Ch5 Flight Mode LEDs
#define FLIGHT_MODE_1_LED       39
#define FLIGHT_MODE_2_LED       40
#define FLIGHT_MODE_3_LED       41
#define FLIGHT_MODE_4_LED       42
#define FLIGHT_MODE_5_LED       43
#define FLIGHT_MODE_6_LED       44

#define CH7_SWITCH_LED          47
#define CH8_SWITCH_LED          48
#define PIEZO_OUTPUT_PIN        49



// Inputs:
#define HAT_SWITCH_UP_PIN       22
#define HAT_SWITCH_DOWN_PIN     23
#define HAT_SWITCH_LEFT_PIN     24
#define HAT_SWITCH_RIGHT_PIN    25
#define MFD_BUTTON_ENTER_PIN    26
#define MFD_BUTTON_BACK_PIN     27
#define MFD_BUTTON_MODE_PIN     28
#define CH7_SWITCH_PIN          29
#define CH8_SWITCH_PIN          30
#define AUX1_SWITCH_PIN         31
#define AUX2_SWITCH_PIN         32

// Ch5 Flight Mode Button Inputs
#define FLIGHT_MODE_1_INPUT     33
#define FLIGHT_MODE_2_INPUT     34
#define FLIGHT_MODE_3_INPUT     35
#define FLIGHT_MODE_4_INPUT     36
#define FLIGHT_MODE_5_INPUT     37
#define FLIGHT_MODE_6_INPUT     38

#define ANALOG_INPUT_PINCOUNT   7
#define DIGITAL_INPUT_PINCOUNT  10

// User adjustable settings
#define PWM_MIN     700
#define PWM_MID     1200
#define PWM_MAX     1700

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

// Ch5 Flight Mode Selections
// These are the PWM values that will be sent out on Ch5 when the operator requests a given flight mode

#define FLIGHT_MODE_1   1150
#define FLIGHT_MODE_2   1295
#define FLIGHT_MODE_3   1425
#define FLIGHT_MODE_4   1555
#define FLIGHT_MODE_5   1685
#define FLIGHT_MODE_6   1850

// These are the PWM values that will be sent out when Ch7 switch is high or low
#define CH7_PWM_LOW     1100
#define CH7_PWM_HIGH    1900

// Triple Rate Multipliers
#define LOW_RATE_MULTIPLIER        0.5
#define MID_RATE_MULTIPLIER        0.75
#define HIGH_RATE_MULTIPLIER       1.0

// PPM Stream Generation
#define PPM_FREQUENCY           22500           // PPM frame length total in uS
#define PPM_CHANNEL_SPACING     300             // PPM frame padding LOW phase in uS


























#endif // __ARDUCOPTER_CONFIG_H__