/*
Display
*/


void Display(){

    if ( ModeDispSet == 0 ) {
        Model_Name_Display(0);
        Timer_Display();
        Battery_Display(); 
    }

    if ( ModeDispSet == 1 ) {
        Model_Choose();
    }
    
    if ( ModeDispSet == 2 ) {
        Trim_Adjust();
        Trim_Display();
    }
    
    if ( ModeDispSet == 3 ) {
        Expo_Display();
    }

    
}

void Model_Choose(){

    static byte peek_model_num = active_model_num;
    static bool peek = true;
    cursorSet(1,0);
    Serial3.print("CURRENT MODEL:");
    cursorSet(18,0);
    Serial3.print(active_model_num);
    Model_Name_Display(1);
    
    if (Button_State[HAT_SWITCH_DOWN_NUM] == 0) {
        buzzeractivate = 2;
        peek_model_num++;
        if (peek_model_num > MODEL_MEMORY_NUM){
            peek_model_num = 1;
        }
        peek = true;
    }
    if (peek){
        EEPROM_Peek(peek_model_num);
    }
    cursorSet(1,2);
    Serial3.print("CHANGE TO MODEL:");
    cursorSet(18,2);
    Serial3.print(peek_model_num);
    cursorSet(0,3);
    for (int i = 0; i < 20; i++){
        Serial3.write(peek_model.model_name[i]);
    }
    
    if (Button_State[MFD_BUTTON_ENTER_NUM] == 0 && peek_model_num != active_model_num) {
        buzzeractivate = 2;
        active_model_num = peek_model_num;
        EEPROM_Load(active_model_num);
    }    
}

void Model_Name_Display(int line){
    cursorSet(0,line);
    for (int i = 0; i < 20; i++){
        Serial3.write(active_model.model_name[i]);
    }
}

void Timer_Display(){

    cursorSet(1,1);
    Serial3.print("Timer1:"); 
    if (timer1_minutes < 10) {
        cursorSet(10,1);
        Serial3.print("0");
        cursorSet(11,1);
        Serial3.print(timer1_minutes);
    }
    
    if (timer1_minutes >= 10) {
        cursorSet(10,1);
        Serial3.print(timer1_minutes);
    }
    
    cursorSet(12,1);
    Serial3.print(":");
    if (timer1_seconds < 10) {
        cursorSet(13,1);
        Serial3.print("0");
        cursorSet(14,1);
        Serial3.print(timer1_seconds);
    }
    
    if (timer1_seconds >= 10) {
        cursorSet(13,1);
        Serial3.print(timer1_seconds);
    }
    
    cursorSet(1,2);
    Serial3.print("Timer2:"); 
    if (active_model.timer2_min < 10) {
        cursorSet(10,2);
        Serial3.print("0");
        cursorSet(11,2);
        Serial3.print(active_model.timer2_min);
    }
    
    if (active_model.timer2_min >= 10) {
        cursorSet(10,2);
        Serial3.print(active_model.timer2_min);
    }
    
    cursorSet(12,2);
    Serial3.print(":");
    if (active_model.timer2_sec < 10) {
        cursorSet(13,2);
        Serial3.print("0");
        cursorSet(14,2);
        Serial3.print(active_model.timer2_sec);
    }
    
    if (active_model.timer2_sec >= 10) {
        cursorSet(13,2);
        Serial3.print(active_model.timer2_sec);
    }
}

