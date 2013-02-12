/*

Invert Channels

*/

char* InvertAELMode[]={"        ", " NO", "YES", "AEL  "};
char* InvertELEMode[]={"        ", " NO", "YES", "ELE  "};
char* InvertRUDMode[]={"        ", " NO", "YES", "RUD  "};

// Invert Channels
void InvertChannels() {

	if (Timermode == 0 && ModeDispSet == 8) {    // Invert AEL setting, 1=NO, 2=YES
		 //cursorSet(1,2);  // bottom line
         //Serial.println(InvertAELMode[3]);
		 //cursorSet(6,2);  // bottom line
         //Serial.println(InvertAELMode[InvModeAELEEprom]);
		 //cursorSet(1,1);  // top line
         //Serial.println(MenuDisplay[6]);
		 
		 if (DI_Onup_c == 1) {    // YES
		    DI_Onup_c = 0;
			ReverseAeleron = 1;
			buzzeractivate = 1;                  // activate buzzer
			InvModeAELEEprom = 2;
			Epromvar = InvModeAELEEprom;
			Address = 32;
            EEpromwriteDirect();
		 }
		
		 if (DI_Onup_b == 1) {    // NO
		    DI_Onup_b = 0;
			ReverseAeleron = 0;
			buzzeractivate = 1;                  // activate buzzer
			InvModeAELEEprom = 1;
			Epromvar = InvModeAELEEprom;
			Address = 32;
            EEpromwriteDirect();
		 }		 
	}

	if (Timermode == 0 && ModeDispSet == 9) {    // Invert ELE setting, 1=NO, 2=YES
		 //cursorSet(1,2);  // bottom line
         //Serial.println(InvertELEMode[3]);
		 //cursorSet(6,2);  // bottom line
         //Serial.println(InvertELEMode[InvModeELEEEprom]);
		 //cursorSet(1,1);  // top line
         //Serial.println(MenuDisplay[6]);
		 
		 if (DI_Onup_c == 1) {    // YES
		    DI_Onup_c = 0;
			ReverseElevator = 1;
			buzzeractivate = 1;                  // activate buzzer
			InvModeELEEEprom = 2;
			Epromvar = InvModeELEEEprom;
			Address = 33;
            EEpromwriteDirect();
		 }
		
		 if (DI_Onup_b == 1) {    // NO
		    DI_Onup_b = 0;
			ReverseElevator = 0;
			buzzeractivate = 1;                  // activate buzzer
			InvModeELEEEprom = 1;
			Epromvar = InvModeELEEEprom;
			Address = 33;
            EEpromwriteDirect();
		 }		 
	}
	
	if (Timermode == 0 && ModeDispSet == 10) {    // Invert RUD setting, 1=NO, 2=YES
		 //cursorSet(1,2);  // bottom line
         //Serial.println(InvertRUDMode[3]);
		 //cursorSet(6,2);  // bottom line
         //Serial.println(InvertRUDMode[InvModeRUDEEprom]);
		 //cursorSet(1,1);  // top line
         //Serial.println(MenuDisplay[6]);
		 
		 if (DI_Onup_c == 1) {    // YES
		    DI_Onup_c = 0;
			ReverseRudder = 1;
			buzzeractivate = 1;                  // activate buzzer
			InvModeRUDEEprom = 2;
			Epromvar = InvModeRUDEEprom;
			Address = 34;
            EEpromwriteDirect();
		 }
		
		 if (DI_Onup_b == 1) {    // NO
		    DI_Onup_b = 0;
			ReverseRudder = 0;
			buzzeractivate = 1;                  // activate buzzer
			InvModeRUDEEprom = 1;
			Epromvar = InvModeRUDEEprom;
			Address = 34;
            EEpromwriteDirect();
		 }		 
	}	
}

// *********************** Setup **************************
void InvertChannelsSetup() {

  // Pull AEL Invert Mode from EEprom
  InvModeAELEEprom = EEPROM.read(32);          // Read from EEprom
  if (InvModeAELEEprom != 1 && InvModeAELEEprom != 2) {  // Set to default if out of range
	 InvModeAELEEprom = 1;
	 Epromvar = InvModeAELEEprom;
	 Address = 32;
     EEpromwriteDirect();
  }  
  if (InvModeAELEEprom == 2) {  // Setup AEL Invert mode
	 ReverseAeleron = 1;
  }  

  // Pull ELE Invert Mode from EEprom
  InvModeELEEEprom = EEPROM.read(33);            // Read from EEprom
  if (InvModeELEEEprom != 1 && InvModeELEEEprom != 2) {  // Set to default if out of range
	 InvModeELEEEprom = 1;
	 Epromvar = InvModeELEEEprom;
	 Address = 33;
     EEpromwriteDirect();
  }  
  if (InvModeELEEEprom == 2) {  // Setup ELE Invert mode
	 ReverseElevator = 1;
  }  

  // Pull RUD Invert Mode from EEprom
  InvModeRUDEEprom = EEPROM.read(34);            // Read from EEprom
  if (InvModeRUDEEprom != 1 && InvModeRUDEEprom != 2) {  // Set to default if out of range
	 InvModeRUDEEprom = 1;
	 Epromvar = InvModeRUDEEprom;
	 Address = 34;
     EEpromwriteDirect();
  }  
  if (InvModeRUDEEprom == 2) {  // Setup ELE Invert mode
	 ReverseRudder = 1;
  } 
}  
