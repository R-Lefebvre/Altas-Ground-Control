void ParallaxLCDSetup(){
  Serial3.begin(19200);     //start communications 
  delay(100);
  backlightOnPLCD();
  Serial3.write(22);
  clearPLCD();
  Serial3.print("Altas Ground Control");
  Serial3.print("By: Robert Lefebvre");
  delay(1000);
  initTuneLCD();
  delay(1500);
  clearPLCD();
}

// Two tone beep to signal end of boot-up
void initTuneLCD(){
    Serial3.write(218);
    Serial3.write(212);  
    Serial3.write(222);
    Serial3.write(213);
    Serial3.write(231);
}

// clear the LCD
void clearPLCD(){
  Serial3.write(12);
}

// backspace and erase previous character
void backSpacePLCD() { 
  Serial3.write(8);
  Serial3.write(32);
  Serial3.write(8);
}

// turn on backlight 
void backlightOnPLCD(){
  Serial3.write(17);
}

// turn off backlight
void backlightOffPLCD(){
  Serial3.write(18);
}

// move the cursor to a specific place
// e.g.: cursorSet(3,2) sets the cursor to x = 3 and y = 2
void cursorSet(int xpos, int ypos){  
  int temp = 128;
  temp = temp + (xpos + 20 * ypos);  
  Serial3.write(temp); //Row position 
}

void deletePLCD(int xpos, int ypos){
    cursorSet (xpos, ypos);
    Serial3.print(" ");
}   