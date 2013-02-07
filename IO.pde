/*

Analogue & Digital I/O

*/

int AI_Val2[7];
int AI_Val3[7];
int AI_Val4[7];
int AI_Val5[7];
unsigned char DItemp_a = 0;
unsigned char DItemp_b = 0;
unsigned char DItemp_c = 0;
unsigned char DItemp_d = 0;
int Expo = 50;
int AI_Aeler2 = 700;
float AI_AelerF = 700;
float AI_ElevaF = 700;
float AI_RuddeF = 700;
int AI_Elevon = 700;
int Minmult;
int Maxmult;

// Read Digital Inputs
void readdigital() {

   // Read input pins into var array
   for(char i=0; i<DI_pincount; i++) {  
	  DI_Val[i] = digitalRead(DI_Raw[i]);
   }  

   // Process the panel pushbuttons for onup functionality
   if (DI_Val[0] == 0) { DItemp_a = 1; }   // Button 2 down
   if (DI_Val[0] == 1 && DItemp_a == 1) {  // Button 2 now up
       DI_Onup_a = 1;
	   DItemp_a= 0;
   }
   if (DI_Val[1] == 0) { DItemp_b = 1; }   // Button 3 down
   if (DI_Val[1] == 1 && DItemp_b == 1) {  // Button 3 now up
       DI_Onup_b = 1;
	   DItemp_b = 0;
   }
   if (DI_Val[2] == 0) { DItemp_c = 1; }   // Button 4 down
   if (DI_Val[2] == 1 && DItemp_c == 1) {  // Button 4 now up
       DI_Onup_c = 1;
	   DItemp_c = 0;
   }
   if (DI_Val[3] == 0) { DItemp_d = 1; }   // Button 5 down
   if (DI_Val[3] == 1 && DItemp_d == 1) {  // Button 5 now up
       DI_Onup_d = 1;
	   DItemp_d = 0;
   }   

   // Function button processing
   if (DI_Onup_a == 1 && ModeTest == 0 && Timermode == 0) {
	   DI_Onup_a = 0;
	   buzzeractivate = 1;          // activate buzzer
	   cursorSet(1,1); Serial.println("   ");
	   ModeDispSet = ModeDispSet + 1;
	   ChangeMode = 1;                           // do we need this var?
	   if (ModeDispSet == 12) { ModeDispSet = 0; }
	   cursorSet(1,1);
   }

   // Aux Switch 1	
   if (DI_Val[8] == 1) {
      Auxsw_uS = pulseMax;
   } else {
	  Auxsw_uS = pulseMin;
   }

   // Aux Switch 2
   if (DI_Val[9] == 1) {
      Auxsw2_uS = pulseMax;
   } else {
	  Auxsw2_uS = pulseMin;
   }   
   
}


