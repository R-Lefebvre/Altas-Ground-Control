/*

Interrupt Timers

*/

int ACC_PPM_length = 0;          // Pulse length current total, used to calculate sync pulse
int *PPM_pointer = PPM_array;
int PPM_len;

// *********************** TIMER 1 **************************
ISR(TIMER1_COMPA_vect) {
  PPM_len = *(PPM_pointer++);
  if(PPM_len > -1) {
    OCR1A = PPM_len;                        // Set pulse length
    ACC_PPM_length += PPM_len;              // Add pulse length to accumulator
  } else {
    PPM_pointer = PPM_array;                // Reset table position pointer
    OCR1A = PPMFreq_uS - ACC_PPM_length;    // Calculate final sync pulse length
    ACC_PPM_length = 0;                     // Reset accumulator
  }
}

// *********************** TIMER 2 **************************
ISR(TIMER2_OVF_vect) {
  tick0 = tick0 + 1;                        // update timing tick
  tick1 = tick1 + 1;                        // update timing tick
  tick2 = tick2 + 1;                        // update timing tick
  tick3 = tick3 + 1;                        // update timing tick
  TCNT2 = 155;                              // reset timer cnt to 155 out of 255
  TIFR2 = 0x00;                             // timer2 int flag reg: clear timer overflow flag
}
