/*

Battery Monitor

*/

int AI_Batte_percent = 0;
int AI_Battefloat = 0;
float AI_Batte;
float LipoMin = 10.8;      // Minimum battery voltage (alarm)
float BatteryMult = 35.7;  // Scale the analogue input down to battery voltage. Value depends on voltage divider resistors used.
						   // 5.6k & 1k resistors should give 2.2v at the input for 12.6v battery voltage.

void batterymonitor() {

    AI_Batte = AI_Val[5] / BatteryMult;

	if (AI_Batte > LipoMin) {            // Compare battery with Lipo alarm setting
        digitalWrite(PIEZO_OUTPUT_PIN, LOW);   // Turn off buzzer
    }
    if (AI_Batte < LipoMin && slowflag == 1) {
	    digitalWrite(PIEZO_OUTPUT_PIN, HIGH);  // Turn on buzzer
    } else {
	    digitalWrite(PIEZO_OUTPUT_PIN, LOW);   // Turn off buzzer
	}
	
	AI_Battefloat = AI_Batte * 100;      // map doesn't work with float, so mult x100 gains 2 dp's to get around this
	AI_Batte_percent = map(AI_Battefloat, 1080, 1260, 0, 100) + 0;  // map battery voltage to percentage 10.8v to 12.6v
	if (AI_Batte_percent < 0) {
	   AI_Batte_percent = 0;
	}
	if (AI_Batte_percent > 100) {
	   AI_Batte_percent = 100;
	}
	
    if (AI_Batte_percent < 10 && ModeDispSet == 0 && Timermode == 0) {
	//cursorSet(1,1); Serial.println(AI_Batte_percent);
	//cursorSet(2,1); Serial.println("%");
    //cursorSet(3,1); Serial.println("  ");
	//cursorSet(5,1); Serial.println(AI_Batte);
    }
	
	if (AI_Batte_percent >= 10 && AI_Batte_percent < 100 && ModeDispSet == 0 && Timermode == 0) {
	//cursorSet(1,1); Serial.println(AI_Batte_percent);
	//cursorSet(3,1); Serial.println("%");
    //cursorSet(4,1); Serial.println(" ");
	//cursorSet(5,1); Serial.println(AI_Batte);
    }
	
    if (AI_Batte_percent >= 100 && ModeDispSet == 0 && Timermode == 0) {
	//cursorSet(1,1); Serial.println(AI_Batte_percent);
	//cursorSet(4,1); Serial.println("%");
	//cursorSet(5,1); Serial.println(AI_Batte);
    }
}

