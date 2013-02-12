

// Function to beep twice on boot-up

void init_beep(){
    digitalWrite(PIEZO_OUTPUT_PIN, HIGH);
    delay(50);
    digitalWrite(PIEZO_OUTPUT_PIN, LOW);
    delay(50);
    digitalWrite(PIEZO_OUTPUT_PIN, HIGH);
    delay(50);
    digitalWrite(PIEZO_OUTPUT_PIN, LOW);
}


// Function to initialize the Input/Output
void init_input_output(){
    pinMode(PPM_OUTPUT_PIN, OUTPUT);                                                  
    pinMode(FLIGHT_MODE_1_LED_PIN, OUTPUT);
    pinMode(FLIGHT_MODE_2_LED_PIN, OUTPUT);
    pinMode(FLIGHT_MODE_3_LED_PIN, OUTPUT);
    pinMode(FLIGHT_MODE_4_LED_PIN, OUTPUT);
    pinMode(FLIGHT_MODE_5_LED_PIN, OUTPUT);
    pinMode(FLIGHT_MODE_6_LED_PIN, OUTPUT);
    pinMode(CH7_SWITCH_LED_PIN, OUTPUT);
    pinMode(CH8_SWITCH_LED_PIN, OUTPUT);
    pinMode(PIEZO_OUTPUT_PIN, OUTPUT);                                                
    
}


// Function to initialize the PPM Channel Array

void init_PPM_array(){
    char i=0;
    for(i=0; i<8; i++) { PPM_array[i] = PWM_MIN; }
    PPM_array[i] = -1;   // Mark end
}


// Function to initialize the PPM Generator

void init_PPM_gen(){
    
    // Initialise ISR Timer 1 - PPM generation
    TCCR1A = B00110001;  // Compare register B used in mode 3
    TCCR1B = B00010010;  // WGM13 & CS11 set to 1
    TCCR1C = B00000000;  // All set to 0
    TIMSK1 = B00000010;  // Interrupt on compare B
    TIFR1  = B00000010;  // Interrupt on compare B
    OCR1A = PPM_FREQUENCY;  // PPM frequency
    OCR1B = PPM_CHANNEL_SPACING;    // PPM off time (lo padding)
  
    // Initialise ISR Timer 2 - Subroutine timing
    // Interrupt rate =  16MHz / (prescaler * (255 - TCNT2))
    // period [sec] = (1 / f_clock [sec]) * prescale * (255-count)
    //                (1/16000000)  * 1024 * (255-178) = .004992sec = 4.992mS
    TCCR2B = B00000000;   // Disable Timer2 while we set it up
    TCNT2  = 178;         // Reset Timer Count  (255-"178")
    TIFR2  = B00000000;   // Timer2 INT Flag Reg: Clear Timer Overflow Flag
    TIMSK2 = B00000001;   // Timer2 INT Reg: Timer2 Overflow Interrupt Enable
    TCCR2A = B00000000;   // Timer2 Control Reg A: Wave Gen Mode normal
    TCCR2B = B00000111;   // Timer2 Control Reg B: Timer Prescaler set to 1024
}

// Function to turn on/off all the LED outputs
void bulb_check(bool state){
    digitalWrite(FLIGHT_MODE_1_LED_PIN, state);
    digitalWrite(FLIGHT_MODE_2_LED_PIN, state);
    digitalWrite(FLIGHT_MODE_3_LED_PIN, state);
    digitalWrite(FLIGHT_MODE_4_LED_PIN, state);
    digitalWrite(FLIGHT_MODE_5_LED_PIN, state);
    digitalWrite(FLIGHT_MODE_6_LED_PIN, state);
    digitalWrite(CH7_SWITCH_LED_PIN, state);
    digitalWrite(CH8_SWITCH_LED_PIN, state);
}

void serial_debug(void){

    Serial.println("Raw Input Values");
    for(byte i=0; i<6; i++) {
      Serial.print(i+1);
      Serial.print("  Int:");
	  Serial.print(AI_Val[i]);
      Serial.print("  PWM:");
      Serial.println(PPM_array[i]);
   }
    
    
}


