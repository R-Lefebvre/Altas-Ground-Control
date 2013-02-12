/*

Exponential Modes

*/

char* MenuWingMode[]={"        ", "OFF", " ON", "MODE "};
char* MenuExponentialMode[]={"        ", "OFF", " ON", "MODE ", "AE,EL,RU"};
int ExpoModeAELEEprom = 1, ExpoModeELEEEprom = 1, ExpoModeRUDEEprom = 1, InvModeAELEEprom = 1, InvModeELEEEprom = 1, InvModeRUDEEprom = 1;

// Exponential Modes
void ExpoMode() {

	// AEL Exponential Mode setting, 1=OFF, 2=ON
    if (Timermode == 0 && ModeDispSet == 5 && ModeTest == 0) {
	     //cursorSet(1,2);
         //Serial.println(MenuExponentialMode[3]);
		 //cursorSet(6,2);
         //Serial.println(MenuExponentialMode[ExpoModeAELEEprom]);
		 //cursorSet(1,1);
         //Serial.println(MenuDisplay[5]);
		 
		 if (DI_Onup_c == 1) {    // AEL Expo Mode Set ON
		    DI_Onup_c = 0;
			ExpoModeAEL = 1;
			buzzeractivate = 1;                  // activate buzzer
			ExpoModeAELEEprom = 2;
			Epromvar = ExpoModeAELEEprom;
			Address = 22;
            EEpromwriteDirect();
		 }
		
		 if (DI_Onup_b == 1) {    // AEL Expo Mode Set OFF
		    DI_Onup_b = 0;
			ExpoModeAEL = 0;
			buzzeractivate = 1;                  // activate buzzer
			ExpoModeAELEEprom = 1;
			Epromvar = ExpoModeAELEEprom;
			Address = 22;
            EEpromwriteDirect();
		 }
	}	

	// ELE Exponential Mode setting, 1=OFF, 2=ON
    if (Timermode == 0 && ModeDispSet == 6 && ModeTest == 0) {
	     //cursorSet(1,2);
         //Serial.println(MenuExponentialMode[3]);
		 //cursorSet(6,2);
         //Serial.println(MenuExponentialMode[ExpoModeELEEEprom]);
		 //cursorSet(1,1);
         //Serial.println(MenuDisplay[9]);
		 
		 if (DI_Onup_c == 1) {    // ELE Expo Mode Set ON
		    DI_Onup_c = 0;
			ExpoModeELE = 1;
			buzzeractivate = 1;                  // activate buzzer
			ExpoModeELEEEprom = 2;
			Epromvar = ExpoModeELEEEprom;
			Address = 23;
            EEpromwriteDirect();
		 }
		
		 if (DI_Onup_b == 1) {    // ELE Expo Mode Set OFF
		    DI_Onup_b = 0;
			ExpoModeELE = 0;
			buzzeractivate = 1;                  // activate buzzer
			ExpoModeELEEEprom = 1;
			Epromvar = ExpoModeELEEEprom;
			Address = 23;
            EEpromwriteDirect();
		 }
	}	
	
	// RUD Exponential Mode setting, 1=OFF, 2=ON
    if (Timermode == 0 && ModeDispSet == 7 && ModeTest == 0) {
	     //cursorSet(1,2);
         //Serial.println(MenuExponentialMode[3]);
		 //cursorSet(6,2);
         //Serial.println(MenuExponentialMode[ExpoModeRUDEEprom]);
		 //cursorSet(1,1);
         //Serial.println(MenuDisplay[10]);
		 
		 if (DI_Onup_c == 1) {    // RUD Expo Mode Set ON
		    DI_Onup_c = 0;
			ExpoModeRUD = 1;
			buzzeractivate = 1;                  // activate buzzer
			ExpoModeRUDEEprom = 2;
			Epromvar = ExpoModeRUDEEprom;
			Address = 24;
            EEpromwriteDirect();
		 }
		
		 if (DI_Onup_b == 1) {    // RUD Expo Mode Set OFF
		    DI_Onup_b = 0;
			ExpoModeRUD = 0;
			buzzeractivate = 1;                  // activate buzzer 
			ExpoModeRUDEEprom = 1;
			Epromvar = ExpoModeRUDEEprom;
			Address = 24;
            EEpromwriteDirect();
		 }
	}		
}

// *********************** Setup **************************
void ExpoModeSetup () {
  ExpoModeAELEEprom = EEPROM.read(22);            // Read from EEprom
  if (ExpoModeAELEEprom != 1 && ExpoModeAELEEprom != 2) {  // Set to default if out of range
	 ExpoModeAELEEprom = 1;
	 Epromvar = ExpoModeAELEEprom;
	 Address = 22;
     EEpromwriteDirect();
  }
  if (ExpoModeAELEEprom == 2) { // Setup AEL Expo mode 
	 ExpoModeAEL = 1;
  }
  
  ExpoModeELEEEprom = EEPROM.read(23);            // Read from EEprom
  if (ExpoModeELEEEprom != 1 && ExpoModeELEEEprom != 2) {  // Set to default if out of range
	 ExpoModeELEEEprom = 1;
	 Epromvar = ExpoModeELEEEprom;
	 Address = 23;
     EEpromwriteDirect();
  }
  if (ExpoModeELEEEprom == 2) { // Setup ELE Expo mode 
	 ExpoModeELE = 1;
  }  
  
  ExpoModeRUDEEprom = EEPROM.read(24);            // Read from EEprom
  if (ExpoModeRUDEEprom != 1 && ExpoModeRUDEEprom != 2) {  // Set to default if out of range
	 ExpoModeRUDEEprom = 1;
	 Epromvar = ExpoModeRUDEEprom;
	 Address = 24;
     EEpromwriteDirect();
  }
  if (ExpoModeRUDEEprom == 2) { // Setup RUD Expo mode 
	 ExpoModeRUD = 1;
  }    
}