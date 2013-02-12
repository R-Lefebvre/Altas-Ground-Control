/*

HI/LO/MID Rates

*/

char* MenuRatesHIMIDLO[]={"        ", "Rates=LO", "Rates=MI", "Rates=HI"};

// Switch Rates
void HiMiLoRates() {

    if (DI_Onup_d == 1 && ModeDispSet == 0 && Timermode == 0) {      // LO/MI/HI selection & save
	    DI_Onup_d = 0;  // reset onup
		buzzeractivate = 1;         // activate buzzer
		RatesHIMIDLOEEprom = RatesHIMIDLOEEprom + 1;
		ChangeModeHIMIDLO = 1;
		if (RatesHIMIDLOEEprom >= 4) {
		   RatesHIMIDLOEEprom = 1;
		}
		cli();
		EEPROM.write(0, RatesHIMIDLOEEprom);  // write to EEprom
		sei();
    }

	if (Timermode == 0 && ModeDispSet == 0 && ChangeMode == 1) {     // LO/MI/HI Rates var set
		ChangeMode == 0;
        if (RatesHIMIDLOEEprom == 1) {  // LO rate
	     EpromPointer = 0;
	     //cursorSet(1,2);
         //Serial.println(MenuRatesHIMIDLO[RatesHIMIDLOEEprom]);
        }
        if (RatesHIMIDLOEEprom == 2) {  // MID rate
	    EpromPointer = 3; 
	    //cursorSet(1,2);
        //Serial.println(MenuRatesHIMIDLO[RatesHIMIDLOEEprom]); 
        }
        if (RatesHIMIDLOEEprom == 3) {  // HI rate
	    EpromPointer = 6; 
	    //cursorSet(1,2);
        //Serial.println(MenuRatesHIMIDLO[RatesHIMIDLOEEprom]);
        }	
	}	
	
    if (Timermode == 0 && RatesHIMIDLOEEprom == 3 && ModeDispSet == 0 && ChangeModeHIMIDLO == 1) {      // HI rate
	    ChangeModeHIMIDLO = 0;
		//cursorSet(1,2);
        //Serial.println(MenuRatesHIMIDLO[RatesHIMIDLOEEprom]); 
	    EpromPointer = 6;  // Set pointer for EEprom trim settings storage
		
		Epromvar = TrAelEEprom;
        Offset = 0;
        EEpromread();
        TrAelEEprom = Epromvar;
		Epromvar = TrEleEEprom;
        Offset = 3;
        EEpromread();
        TrEleEEprom = Epromvar;
        Epromvar = TrRudEEprom;
        Offset = 6;
        EEpromread();
        TrRudEEprom = Epromvar; 
		
		RateMult = HIGH_RATE_MULTIPLIER;
	}
	
    if (Timermode == 0 && RatesHIMIDLOEEprom == 2 && ModeDispSet == 0 && ChangeModeHIMIDLO == 1) {      // MID rate
	    ChangeModeHIMIDLO = 0;
		//cursorSet(1,2);
        //Serial.println(MenuRatesHIMIDLO[RatesHIMIDLOEEprom]); 
	    EpromPointer = 3;  // Set pointer for EEprom trim settings storage
		
	    Epromvar = TrAelEEprom;
        Offset = 0;
        EEpromread();
        TrAelEEprom = Epromvar;
		Epromvar = TrEleEEprom;
        Offset = 3;
        EEpromread();
        TrEleEEprom = Epromvar;
        Epromvar = TrRudEEprom;
        Offset = 6;
        EEpromread();
        TrRudEEprom = Epromvar; 

		RateMult = MID_RATE_MULTIPLIER;
    }
	
    if (Timermode == 0 && RatesHIMIDLOEEprom == 1 && ModeDispSet == 0 && ChangeModeHIMIDLO == 1) {      // LO rate
	    ChangeModeHIMIDLO = 0;
		//cursorSet(1,2);
		//Serial.println(MenuRatesHIMIDLO[RatesHIMIDLOEEprom]); 
	    EpromPointer = 0;  // Set pointer for EEprom trim settings storage
		
		Epromvar = TrAelEEprom;
        Offset = 0;
        EEpromread();
        TrAelEEprom = Epromvar;
		Epromvar = TrEleEEprom;
        Offset = 3;
        EEpromread();
        TrEleEEprom = Epromvar;
        Epromvar = TrRudEEprom;
        Offset = 6;
        EEpromread();
        TrRudEEprom = Epromvar; 

		RateMult = LOW_RATE_MULTIPLIER;
    }
}

// *********************** Setup **************************
void HiMiLoRatesSetup() {

  // Set LO rate default if out of range
  RatesHIMIDLOEEprom = EEPROM.read(0);            // Read from EEprom

  if (RatesHIMIDLOEEprom <= 0 || RatesHIMIDLOEEprom >= 4) {  
	 RatesHIMIDLOEEprom = 1;
	 EpromPointer = 0;
  } 
   
  if (RatesHIMIDLOEEprom == 1) {  // LO rate
	 EpromPointer = 0;
	 //cursorSet(1,2);
     //Serial.println(MenuRatesHIMIDLO[RatesHIMIDLOEEprom]);
	 RateMult = LOW_RATE_MULTIPLIER;
  }
  if (RatesHIMIDLOEEprom == 2) {  // MID rate
	 EpromPointer = 3; 
	 //cursorSet(1,2);
     //Serial.println(MenuRatesHIMIDLO[RatesHIMIDLOEEprom]);	
     RateMult = MID_RATE_MULTIPLIER;	 
  }
  if (RatesHIMIDLOEEprom == 3) {  // HI rate
	 EpromPointer = 6; 
	 //cursorSet(1,2);
     //Serial.println(MenuRatesHIMIDLO[RatesHIMIDLOEEprom]); 
	 RateMult = HIGH_RATE_MULTIPLIER;
  }
  
  Epromvar = TrAelEEprom;
  Offset = 0;
  EEpromread();
  TrAelEEprom = Epromvar;
  Epromvar = TrEleEEprom;
  Offset = 3;
  EEpromread();
  TrEleEEprom = Epromvar;
  Epromvar = TrRudEEprom;
  Offset = 6;
  EEpromread();
  TrRudEEprom = Epromvar;  
}  
  