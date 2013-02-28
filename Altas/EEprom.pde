/*

EEprom Read/Write

Value in EEprom must always be positive (0-255) and since the value to be written may
be negative, by adding the maximum allowable trim value in the range ensures it
is always positive. However, this sets a limit of 127 on MAX_TRIM (254 max to eprom).
Interrupts are disabled during write but will not effect the ISR's.

*/

// Eprom write
void EEpromwrite() {
    Epromvar = Epromvar + MAX_TRIM;  // Value in Eprom always positive
	cli();
	EEPROM.write(EpromPointer + RatesHIMIDLOEEprom + Offset, Epromvar);
	sei();
}

// Eprom read
void EEpromread() { 
	Epromvar = EEPROM.read(EpromPointer + RatesHIMIDLOEEprom + Offset);
	Epromvar = Epromvar - MAX_TRIM;  // Value back to +/-
}

// Direct Eprom write
void EEpromwriteDirect() { 
	cli();
	EEPROM.write(Address, Epromvar);
	sei();
}

// Direct Eprom read
void EEpromreadDirect() { 
	Epromvar = EEPROM.read(Address);
}