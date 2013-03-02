/*

Exponential Modes

*/

char* MenuExponentialMode[]={"        ", "OFF", " ON"};
int ExpoModeAELEEprom = 1, ExpoModeELEEEprom = 1, ExpoModeRUDEEprom = 1, InvModeAELEEprom = 1, InvModeELEEEprom = 1, InvModeRUDEEprom = 1;

// Exponential Modes
void ExpoMode() {

	// AEL Exponential Mode setting, 1=OFF, 2=ON
    if (ModeDispSet == 2) {
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