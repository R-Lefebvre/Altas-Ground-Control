/*

Battery Monitor

*/

int AI_Batte_percent = 0;
int AI_Battery_2fp = 0;
float AI_Batte;
float AI_Batte_Ave;
bool Battery_Filter_Init = true;
float BatteryMult = 78.3;   // Scale the analogue input down to battery voltage. Value depends on voltage divider resistors used.
                            // Remember AI_Val[6] is an int between 0 and 1023 which represents 0 to 5V on the pin.
                            // BatteryMult should equal: (5V * VoltDiv)/1023

void batterymonitor() {
 
    AI_Batte = AI_Val[6] / BatteryMult;
    if (Battery_Filter_Init){
        AI_Batte_Ave =AI_Batte;
        Battery_Filter_Init = false;
    } else {
        AI_Batte_Ave = (0.01*AI_Batte) + (0.99*AI_Batte_Ave);         // Simple Filter
    }

	if (AI_Batte_Ave > NiMH_MIN_VOLT) {            // Compare battery with Lipo alarm setting
        digitalWrite(PIEZO_OUTPUT_PIN, LOW);   // Turn off buzzer
    }
    if (AI_Batte_Ave < NiMH_MIN_VOLT && slowflag == 1) {
	    digitalWrite(PIEZO_OUTPUT_PIN, HIGH);  // Turn on buzzer
    } else {
	    digitalWrite(PIEZO_OUTPUT_PIN, LOW);   // Turn off buzzer
	}
	
	AI_Battery_2fp = AI_Batte_Ave * 100;      // map doesn't work with float, so mult x100 gains 2 dp's to get around this
	AI_Batte_percent = map(AI_Battery_2fp, 880, 1100, 0, 100) + 0;  // map battery voltage to percentage 10.8v to 11.0V
	if (AI_Batte_percent < 0) {
	   AI_Batte_percent = 0;
	}
	if (AI_Batte_percent > 100) {
	   AI_Batte_percent = 100;
	}
	
    
}

