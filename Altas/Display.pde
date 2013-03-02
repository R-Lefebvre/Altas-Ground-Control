/*
Display
*/


void Display(){
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
        
        if (AI_Batte_percent < 10) {
            cursorSet(1,3); Serial3.print("  ");
            cursorSet(3,3); Serial3.print(AI_Batte_percent);
            cursorSet(4,3); Serial3.print("% ");
            cursorSet(6,3); Serial3.print(AI_Batte);
            cursorSet(11,3); Serial3.print("V");
        }
        
        if (AI_Batte_percent >= 10 && AI_Batte_percent < 100) {
            cursorSet(1,3); Serial3.print(" ");
            cursorSet(2,3); Serial3.print(AI_Batte_percent);
            cursorSet(4,3); Serial3.print("% ");
            cursorSet(6,3); Serial3.print(AI_Batte);
            cursorSet(11,3); Serial3.print("V");
        }
        
        if (AI_Batte_percent >= 100) {
            cursorSet(1,3); Serial3.print(AI_Batte_percent);
            cursorSet(4,3); Serial3.print("% ");
            cursorSet(6,3); Serial3.print(AI_Batte);
            cursorSet(11,3); Serial3.print("V");
        }        
    }
}

