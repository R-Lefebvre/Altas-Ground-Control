/*

AEL/ELE Trim

*/


// Trim Settings
void TrimSettings() {

    if ( ModeDispSet == 1 ) {    // Pitch or Roll Trim setting
	    
	    // Write AEL, ELE or RUD to LCD
		cursorSet(1,0);
        Serial3.print(MenuDisplay[ModeDispSet]);
        cursorSet(1,1); Serial3.print("Pitch");
        cursorSet(1,2); Serial3.print("Roll");

		// Right justify pos numbers
		if (active_model.trim[1] >= 0 && active_model.trim[1] <= 9 ) {
        deletePLCD(7,1);
		cursorSet(8,1); Serial3.print(active_model.trim[1]);
		}
		if (active_model.trim[1] >= 10 && active_model.trim[1] <= 99 ) {
		cursorSet(7,1); Serial3.print(active_model.trim[1]);
		}
		if (active_model.trim[1] >= 100 && active_model.trim[1] <= 999 ) {
		cursorSet(6,1); Serial3.print(active_model.trim[1]);
		}			
		// Right justify neg numbers
		if (active_model.trim[1] >= -9 && active_model.trim[1] <= -1 ) {
		cursorSet(7,1); Serial3.print(active_model.trim[1]);
		}
		if (active_model.trim[1] >= -99 && active_model.trim[1] <= -10 ) {
		cursorSet(6,1); Serial3.print(active_model.trim[1]);
		}
		if (active_model.trim[1] >= -999 && active_model.trim[1] <= -100 ) {
		cursorSet(5,1); Serial3.print(active_model.trim[1]);
		}

        // Right justify pos numbers
		if (active_model.trim[0] >= 0 && active_model.trim[0] <= 9 ) {
        deletePLCD(7,2);
		cursorSet(8,2); Serial3.print(active_model.trim[0]);
		}
		if (active_model.trim[0] >= 10 && active_model.trim[0] <= 99 ) {
		cursorSet(7,2); Serial3.print(active_model.trim[0]);
		}
		if (active_model.trim[0] >= 100 && active_model.trim[0] <= 999 ) {
		cursorSet(6,2); Serial3.print(active_model.trim[0]);
		}			
		// Right justify neg numbers
		if (active_model.trim[0] >= -9 && active_model.trim[0] <= -1 ) {
		cursorSet(7,2); Serial3.print(active_model.trim[0]);
		}
		if (active_model.trim[0] >= -99 && active_model.trim[0] <= -10 ) {
		cursorSet(6,2); Serial3.print(active_model.trim[0]);
		}
		if (active_model.trim[0] >= -999 && active_model.trim[0] <= -100 ) {
		cursorSet(5,2); Serial3.print(active_model.trim[0]);
		}

        // Thumb stick trim
        
        if (DI_Val[HAT_SWITCH_RIGHT_NUM] == 0 && active_model.trim[0] < MAX_TRIM) {     // Ael trim up via thumb stick
                buzzeractivate = 2;         // activate buzzer
                active_model.trim[0]++;
                if (active_model.trim[0] > MAX_TRIM) { active_model.trim[0] = MAX_TRIM; }
        }
        if (DI_Val[HAT_SWITCH_LEFT_NUM] == 0 && active_model.trim[0] > MIN_TRIM) {     // Ael trim down via thumb stick
                buzzeractivate = 2;         // activate buzzer
                active_model.trim[0]--;
                if (active_model.trim[0] < MIN_TRIM) { active_model.trim[0] = MIN_TRIM; }
        }	
        if (DI_Val[HAT_SWITCH_DOWN_NUM] == 0 && active_model.trim[1] < MAX_TRIM) {     // Ele trim up via thumb stick
                buzzeractivate = 2;         // activate buzzer
                active_model.trim[1]++;
                if (active_model.trim[1] > MAX_TRIM) { active_model.trim[1] = MAX_TRIM; }
        }
        if (DI_Val[HAT_SWITCH_UP_NUM] == 0 && active_model.trim[1] > MIN_TRIM) {     // Ele trim down via thumb stick
                buzzeractivate = 2;         // activate buzzer
                active_model.trim[1]--;
                if (active_model.trim[1] < MIN_TRIM) { active_model.trim[1] = MIN_TRIM; }
        }		
    }	
}


