/*

Buzzer

Rather than using a simple delay() which stops the main loop in it's tracks, this routine activates
the buzzer for set periods of time whilst allowing the Cpu & code to continue.

*/

long buzzinterval;
unsigned char buzzloop = 0;

void buzzer() {
    currentMillis = millis();
    if (buzzeractivate == 1) {  // panel button has been pressed
	   previousMillis = currentMillis;  // save off the start of the buzz
	   buzzloop = 1;
	   buzzeractivate = 0;
	   buzzinterval = 20;  // panel button buzzer duration in mS
	}

    if (buzzeractivate == 2) {  // thumb stick has been used
	   previousMillis = currentMillis;  // save off the start of the buzz
	   buzzloop = 1;
	   buzzeractivate = 0;
	   buzzinterval = 10;  // thumb stick buzzer duration in mS
	}
	
	if (buzzloop == 1) {  // buzz loop activated
        if (currentMillis - previousMillis < buzzinterval) {  // if true then keep buzzing
           digitalWrite(outPinBuzz, HIGH);  // Turn on buzzer
           } else {
	       buzzloop = 0;
	       digitalWrite(outPinBuzz, LOW);   // stop buzzing
        }
	}
}