void Battery_Display(){
    if (AI_Batte_percent < 10) {
        cursorSet(1,3); Serial3.print("  ");
        cursorSet(3,3); Serial3.print(AI_Batte_percent);
        cursorSet(4,3); Serial3.print("% ");
        cursorSet(6,3); Serial3.print(AI_Batte);
        cursorSet(11,3); Serial3.print("V");
    }
    
    if (AI_Batte_percent >= 10 && AI_Batte_percent < 100) {
        cursorSet(1,3); Serial3.print(" ");
        cursorSet(2,3); Serial3.print(AI_Batte_percent);
        cursorSet(4,3); Serial3.print("% ");
        cursorSet(6,3); Serial3.print(AI_Batte);
        cursorSet(11,3); Serial3.print("V");
    }
    
    if (AI_Batte_percent >= 100) {
        cursorSet(1,3); Serial3.print(AI_Batte_percent);
        cursorSet(4,3); Serial3.print("% ");
        cursorSet(6,3); Serial3.print(AI_Batte);
        cursorSet(11,3); Serial3.print("V");
    }    
}        

void Trim_Display(){
	    
    // Write AEL, ELE or RUD to LCD
    cursorSet(1,0);
    Serial3.print("TRIM SETTINGS");
    cursorSet(1,1); Serial3.print("Pitch");
    cursorSet(1,2); Serial3.print("Roll");

    // Right justify pos numbers
    if (active_model.trim[1] >= 0 && active_model.trim[1] <= 9 ) {
    deletePLCD(7,1);
    cursorSet(8,1); Serial3.print(active_model.trim[1]);
    }
    if (active_model.trim[1] >= 10 && active_model.trim[1] <= 99 ) {
    cursorSet(7,1); Serial3.print(active_model.trim[1]);
    }
    if (active_model.trim[1] >= 100 && active_model.trim[1] <= 999 ) {
    cursorSet(6,1); Serial3.print(active_model.trim[1]);
    }			
    // Right justify neg numbers
    if (active_model.trim[1] >= -9 && active_model.trim[1] <= -1 ) {
    cursorSet(7,1); Serial3.print(active_model.trim[1]);
    }
    if (active_model.trim[1] >= -99 && active_model.trim[1] <= -10 ) {
    cursorSet(6,1); Serial3.print(active_model.trim[1]);
    }
    if (active_model.trim[1] >= -999 && active_model.trim[1] <= -100 ) {
    cursorSet(5,1); Serial3.print(active_model.trim[1]);
    }

    // Right justify pos numbers
    if (active_model.trim[0] >= 0 && active_model.trim[0] <= 9 ) {
    deletePLCD(7,2);
    cursorSet(8,2); Serial3.print(active_model.trim[0]);
    }
    if (active_model.trim[0] >= 10 && active_model.trim[0] <= 99 ) {
    cursorSet(7,2); Serial3.print(active_model.trim[0]);
    }
    if (active_model.trim[0] >= 100 && active_model.trim[0] <= 999 ) {
    cursorSet(6,2); Serial3.print(active_model.trim[0]);
    }			
    // Right justify neg numbers
    if (active_model.trim[0] >= -9 && active_model.trim[0] <= -1 ) {
    cursorSet(7,2); Serial3.print(active_model.trim[0]);
    }
    if (active_model.trim[0] >= -99 && active_model.trim[0] <= -10 ) {
    cursorSet(6,2); Serial3.print(active_model.trim[0]);
    }
    if (active_model.trim[0] >= -999 && active_model.trim[0] <= -100 ) {
    cursorSet(5,2); Serial3.print(active_model.trim[0]);
    }
}

// Exponential Modes
void Expo_Display() {

char* MenuExponentialMode[]={"OFF", " ON"};

	// AEL Exponential Mode setting, 1=OFF, 2=ON

    cursorSet(1,0);
    Serial3.print("EXPONENTIAL MODE");
    cursorSet(2,1);
    Serial3.print("Roll:");
    cursorSet(7,1);
    Serial3.print(MenuExponentialMode[ToDo]);
    cursorSet(1,2);
    Serial3.print("Pitch:");
    cursorSet(7,2);
    Serial3.print(MenuExponentialMode[ToDo]);
    cursorSet(3,3);
    Serial3.print("Yaw:");
    cursorSet(7,3);
    Serial3.print(MenuExponentialMode[ToDo]);
	
}