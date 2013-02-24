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
int Minmult;
int Maxmult;

// Read Digital Inputs
void readdigital() {

   // Read input pins into var array
   for(byte i=0; i<DIGITAL_INPUT_PINCOUNT; i++) {  
	  DI_Val[i] = digitalRead(DI_Raw[i]);
   }  

   // Process the panel pushbuttons for onup functionality
   
   // Function Button
   
   if (DI_Val[0] == 0) { DItemp_a = 1; }   // Button 2 down
   if (DI_Val[0] == 1 && DItemp_a == 1) {  // Button 2 now up
       DI_Onup_a = 1;
	   DItemp_a= 0;
   }

   
   
   // Trim Adjust Panel Button
   if (DI_Val[1] == 0) { DItemp_b = 1; }   // Button 3 down
   if (DI_Val[1] == 1 && DItemp_b == 1) {  // Button 3 now up
       DI_Onup_b = 1;
	   DItemp_b = 0;
   }
   
   // Trim Adjust Panel Button
   if (DI_Val[2] == 0) { DItemp_c = 1; }   // Button 4 down
   if (DI_Val[2] == 1 && DItemp_c == 1) {  // Button 4 now up
       DI_Onup_c = 1;
	   DItemp_c = 0;
   }
   
   // HI/LOW Rates Panel Button
   if (DI_Val[3] == 0) { DItemp_d = 1; }   // Button 5 down
   if (DI_Val[3] == 1 && DItemp_d == 1) {  // Button 5 now up
       DI_Onup_d = 1;
	   DItemp_d = 0;
   }   

   // Function button processing
   
   if (DI_Onup_a == 1 && Timermode == 0) {
	   DI_Onup_a = 0;
	   buzzeractivate = 1;          // activate buzzer
	   cursorSet(1,0); Serial3.println("   ");
	   ModeDispSet = ModeDispSet + 1;
	   ChangeMode = 1;                           // do we need this var?
	   if (ModeDispSet == 10) { ModeDispSet = 0; }
	   cursorSet(1,0);
   }
   

    // Ch7 Switch	
    if (DI_Val[9] == 1) {                                                           // Ch7 switch is down
        Auxsw_uS = CH7_PWM_LOW;
        digitalWrite (CH7_SWITCH_LED_PIN, LOW);
    } else {
        Auxsw_uS = CH7_PWM_HIGH;
        digitalWrite (CH7_SWITCH_LED_PIN, HIGH);
    }
   
    if ( DI_Val[10] == 1 ){                                                         // Ch8 switch is down
        AI_Auxpot2 = CH8_PWM_LOW;
        digitalWrite (CH8_SWITCH_LED_PIN, LOW);
    } else {
        AI_Auxpot2 = map(AI_Val[5], CH8_MIN, CH8_MAX, CH8_PWM_LOW, CH8_PWM_HIGH);   // Aux pot 2
        digitalWrite (CH8_SWITCH_LED_PIN, HIGH);
    }
   
}

void control_flight_mode(){

    for(int i=1; i<=6; i++){
        FMB_State[i] = digitalRead(Flight_Mode_Inputs[i]);
    }
    
    for(int i=1; i<=6; i++) {
        if ((FMB_State[i] == 0) && (FMB_State_Old[i] == 0) && (FMB_State_Falling[i] == 0)){
            FMB_State_Falling[i] = 1;
            if (Active_Flight_Mode != i){
                Old_Flight_Mode = Active_Flight_Mode;
                Active_Flight_Mode = i;
                buzzeractivate = 1;
                digitalWrite (Flight_Mode_LED[Old_Flight_Mode], LOW);
                digitalWrite (Flight_Mode_LED[Active_Flight_Mode], HIGH);
                Active_Flight_Mode_PWM = Flight_Mode_PWM[Active_Flight_Mode];
            }
        } else if ((FMB_State[i] == 1) && (FMB_State_Old[i] == 1)) {
            FMB_State_Falling[i] = 0;
        }
    }
    
    for(int i=1; i<=6; i++){ 
        FMB_State_Old[i] = FMB_State[i];
    }
}


