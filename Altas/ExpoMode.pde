/*

Exponential Modes

*/

char* MenuExponentialMode[]={"        ", "OFF", " ON"};
int ExpoModeAELEEprom = 1, ExpoModeELEEEprom = 1, ExpoModeRUDEEprom = 1, InvModeAELEEprom = 1, InvModeELEEEprom = 1, InvModeRUDEEprom = 1;

// Exponential Modes
void ExpoMode() {

	// AEL Exponential Mode setting, 1=OFF, 2=ON
    if (Timermode == 0 && ModeDispSet == 2) {
        cursorSet(1,0);
        Serial3.print("Exponential Mode");
	    cursorSet(2,1);
        Serial3.print("Roll:");
		cursorSet(7,1);
        Serial3.println(MenuExponentialMode[ExpoModeAELEEprom]);
		cursorSet(1,2);
        Serial3.print("Pitch:");
		cursorSet(7,2);
        Serial3.println(MenuExponentialMode[ExpoModeELEEEprom]);
        cursorSet(3,3);
        Serial3.print("Yaw:");
		cursorSet(7,3);
        Serial3.println(MenuExponentialMode[ExpoModeRUDEEprom]);
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