// Read Analogue Inputs
void readanalogue() {

   // Read all input pins into AI var array 1
   for(byte i=0; i<AI_pincount; i++) {  
	  AI_Val[i] = analogRead(AI_Raw[i]);
   } 
 
   // Read first 4 inputs again for 5 sample averaging (AEL/ELE/THR/RUD) 
   for(byte i=0; i<3; i++) {  
	  AI_Val2[i] = analogRead(AI_Raw[i]);  // AI var array 2
   }
   for(byte i=0; i<3; i++) {  
	  AI_Val3[i] = analogRead(AI_Raw[i]);  // AI var array 3
   }
   for(byte i=0; i<3; i++) {  
	  AI_Val4[i] = analogRead(AI_Raw[i]);  // AI var array 4
   }
   for(byte i=0; i<3; i++) {  
	  AI_Val5[i] = analogRead(AI_Raw[i]);  // AI var array 5
   }
   for(byte i=0; i<3; i++) {
      AI_Val[i] = (AI_Val[i] + AI_Val2[i] + AI_Val3[i] + AI_Val4[i] + AI_Val5[i]) / 5;  // 5 sample averages
   }
   
   // Incorporate Rate Multiplier then scale inputs to produce PPM values
   Minmult = (pulseMid - (RateMult * ((pulseMax - pulseMin) / 2)));  // Generate scaled graph depending on current RateMult
   Maxmult = (pulseMid + (RateMult * ((pulseMax - pulseMin) / 2)));
   
   if (ReverseElevator == 0) {
     if (AI_Val[0] < ELE_Center) { AI_Eleva = map(AI_Val[0], ELE_Min, ELE_Center-1, Minmult, pulseMid) + TrEleEEprom; }          // Elevator / Aeleron 2
     if (AI_Val[0] >= ELE_Center) { AI_Eleva = map(AI_Val[0], ELE_Center, ELE_Max, pulseMid + 1, Maxmult) + TrEleEEprom; }       // Elevator / Aeleron 2
   } else {
     if (AI_Val[0] < ELE_Center) { AI_Eleva = map(AI_Val[0], ELE_Max, ELE_Center, Minmult, pulseMid) + TrEleEEprom; }            // Elevator / Aeleron 2 (reversed)
     if (AI_Val[0] >= ELE_Center) { AI_Eleva = map(AI_Val[0], ELE_Center-1, ELE_Min, pulseMid + 1, Maxmult) + TrEleEEprom; }     // Elevator / Aeleron 2 (reversed)
   }
   
   if (ReverseAeleron == 0) {  
     if (AI_Val[1] < AEL_Center) { AI_Aeler = map(AI_Val[1], AEL_Min, AEL_Center-1, Minmult, pulseMid) + TrAelEEprom; }          // Aeleron 1
     if (AI_Val[1] >= AEL_Center) { AI_Aeler = map(AI_Val[1], AEL_Center, AEL_Max, pulseMid + 1, Maxmult) + TrAelEEprom; }       // Aeleron 1
   } else {   
     if (AI_Val[1] < AEL_Center) { AI_Aeler = map(AI_Val[1], AEL_Max, AEL_Center, Minmult, pulseMid) + TrAelEEprom; }            // Aeleron 1 (reversed)
     if (AI_Val[1] >= AEL_Center) { AI_Aeler = map(AI_Val[1], AEL_Center-1, AEL_Min, pulseMid + 1, Maxmult) + TrAelEEprom; }     // Aeleron 1 (reversed)
   }

   if (ReverseRudder == 0) {   
     if (AI_Val[2] < RUD_Center) { AI_Rudde = map(AI_Val[2], RUD_Min, RUD_Center-1, Minmult, pulseMid) + TrRudEEprom; }          // Rudder  
     if (AI_Val[2] >= RUD_Center) { AI_Rudde = map(AI_Val[2], RUD_Center, RUD_Max, pulseMid + 1, Maxmult) + TrRudEEprom; }       // Rudder  
   } else {
     if (AI_Val[2] < RUD_Center) { AI_Rudde = map(AI_Val[2], RUD_Max, RUD_Center, Minmult, pulseMid) + TrRudEEprom; }            // Rudder (reversed)
     if (AI_Val[2] >= RUD_Center) { AI_Rudde = map(AI_Val[2], RUD_Center-1, RUD_Min, pulseMid + 1, Maxmult) + TrRudEEprom; }     // Rudder (reversed)
   }
   
   AI_Throt = map(AI_Val[3], THR_Min, THR_Max, pulseMin, pulseMax) + 0;       // Throttle
   AI_Auxpot = map(AI_Val[4], AUX_Min, AUX_Max, pulseMax, pulseMin) + 0;      // Aux pot 1
   AI_Auxpot2 = map(AI_Val[6], AUX2_Min, AUX2_Max, pulseMax, pulseMin) + 0;   // Aux pot 2
}