// Read Analogue Inputs
void readanalogue() {

    // Read all input pins into AI var array 1
    for(byte i=0; i<ANALOG_INPUT_PINCOUNT; i++) {  
        AI_Val[i] = analogRead(AI_Pin[i]);
    } 
 
    // Read first 4 inputs again for 5 sample averaging (AEL/ELE/THR/RUD) 
    for(byte i=0; i<3; i++) {  
        AI_Val2[i] = analogRead(AI_Pin[i]);  // AI var array 2
    }
    for(byte i=0; i<3; i++) {  
        AI_Val3[i] = analogRead(AI_Pin[i]);  // AI var array 3
    }
    for(byte i=0; i<3; i++) {  
        AI_Val4[i] = analogRead(AI_Pin[i]);  // AI var array 4
    }
    for(byte i=0; i<3; i++) {  
        AI_Val5[i] = analogRead(AI_Pin[i]);  // AI var array 5
    }
    for(byte i=0; i<3; i++) {
        AI_Val[i] = (AI_Val[i] + AI_Val2[i] + AI_Val3[i] + AI_Val4[i] + AI_Val5[i]) / 5;  // 5 sample averages
    }
   
    // Incorporate Rate Multiplier then scale inputs to produce PPM values
    Minmult = (PWM_MID - (RateMult * ((PWM_MAX - PWM_MIN) / 2)));  // Generate scaled graph depending on current RateMult
    Maxmult = (PWM_MID + (RateMult * ((PWM_MAX - PWM_MIN) / 2)));
   
    if (ReverseAeleron == 0) {  
        if (AI_Val[0] < ROLL_MID) { AI_Aeler = map(AI_Val[0], ROLL_MIN, ROLL_MID-1, Minmult, PWM_MID) + TrAelEEprom; }          // Aeleron 1
        if (AI_Val[0] >= ROLL_MID) { AI_Aeler = map(AI_Val[0], ROLL_MID, ROLL_MAX, PWM_MID + 1, Maxmult) + TrAelEEprom; }       // Aeleron 1
    } else {   
        if (AI_Val[0] < ROLL_MID) { AI_Aeler = map(AI_Val[0], ROLL_MAX, ROLL_MID, Minmult, PWM_MID) + TrAelEEprom; }            // Aeleron 1 (reversed)
        if (AI_Val[0] >= ROLL_MID) { AI_Aeler = map(AI_Val[0], ROLL_MID-1, ROLL_MIN, PWM_MID + 1, Maxmult) + TrAelEEprom; }     // Aeleron 1 (reversed)
    }

    if (ReverseElevator == 0) {
        if (AI_Val[1] < PITCH_MID) { AI_Eleva = map(AI_Val[1], PITCH_MIN, PITCH_MID-1, Minmult, PWM_MID) + TrEleEEprom; }          // Elevator 
        if (AI_Val[1] >= PITCH_MID) { AI_Eleva = map(AI_Val[1], PITCH_MID, PITCH_MAX, PWM_MID + 1, Maxmult) + TrEleEEprom; }       // Elevator 
    } else {
        if (AI_Val[1] < PITCH_MID) { AI_Eleva = map(AI_Val[1], PITCH_MAX, PITCH_MID, Minmult, PWM_MID) + TrEleEEprom; }            // Elevator (reversed)
        if (AI_Val[1] >= PITCH_MID) { AI_Eleva = map(AI_Val[1], PITCH_MID-1, PITCH_MIN, PWM_MID + 1, Maxmult) + TrEleEEprom; }     // Elevator (reversed)
    }
   
    if (ReverseRudder == 0) {   
        if (AI_Val[3] < YAW_MID) { AI_Rudde = map(AI_Val[3], YAW_MIN, YAW_MID-1, Minmult, PWM_MID) + TrRudEEprom; }          // Rudder  
        if (AI_Val[3] >= YAW_MID) { AI_Rudde = map(AI_Val[3], YAW_MID, YAW_MAX, PWM_MID + 1, Maxmult) + TrRudEEprom; }       // Rudder  
    } else {
        if (AI_Val[3] < YAW_MID) { AI_Rudde = map(AI_Val[3], YAW_MAX, YAW_MID, Minmult, PWM_MID) + TrRudEEprom; }            // Rudder (reversed)
        if (AI_Val[3] >= YAW_MID) { AI_Rudde = map(AI_Val[3], YAW_MID-1, YAW_MIN, PWM_MID + 1, Maxmult) + TrRudEEprom; }     // Rudder (reversed)
    }
   
    AI_Throt = map(AI_Val[2], THROTTLE_MIN, THROTTLE_MAX, PWM_MIN, PWM_MAX);    // Throttle
    AI_Auxpot1 = map(AI_Val[4], CH6_MIN, CH6_MAX, PWM_MIN, PWM_MAX);             // Aux pot 1    
}


