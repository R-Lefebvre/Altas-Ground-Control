/*

AEL/ELE/RUD Trim

*/

char* MenuHIMIDLO[]={"        ", "LO", "MI", "HI"};
int TrEprom;

// Trim Settings
void TrimSettings() {

    if (Timermode == 0 && ModeDispSet == 1 || ModeDispSet == 2 || ModeDispSet == 3) {    // AEL,ELE,RUD Trim setting
	    if (ModeDispSet == 1) {
		    TrEprom = TrAelEEprom;
		    Offset = 0;
		}
		if (ModeDispSet == 2) {
		    TrEprom = TrEleEEprom;
            Offset = 3;
		}
		if (ModeDispSet == 3) {
		    TrEprom = TrRudEEprom;
            Offset = 6;
		}
	
	    // Write AEL, ELE or RUD to LCD
	    cursorSet(1,0);
        Serial3.println(MenuHIMIDLO[RatesHIMIDLOEEprom]);  // LO, MI or HI
		cursorSet(1,1);
        Serial3.println(MenuDisplay[ModeDispSet]);  // AEL, ELE or RUD TRIM
		
		// Stick Trim
		if (TrEprom > trimMax) {   // If more than trimMax (i.e. brand new install or corrupt) then reset to zero
		    TrEprom = 0;
			Epromvar = TrEprom;
            EEpromwrite();
		}
		
		if (TrEprom < trimMin) {   // If lower than trimMin (i.e. brand new install or corrupt) then reset to zero
		    TrEprom = 0;
			Epromvar = TrEprom;
            EEpromwrite();
		}
		
		if (DI_Onup_c == 1 && TrEprom < trimMax) {    // trim adj up
		    DI_Onup_c = 0;
		    buzzeractivate = 1;                  // activate buzzer
			TrEprom++;
			if (TrEprom > trimMax) { TrEprom = trimMax; }
			Epromvar = TrEprom;
            EEpromwrite();
		}
		
		if (DI_Onup_b == 1 && TrEprom > trimMin) {    // trim adj down
		    DI_Onup_b = 0;
		    buzzeractivate = 1;                  // activate buzzer
			TrEprom--;
			if (TrEprom < trimMin) { TrEprom = trimMin; }
			Epromvar = TrEprom;
            EEpromwrite();
		}

		// Right justify pos numbers
		if (TrEprom >= 0 && TrEprom <= 9 ) {
		cursorSet(4,0); Serial3.println("    ");
		cursorSet(8,0); Serial3.println(TrEprom);
		}
		if (TrEprom >= 10 && TrEprom <= 99 ) {
		cursorSet(4,0); Serial3.println("   ");
		cursorSet(7,0); Serial3.println(TrEprom);
		}
		if (TrEprom >= 100 && TrEprom <= 999 ) {
		cursorSet(4,0); Serial3.println("  ");
		cursorSet(6,0); Serial3.println(TrEprom);
		}			
		// Right justify neg numbers
		if (TrEprom >= -9 && TrEprom <= -1 ) {
		cursorSet(4,0); Serial3.println("   ");
		cursorSet(7,0); Serial3.println(TrEprom);
		}
		if (TrEprom >= -99 && TrEprom <= -10 ) {
		cursorSet(4,0); Serial3.println("  ");
		cursorSet(6,0); Serial3.println(TrEprom);
		}
		if (TrEprom >= -999 && TrEprom <= -100 ) {
		cursorSet(4,0); Serial3.println(" ");
		cursorSet(5,0); Serial3.println(TrEprom);
		}		
		
		// Reload vars
        if (ModeDispSet == 1) {TrAelEEprom = TrEprom; }
		if (ModeDispSet == 2) {TrEleEEprom = TrEprom; }
		if (ModeDispSet == 3) {TrRudEEprom = TrEprom; }
    }
	
    // Thumb stick trim
	
    if (DI_Val[5] == 0 && TrAelEEprom < trimMax) {     // Ael trim up via thumb stick
		    buzzeractivate = 2;         // activate buzzer
			TrAelEEprom++;
			if (TrAelEEprom > trimMax) { TrAelEEprom = trimMax; }
			Epromvar = TrAelEEprom;
            Offset = 0;
            EEpromwrite();
	}
    if (DI_Val[4] == 0 && TrAelEEprom > trimMin) {     // Ael trim down via thumb stick
		    buzzeractivate = 2;         // activate buzzer
			TrAelEEprom--;
			if (TrAelEEprom < trimMin) { TrAelEEprom = trimMin; }
			Epromvar = TrAelEEprom;
            Offset = 0;
            EEpromwrite();
	}	
    if (DI_Val[6] == 0 && TrEleEEprom < trimMax) {     // Ele trim up via thumb stick
		    buzzeractivate = 2;         // activate buzzer
			TrEleEEprom++;
			if (TrEleEEprom > trimMax) { TrEleEEprom = trimMax; }
			Epromvar = TrEleEEprom;
            Offset = 3;
            EEpromwrite();
	}
    if (DI_Val[7] == 0 && TrEleEEprom > trimMin) {     // Ele trim down via thumb stick
		    buzzeractivate = 2;         // activate buzzer
			TrEleEEprom--;
			if (TrEleEEprom < trimMin) { TrEleEEprom = trimMin; }
			Epromvar = TrEleEEprom;
            Offset = 3;
            EEpromwrite();
	}	
	
}


