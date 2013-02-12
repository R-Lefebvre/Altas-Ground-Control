/*

Mode Test

A rough and ready way of diagnosing the analogue inputs and PPM output channels.
Press buttons DI_Val[3] or DI_Val[4] to cycle round the RAW analogue
input or ppm output channels. Press button DI_Val[2] or DI_Val[5] to exit this mode.

*/

int pointraw = 0;
int pointppm = 0;
int RawOut = 0;
int prevmode = 0;

void ModeTesting() {
    
	// Mode Test RAW & PPM
	if (Timermode == 0 && ModeDispSet == 11 && ModeTest == 0) {
         //cursorSet(1,1);
         //Serial.println(MenuDisplay[7]);
		 //cursorSet(1,2);
         //Serial.println(MenuDisplay[8]);
		 
		 if (DI_Onup_c == 1) {    // Enter Test Mode
		    DI_Onup_c = 0;
			ModeTest = 1;
			buzzeractivate = 1;                  // activate buzzer
		 }
		 
		 if (DI_Onup_b == 1) {    // Enter Test Mode
		    DI_Onup_b = 0;
			ModeTest = 1;
			buzzeractivate = 1;                  // activate buzzer
		 }		 
		
	}

    if (ModeTest == 1) {

	    if (DI_Onup_a == 1 || DI_Onup_d == 1) {      // Exit Mode Test
		   DI_Onup_a = 0;
		   DI_Onup_d = 0;
	       buzzeractivate = 1;
	       ModeTest = 0;
		   pointppm = 0;
		   pointraw = 0;
        }

	    if (DI_Onup_b == 1) {  // set Raw mode
		   DI_Onup_b = 0;
		   RawOut = 0;
		}
	    if (DI_Onup_c == 1) {  // set PPM mode
		   DI_Onup_c = 0;
		   RawOut = 1;
		}	

		
		// Raw input display mode (all the analogue inputs & 2 aux digital inputs)
		if (RawOut == 0) {
		   //clearLCD();
		
		   if (DI_Val[1] == 0) {
		   DI_Onup_b = 0;
		   buzzeractivate = 1;
		   if (prevmode == 0) { pointraw++; }
		   prevmode = 0;
           if (pointraw == 9) { pointraw = 0; }  
		   }
		
		   if (pointraw <= 6) {
		      //cursorSet(1,1);
              //Serial.println("RAW A   ");
		      //cursorSet(6,1);
              //Serial.println(pointraw);
		      //cursorSet(1,2);
              //Serial.println(AI_Val[pointraw]);
           }
		   if (pointraw == 7) {
		      //cursorSet(1,1);
              //Serial.println("RAW D13 ");
		      //cursorSet(1,2);
              //Serial.println(DI_Val[8]);
           }
		   if (pointraw == 8) {
		      //cursorSet(1,1);
              //Serial.println("RAW D11 ");
		      //cursorSet(1,2);
              //Serial.println(DI_Val[9]);
           }
		}

		// PPM input display mode (for the 8 channels)
		if (RawOut == 1) {
		   //clearLCD();
		
		   if (DI_Val[2] == 0) {
		   DI_Onup_c = 0;
		   buzzeractivate = 1;
		   if (prevmode == 1) { pointppm++; }
		   prevmode = 1;
           if (pointppm == 8) { pointppm = 0; }  
		   }
		
		   //cursorSet(1,1);
           //Serial.println("PPM     ");
		   //cursorSet(5,1);
           //Serial.println(pointppm + 1);
		   //cursorSet(1,2);
		   
           //if (pointppm == 0) { Serial.println(AI_Aeler); }
           //if (pointppm == 1) { Serial.println(AI_Eleva); }
           //if (pointppm == 2) { Serial.println(AI_Throt); }
           //if (pointppm == 3) { Serial.println(AI_Rudde); }
           //if (pointppm == 4) { Serial.println(Auxsw_uS); }
           //if (pointppm == 5) { Serial.println(AI_Auxpot); }
           //if (pointppm == 6) { Serial.println(AI_Auxpot2); }
           //if (pointppm == 7) { Serial.println(Auxsw2_uS); }		   
		}		
    }
}