// Check limits & set outputs
void checklimitsmodessetouputs() {
 
   // Exponential Aelerons
   if (ReverseAeleron == 0) {
       if (ExpoModeAEL == 1) {
           if (AI_Val[0] < ROLL_MID ){
	          AI_AelerF = AI_Aeler - PWM_MID;  // zero
	          AI_AelerF = ((((AI_AelerF*-1)/10) * ((AI_AelerF*-1)/10))) * -1;  // low side calc
		      AI_AelerF = AI_AelerF * .3;  // reduce gain
	          AI_Aeler = AI_AelerF + PWM_MID;
           }
           if (AI_Val[0] >= ROLL_MID ){
              AI_AelerF = AI_Aeler - PWM_MID;  // zero
	          AI_AelerF = (AI_AelerF/10) * (AI_AelerF/10);  // high side calc
			  AI_AelerF = AI_AelerF * .3;  // reduce gain
	          AI_Aeler = AI_AelerF + PWM_MID;
           }
       }
   } else {
        if (ExpoModeAEL == 1) {
           if (AI_Val[0] < ROLL_MID ){
              AI_AelerF = AI_Aeler - PWM_MID;  // zero
	          AI_AelerF = (AI_AelerF/10) * (AI_AelerF/10);  // high side calc
			  AI_AelerF = AI_AelerF * .3;  // reduce gain
	          AI_Aeler = AI_AelerF + PWM_MID;
           }
           if (AI_Val[0] >= ROLL_MID ){
	          AI_AelerF = AI_Aeler - PWM_MID;  // zero
	          AI_AelerF = ((((AI_AelerF*-1)/10) * ((AI_AelerF*-1)/10))) * -1;  // low side calc
		      AI_AelerF = AI_AelerF * .3;  // reduce gain
	          AI_Aeler = AI_AelerF + PWM_MID;
           }
       }  
   
   }

   // Exponential Elevators
   if (ReverseElevator == 0) {
       if (ExpoModeELE == 1) {
           if (AI_Val[1] < PITCH_MID ){
	          AI_ElevaF = AI_Eleva - PWM_MID;  // zero
	          AI_ElevaF = ((((AI_ElevaF*-1)/10) * ((AI_ElevaF*-1)/10))) * -1;  // low side calc
		      AI_ElevaF = AI_ElevaF * .3;  // reduce gain
	          AI_Eleva = AI_ElevaF + PWM_MID;
           }
           if (AI_Val[1] >= PITCH_MID ){
              AI_ElevaF = AI_Eleva - PWM_MID;  // zero
	          AI_ElevaF = (AI_ElevaF/10) * (AI_ElevaF/10);  // high side calc
		      AI_ElevaF = AI_ElevaF * .3;  // reduce gain
	          AI_Eleva = AI_ElevaF + PWM_MID;
           }
       }
   } else {
       if (ExpoModeELE == 1) {
           if (AI_Val[1] < PITCH_MID ){
              AI_ElevaF = AI_Eleva - PWM_MID;  // zero
	          AI_ElevaF = (AI_ElevaF/10) * (AI_ElevaF/10);  // high side calc
		      AI_ElevaF = AI_ElevaF * .3;  // reduce gain
	          AI_Eleva = AI_ElevaF + PWM_MID;
           }
           if (AI_Val[1] >= PITCH_MID ){
	          AI_ElevaF = AI_Eleva - PWM_MID;  // zero
	          AI_ElevaF = ((((AI_ElevaF*-1)/10) * ((AI_ElevaF*-1)/10))) * -1;  // low side calc
		      AI_ElevaF = AI_ElevaF * .3;  // reduce gain
	          AI_Eleva = AI_ElevaF + PWM_MID;
           }
       }   
   }

   // Exponential Rudder
   if (ReverseRudder == 0) {
       if (ExpoModeRUD == 1) {
           if (AI_Val[3] < YAW_MID ){
	          AI_RuddeF = AI_Rudde - PWM_MID;  // zero
	          AI_RuddeF = ((((AI_RuddeF*-1)/10) * ((AI_RuddeF*-1)/10))) * -1;  // low side calc
		      AI_RuddeF = AI_RuddeF * .3;  // reduce gain
	          AI_Rudde = AI_RuddeF + PWM_MID;
           }
           if (AI_Val[3] >= YAW_MID ){
              AI_RuddeF = AI_Rudde - PWM_MID;  // zero
	          AI_RuddeF = (AI_RuddeF/10) * (AI_RuddeF/10);  // high side calc
		      AI_RuddeF = AI_RuddeF * .3;  // reduce gain
	          AI_Rudde = AI_RuddeF + PWM_MID;
           }
	   }
   } else { 
       if (ExpoModeRUD == 1) {
           if (AI_Val[3] < YAW_MID ){
              AI_RuddeF = AI_Rudde - PWM_MID;  // zero
	          AI_RuddeF = (AI_RuddeF/10) * (AI_RuddeF/10);  // high side calc
		      AI_RuddeF = AI_RuddeF * .3;  // reduce gain
	          AI_Rudde = AI_RuddeF + PWM_MID;
           }
           if (AI_Val[3] >= YAW_MID ){
	          AI_RuddeF = AI_Rudde - PWM_MID;  // zero
	          AI_RuddeF = ((((AI_RuddeF*-1)/10) * ((AI_RuddeF*-1)/10))) * -1;  // low side calc
		      AI_RuddeF = AI_RuddeF * .3;  // reduce gain
	          AI_Rudde = AI_RuddeF + PWM_MID;
           }
	   }
   }   
   
      // Check limits
   if (AI_Aeler < PWM_MIN) AI_Aeler = PWM_MIN;
   if (AI_Aeler > PWM_MAX) AI_Aeler = PWM_MAX;   
   if (AI_Eleva < PWM_MIN) AI_Eleva = PWM_MIN;
   if (AI_Eleva > PWM_MAX) AI_Eleva = PWM_MAX; 
   if (AI_Throt < PWM_MIN) AI_Throt = PWM_MIN;
   if (AI_Throt > PWM_MAX) AI_Throt = PWM_MAX; 
   if (AI_Rudde < PWM_MIN) AI_Rudde = PWM_MIN;
   if (AI_Rudde > PWM_MAX) AI_Rudde = PWM_MAX;   
   if (AI_Auxpot1 < PWM_MIN) AI_Auxpot1 = PWM_MIN;
   if (AI_Auxpot1 > PWM_MAX) AI_Auxpot1 = PWM_MAX;  
   if (AI_Auxpot2 < PWM_MIN) AI_Auxpot2 = PWM_MIN;
   if (AI_Auxpot2 > PWM_MAX) AI_Auxpot2 = PWM_MAX;  
   
   // Load PPM channel array with final channel values
   PPM_array[0] = AI_Aeler + PPM_CHANNEL_SPACING;                   // Channel 1 Roll
   PPM_array[1] = AI_Eleva + PPM_CHANNEL_SPACING;                   // Channel 2 Pitch
   PPM_array[2] = AI_Throt + PPM_CHANNEL_SPACING;                   // Channel 3 Throttle
   PPM_array[3] = AI_Rudde + PPM_CHANNEL_SPACING;                   // Channel 4 Yaw
   PPM_array[4] = Active_Flight_Mode_PWM + PPM_CHANNEL_SPACING;     // Channel 5 Flight Mode
   PPM_array[5] = AI_Auxpot1 + PPM_CHANNEL_SPACING;                 // Channel 6 Ch6 Tuning
   PPM_array[6] = Auxsw_uS + PPM_CHANNEL_SPACING;                   // Channel 7 Ch7 Switch
   PPM_array[7] = AI_Auxpot2 + PPM_CHANNEL_SPACING;                 // Channel 8 Ch8 Aux Knob
}
