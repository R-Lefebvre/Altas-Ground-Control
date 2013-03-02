/*

Timer Display

*/

// Timer Mode
void TimerDisplay() {

    if ( ModeDispSet == 0 ) {
        cursorSet(1,1);
        Serial3.print("Timer1:"); 
        if (timer1_minutes < 10) {
            cursorSet(10,1);
            Serial3.print("0");
            cursorSet(11,1);
            Serial3.print(timer1_minutes);
        }
        
        if (timer1_minutes >= 10) {
            cursorSet(10,1);
            Serial3.print(timer1_minutes);
        }
        
        cursorSet(12,1);
        Serial3.print(":");
        if (timer1_seconds < 10) {
            cursorSet(13,1);
            Serial3.print("0");
            cursorSet(14,1);
            Serial3.print(timer1_seconds);
        }
        
        if (timer1_seconds >= 10) {
            cursorSet(13,1);
            Serial3.print(timer1_seconds);
        }
        
        cursorSet(1,2);
        Serial3.print("Timer2:"); 
        if (timer2_minutes < 10) {
            cursorSet(10,2);
            Serial3.print("0");
            cursorSet(11,2);
            Serial3.print(timer2_minutes);
        }
        
        if (timer2_minutes >= 10) {
            cursorSet(10,2);
            Serial3.print(timer2_minutes);
        }
        
        cursorSet(12,2);
        Serial3.print(":");
        if (timer2_seconds < 10) {
            cursorSet(13,2);
            Serial3.print("0");
            cursorSet(14,2);
            Serial3.print(timer2_seconds);
        }
        
        if (timer2_seconds >= 10) {
            cursorSet(13,2);
            Serial3.print(timer2_seconds);
        }
    }
}
