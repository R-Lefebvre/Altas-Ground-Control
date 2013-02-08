#ifndef __ARDUCOPTER_CONFIG_H__
#define __ARDUCOPTER_CONFIG_H__

#include "defines.h"

// Hardware Definitions
#define PPM_OUTPUT_PIN          10
#define PIEZO_OUTPUT_PIN        12


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

#define LOW_RATE_MULTIPLIER        0.5
#define MID_RATE_MULTIPLIER        0.75
#define HIGH_RATE_MULTIPLIER       1.0

#define PPM_FREQUENCY           22500           // PPM frame length total in uS
#define PPM_CHANNEL_SPACING     300             // PPM frame padding LOW phase in uS


























#endif // __ARDUCOPTER_CONFIG_H__