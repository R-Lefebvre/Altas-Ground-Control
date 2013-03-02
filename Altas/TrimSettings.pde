/*

AEL/ELE Trim

*/


// Trim Settings
void TrimSettings() {

    if ( ModeDispSet == 1 ) {    // Pitch or Roll Trim setting
	    
	    // Write AEL, ELE or RUD to LCD
		cursorSet(1,0);
        Serial3.println(MenuDisplay[ModeDispSet]);
        cursorSet(1,1); Serial3.print("Pitch");
        cursorSet(1,2); Serial3.print("Roll");

		// Right justify pos numbers
		if (Trim_Pitch >= 0 && Trim_Pitch <= 9 ) {
        deletePLCD(7,1);
		cursorSet(8,1); Serial3.println(Trim_Pitch);
		}
		if (Trim_Pitch >= 10 && Trim_Pitch <= 99 ) {
		cursorSet(7,1); Serial3.println(Trim_Pitch);
		}
		if (Trim_Pitch >= 100 && Trim_Pitch <= 999 ) {
		cursorSet(6,1); Serial3.println(Trim_Pitch);
		}			
		// Right justify neg numbers
		if (Trim_Pitch >= -9 && Trim_Pitch <= -1 ) {
		cursorSet(7,1); Serial3.println(Trim_Pitch);
		}
		if (Trim_Pitch >= -99 && Trim_Pitch <= -10 ) {
		cursorSet(6,1); Serial3.println(Trim_Pitch);
		}
		if (Trim_Pitch >= -999 && Trim_Pitch <= -100 ) {
		cursorSet(5,1); Serial3.println(Trim_Pitch);
		}

        // Right justify pos numbers
		if (Trim_Roll >= 0 && Trim_Roll <= 9 ) {
        deletePLCD(7,2);
		cursorSet(8,2); Serial3.println(Trim_Roll);
		}
		if (Trim_Roll >= 10 && Trim_Roll <= 99 ) {
		cursorSet(7,2); Serial3.println(Trim_Roll);
		}
		if (Trim_Roll >= 100 && Trim_Roll <= 999 ) {
		cursorSet(6,2); Serial3.println(Trim_Roll);
		}			
		// Right justify neg numbers
		if (Trim_Roll >= -9 && Trim_Roll <= -1 ) {
		cursorSet(7,2); Serial3.println(Trim_Roll);
		}
		if (Trim_Roll >= -99 && Trim_Roll <= -10 ) {
		cursorSet(6,2); Serial3.println(Trim_Roll);
		}
		if (Trim_Roll >= -999 && Trim_Roll <= -100 ) {
		cursorSet(5,2); Serial3.println(Trim_Roll);
		}

        // Thumb stick trim
        
        if (DI_Val[HAT_SWITCH_RIGHT_NUM] == 0 && Trim_Roll < MAX_TRIM) {     // Ael trim up via thumb stick
                buzzeractivate = 2;         // activate buzzer
                Trim_Roll++;
                if (Trim_Roll > MAX_TRIM) { Trim_Roll = MAX_TRIM; }
                Epromvar = Trim_Roll;
                Offset = 0;
                EEpromwrite();
        }
        if (DI_Val[HAT_SWITCH_LEFT_NUM] == 0 && Trim_Roll > MIN_TRIM) {     // Ael trim down via thumb stick
                buzzeractivate = 2;         // activate buzzer
                Trim_Roll--;
                if (Trim_Roll < MIN_TRIM) { Trim_Roll = MIN_TRIM; }
                Epromvar = Trim_Roll;
                Offset = 0;
                EEpromwrite();
        }	
        if (DI_Val[HAT_SWITCH_DOWN_NUM] == 0 && Trim_Pitch < MAX_TRIM) {     // Ele trim up via thumb stick
                buzzeractivate = 2;         // activate buzzer
                Trim_Pitch++;
                if (Trim_Pitch > MAX_TRIM) { Trim_Pitch = MAX_TRIM; }
                Epromvar = Trim_Pitch;
                Offset = 3;
                EEpromwrite();
        }
        if (DI_Val[HAT_SWITCH_UP_NUM] == 0 && Trim_Pitch > MIN_TRIM) {     // Ele trim down via thumb stick
                buzzeractivate = 2;         // activate buzzer
                Trim_Pitch--;
                if (Trim_Pitch < MIN_TRIM) { Trim_Pitch = MIN_TRIM; }
                Epromvar = Trim_Pitch;
                Offset = 3;
                EEpromwrite();
        }		
    }	
}


