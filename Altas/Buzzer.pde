/*

Buzzer

Rather than using a simple delay() which stops the main loop in it's tracks, this routine activates
the buzzer for set periods of time whilst allowing the Cpu & code to continue.

*/

long buzzinterval;

void buzzer() {
    if (buzzeractivate == 1) {  // panel button has been pressed
        Serial3.write(218);
        Serial3.write(212);  
        Serial3.write(222);
        buzzeractivate = 0;
    
	}

    if (buzzeractivate == 2) {  // thumb stick has been used
        Serial3.write(218);
        Serial3.write(213);
        Serial3.write(231);  
        buzzeractivate = 0;
	}
}

