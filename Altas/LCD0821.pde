/*

LCD = Matrix Orbital LCD0821

IMPORTANT: Please make sure the Tx to the LCD is disconnected when updating
the Arduino code as it can/will corrupt the LCD permanently.

*/

// clear the LCD
void clearLCD(){
  Serial.write(byte(254));
  Serial.write(byte(88));
}

// start a new line
void newLine() { 
  Serial.write(byte(254));
  Serial.write(byte(10));
}

// move the cursor to the home position
void cursorHome(){
  Serial.write(byte(254));
  Serial.write(byte(72));
}

// move the cursor to a specific place
// e.g.: cursorSet(3,2) sets the cursor to x = 3 and y = 2
void cursorSet(int xpos, int ypos){  
  Serial.write(byte(254));
  Serial.write(byte(71));
  Serial.write(byte(xpos)); //Column position  
  Serial.write(byte(ypos)); //Row position 
} 

// backspace and erase previous character
void backSpace() { 
  Serial.write(byte(254));
  Serial.write(byte(8));
}

// move cursor left
void cursorLeft(){    
  Serial.write(byte(254));
  Serial.write(byte(76));  
}

// move cursor right
void cursorRight(){
  Serial.write(byte(254));
  Serial.write(byte(77));  
}

// set LCD remember, 0 (no) or 1 (yes)
void setRemember(int remember){
  Serial.write(byte(254));
  Serial.write(byte(147)); 
  Serial.write(remember);  
}

// set LCD data lock, 0 = unlock
void setDatalock(int datalock){
  Serial.write(byte(254));
  Serial.write(byte(202));
  Serial.write(byte(245));
  Serial.write(byte(160));
  Serial.write(datalock);  
}

// set LCD data lock set n save
void setDatalocksetnsave(int datalocksetnsave){
  Serial.write(byte(254));
  Serial.write(byte(203));
  Serial.write(byte(245));
  Serial.write(byte(160));
  Serial.write(datalocksetnsave);
}

// set LCD startup screen
void setStartupLCD(){
  Serial.write(byte(254));
  Serial.write(byte(64));
  Serial.write("HELLO...");  
}

// set LCD Init medium chars
void setInitMediumLCD(){
  Serial.write(byte(254));
  Serial.write(byte(109));  
}

// set LCD read version number
void setReadVersionNoLCD(){
  Serial.write(byte(254));
  Serial.write(byte(54));  
}

// set LCD read lcd type
void setReadModuleTypeLCD(){
  Serial.write(byte(254));
  Serial.write(byte(55));
}

// set LCD Init horizontal bars
void setHorizontalBarsLCD(){
  Serial.write(byte(254));
  Serial.write(byte(104));  
}

// set LCD Place medium chars
void setPlaceMediumLCD(){
  Serial.write(byte(254));
  Serial.write(byte(111));
  Serial.write(byte(1));
  Serial.write(byte(1));
  Serial.write("A"); // testing
}

// set LCD contrast 0-255
void setContrast(int contrast){
  Serial.write(byte(254));
  Serial.write(byte(80));
  Serial.write(contrast);
}

// set LCD brightness 0-255
void setBrightness(int brightness){
  Serial.write(byte(254));
  Serial.write(byte(153));
  Serial.write(brightness);
}

// turn on backlight 0-100mins
void backlightOn(int minutes){
  Serial.write(byte(254));
  Serial.write(byte(66));
  minutes = 0;
  Serial.write(minutes); // use 0 minutes to turn the backlight on indefinitely   
}

// turn off backlight
void backlightOff(){
  Serial.write(byte(254));
  Serial.write(byte(70));
}

// turn off auto scroll
void autoscrolloff(){
  Serial.write(byte(254));
  Serial.write(byte(82));  
}

// turn off auto line wrap
void autolinewrapoff(){
  Serial.write(byte(254));
  Serial.write(byte(68));
}

// turn on auto line wrap
void autolinewrapon(){
  Serial.write(byte(254));
  Serial.write(byte(66));
}

// turn off block cursor
void blockcursoroff(){
  Serial.write(byte(254));
  Serial.write(byte(84));
}

// turn off underline cursor
void underlinecursoroff(){
  Serial.write(byte(254));
  Serial.write(byte(75));
}

// *********************** Setup **************************
void LCDSetup(){
  Serial.begin(19200);     //start communications with LCD screen Matrix Orbital LCD0821
  Serial.write(byte(12));
  autoscrolloff();
  autolinewrapoff();
  blockcursoroff();
  underlinecursoroff();
  backlightOn(0);
  setBrightness(100);
  clearLCD();
  cursorSet(1,1);
  Serial.println(Version[0]);
  cursorSet(1,2);
  Serial.println(Version[1]);
  delay(1000);
}
  
