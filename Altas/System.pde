

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
    pinMode(PPM_OUTPUT_PIN, OUTPUT);                                                  // sets as output
    pinMode(PIEZO_OUTPUT_PIN, OUTPUT);                                                // sets as output
    for(byte i=0; i<DIGITAL_INPUT_PINCOUNT; i++) { pinMode(DI_Raw[i], INPUT); }       // set digital inputs
    for(byte i=0; i<DIGITAL_INPUT_PINCOUNT; i++) { digitalWrite(DI_Raw[i], HIGH); }   // turn on pull-up resistors
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

