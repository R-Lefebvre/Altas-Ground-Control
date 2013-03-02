

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