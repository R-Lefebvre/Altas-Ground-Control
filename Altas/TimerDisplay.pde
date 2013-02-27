/*

Timer Display

*/

char* MenuTimerMode[]={"        ", " Timer              "};

// Timer Mode
void TimerDisplay() {

    if (DI_Onup_c == 1 && Timermode == 0) {  // Don't allow starting timer when not in timer mode
	    DI_Onup_c = 0;
	}

    if (DI_Onup_b == 1 && ModeDispSet == 0 && Timermode == 0) {      // Timer mode
	    DI_Onup_b = 0;
		Timermode = 1;
		//clearLCD();
	    buzzeractivate = 1;         // activate buzzer
    }
	else if (DI_Onup_b == 1 && Timermode == 1) {   // Exit Timer mode
		DI_Onup_b = 0;
		Timermode = 0;
		buzzeractivate = 1;         // activate buzzer
	}

    if (ModeDispSet == 0 && Timermode == 1) {
		cursorSet(0,0);
        Serial3.print(MenuTimerMode[1]); 
		if (minflag < 10) {
		    cursorSet(1,1);
		    Serial3.print("0");
		    cursorSet(2,1);
            Serial3.print(minflag);
		}
		if (minflag >= 10) {
		    cursorSet(1,1);
            Serial3.print(minflag);
		}		
		cursorSet(3,1);
        Serial3.print(":");
		if (secflag < 10) {
		    cursorSet(4,1);
		    Serial3.print("0");
		    cursorSet(5,1);
            Serial3.print(secflag);
		}
		if (secflag >= 10) {
		    cursorSet(4,1);
            Serial3.print(secflag);
		}

        cursorSet(6,1);
        Serial3.print("   ");

        if (DI_Onup_c == 1) {           // start/stop timer
		    DI_Onup_c = 0;
		    buzzeractivate = 1;         // activate buzzer
		    if (TimerStart == 0) {      // start timer
			   TimerStart = 1;
		    } else {                    // stop timer
		       secflag = 0;
			   minflag = 0;
			   TimerStart = 0;
		    }
        }			
	}	
}