// Check limits & set outputs
void checklimitsmodessetouputs() {
 
   // Exponential Aelerons
   if (ReverseAeleron == 0) {
       if (ExpoModeAEL == 1) {
           if (AI_Val[1] < AEL_Center ){
	          AI_AelerF = AI_Aeler - pulseMid;  // zero
	          AI_AelerF = ((((AI_AelerF*-1)/10) * ((AI_AelerF*-1)/10))) * -1;  // low side calc
		      AI_AelerF = AI_AelerF * .3;  // reduce gain
	          AI_Aeler = AI_AelerF + pulseMid;
           }
           if (AI_Val[1] >= AEL_Center ){
              AI_AelerF = AI_Aeler - pulseMid;  // zero
	          AI_AelerF = (AI_AelerF/10) * (AI_AelerF/10);  // high side calc
			  AI_AelerF = AI_AelerF * .3;  // reduce gain
	          AI_Aeler = AI_AelerF + pulseMid;
           }
       }
   } else {
        if (ExpoModeAEL == 1) {
           if (AI_Val[1] < AEL_Center ){
              AI_AelerF = AI_Aeler - pulseMid;  // zero
	          AI_AelerF = (AI_AelerF/10) * (AI_AelerF/10);  // high side calc
			  AI_AelerF = AI_AelerF * .3;  // reduce gain
	          AI_Aeler = AI_AelerF + pulseMid;
           }
           if (AI_Val[1] >= AEL_Center ){
	          AI_AelerF = AI_Aeler - pulseMid;  // zero
	          AI_AelerF = ((((AI_AelerF*-1)/10) * ((AI_AelerF*-1)/10))) * -1;  // low side calc
		      AI_AelerF = AI_AelerF * .3;  // reduce gain
	          AI_Aeler = AI_AelerF + pulseMid;
           }
       }  
   
   }

   // Exponential Elevators
   if (ReverseElevator == 0) {
       if (ExpoModeELE == 1) {
           if (AI_Val[0] < ELE_Center ){
	          AI_ElevaF = AI_Eleva - pulseMid;  // zero
	          AI_ElevaF = ((((AI_ElevaF*-1)/10) * ((AI_ElevaF*-1)/10))) * -1;  // low side calc
		      AI_ElevaF = AI_ElevaF * .3;  // reduce gain
	          AI_Eleva = AI_ElevaF + pulseMid;
           }
           if (AI_Val[0] >= ELE_Center ){
              AI_ElevaF = AI_Eleva - pulseMid;  // zero
	          AI_ElevaF = (AI_ElevaF/10) * (AI_ElevaF/10);  // high side calc
		      AI_ElevaF = AI_ElevaF * .3;  // reduce gain
	          AI_Eleva = AI_ElevaF + pulseMid;
           }
       }
   } else {
       if (ExpoModeELE == 1) {
           if (AI_Val[0] < ELE_Center ){
              AI_ElevaF = AI_Eleva - pulseMid;  // zero
	          AI_ElevaF = (AI_ElevaF/10) * (AI_ElevaF/10);  // high side calc
		      AI_ElevaF = AI_ElevaF * .3;  // reduce gain
	          AI_Eleva = AI_ElevaF + pulseMid;
           }
           if (AI_Val[0] >= ELE_Center ){
	          AI_ElevaF = AI_Eleva - pulseMid;  // zero
	          AI_ElevaF = ((((AI_ElevaF*-1)/10) * ((AI_ElevaF*-1)/10))) * -1;  // low side calc
		      AI_ElevaF = AI_ElevaF * .3;  // reduce gain
	          AI_Eleva = AI_ElevaF + pulseMid;
           }
       }   
   }

   // Exponential Rudder
   if (ReverseRudder == 0) {
       if (ExpoModeRUD == 1) {
           if (AI_Val[2] < RUD_Center ){
	          AI_RuddeF = AI_Rudde - pulseMid;  // zero
	          AI_RuddeF = ((((AI_RuddeF*-1)/10) * ((AI_RuddeF*-1)/10))) * -1;  // low side calc
		      AI_RuddeF = AI_RuddeF * .3;  // reduce gain
	          AI_Rudde = AI_RuddeF + pulseMid;
           }
           if (AI_Val[2] >= RUD_Center ){
              AI_RuddeF = AI_Rudde - pulseMid;  // zero
	          AI_RuddeF = (AI_RuddeF/10) * (AI_RuddeF/10);  // high side calc
		      AI_RuddeF = AI_RuddeF * .3;  // reduce gain
	          AI_Rudde = AI_RuddeF + pulseMid;
           }
	   }
   } else { 
       if (ExpoModeRUD == 1) {
           if (AI_Val[2] < RUD_Center ){
              AI_RuddeF = AI_Rudde - pulseMid;  // zero
	          AI_RuddeF = (AI_RuddeF/10) * (AI_RuddeF/10);  // high side calc
		      AI_RuddeF = AI_RuddeF * .3;  // reduce gain
	          AI_Rudde = AI_RuddeF + pulseMid;
           }
           if (AI_Val[2] >= RUD_Center ){
	          AI_RuddeF = AI_Rudde - pulseMid;  // zero
	          AI_RuddeF = ((((AI_RuddeF*-1)/10) * ((AI_RuddeF*-1)/10))) * -1;  // low side calc
		      AI_RuddeF = AI_RuddeF * .3;  // reduce gain
	          AI_Rudde = AI_RuddeF + pulseMid;
           }
	   }
   }   
   
   // Flying Wing - Elevon mode assumes Aeleron servo's mounted mirror image to each other
   if (ElevonMode == 1) {
      AI_Aeler2 = AI_Aeler;              // Generate 2nd Aeleron var
   	  AI_Elevon = AI_Eleva - pulseMid;   // Copy elevator input off & zero it, this becomes the modifier for the 2 Aelerons
	  AI_Aeler = AI_Aeler + AI_Elevon;   // Output - Aeleron 1 goes up
      AI_Eleva = AI_Aeler2 - AI_Elevon;  // Output - Aeleron 2 goes down  (inverted servo) 
   }

   // Check limits
   if (AI_Aeler < pulseMin) AI_Aeler = pulseMin;
   if (AI_Aeler > pulseMax) AI_Aeler = pulseMax;   
   if (AI_Eleva < pulseMin) AI_Eleva = pulseMin;
   if (AI_Eleva > pulseMax) AI_Eleva = pulseMax; 
   if (AI_Throt < pulseMin) AI_Throt = pulseMin;
   if (AI_Throt > pulseMax) AI_Throt = pulseMax; 
   if (AI_Rudde < pulseMin) AI_Rudde = pulseMin;
   if (AI_Rudde > pulseMax) AI_Rudde = pulseMax;   
   if (AI_Auxpot < pulseMin) AI_Auxpot = pulseMin;
   if (AI_Auxpot > pulseMax) AI_Auxpot = pulseMax;  
   if (AI_Auxpot2 < pulseMin) AI_Auxpot2 = pulseMin;
   if (AI_Auxpot2 > pulseMax) AI_Auxpot2 = pulseMax;  
   
   // Load PPM channel array with final channel values
   PPM_array[0] = AI_Aeler + Fixed_uS;
   PPM_array[1] = AI_Eleva + Fixed_uS;
   PPM_array[2] = AI_Throt + Fixed_uS;
   PPM_array[3] = AI_Rudde + Fixed_uS;
   PPM_array[4] = Auxsw_uS + Fixed_uS;
   PPM_array[5] = AI_Auxpot + Fixed_uS;
   PPM_array[6] = AI_Auxpot2 + Fixed_uS;
   PPM_array[7] = Auxsw2_uS + Fixed_uS;
}
