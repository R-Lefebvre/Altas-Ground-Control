/*
Display
*/


void Display(){

    switch (ModeDispSet){
    
    case MAIN_CONTROL_DISPLAY:

        Model_Name_Display(0);
        Timer_Display();
        Battery_Display(); 
        if (Button_Pulse[MFD_BUTTON_ENTER_NUM]) {
            buzzeractivate = 1;          // activate buzzer
            clearPLCD();
            ModeDispSet = MENU_1_DISPLAY;
            Button_Pulse[MFD_BUTTON_ENTER_NUM] = 0;
        }
    break;
    
    
    case MENU_1_DISPLAY:
    
        Pointer_Display();
        Menu_Display();
        if (Button_Pulse[MFD_BUTTON_BACK_NUM]) {
            buzzeractivate = 1;          // activate buzzer
            clearPLCD();
            ModeDispSet = MAIN_CONTROL_DISPLAY;
            Button_Pulse[MFD_BUTTON_BACK_NUM] = 0;
            Menu_Pointer_Index = 0;
            Menu_Display_Index = 1;
        }
    break;
    
    case MODEL_MENU:
    
        Aircraft_Menu();
        Pointer_Display();
        if (Button_Pulse[MFD_BUTTON_BACK_NUM]) {
            buzzeractivate = 1;          // activate buzzer
            clearPLCD();
            ModeDispSet = MENU_1_DISPLAY;
            Button_Pulse[MFD_BUTTON_BACK_NUM] = 0;
            Menu_Pointer_Index = 0;
            Menu_Display_Index = 1;
        }
    break;

    case MODEL_SELECT_DISPLAY:
    
        Aircraft_Choose();
        if (Button_Pulse[MFD_BUTTON_BACK_NUM]) {
            buzzeractivate = 1;          // activate buzzer
            clearPLCD();
            ModeDispSet = MAIN_CONTROL_DISPLAY;
            EEPROM_Update();
            active_timer2_min = active_model.timer2_min;
            active_timer2_sec = active_model.timer2_sec; 
            Button_Pulse[MFD_BUTTON_BACK_NUM] = 0;
        }
    break;
    
    case TRIM_DISPLAY:
    
        Trim_Adjust();
        Trim_Display();
        if (Button_Pulse[MFD_BUTTON_BACK_NUM]) {
            buzzeractivate = 1;          // activate buzzer
            clearPLCD();
            ModeDispSet = MENU_1_DISPLAY;
            EEPROM_Update();
            Button_Pulse[MFD_BUTTON_BACK_NUM] = 0;
        }
    break;
    
    case TIMER_ADJUST:
    
        Timer_Adjust();
        if (Button_Pulse[MFD_BUTTON_BACK_NUM]) {
            buzzeractivate = 1;          // activate buzzer
            clearPLCD();
            Menu_Cursor_Pos = 0;
            ModeDispSet = MENU_1_DISPLAY;
            EEPROM_Update();
            active_timer2_min = active_model.timer2_min;
            active_timer2_sec = active_model.timer2_sec; 
            Button_Pulse[MFD_BUTTON_BACK_NUM] = 0;
        }
    break;
    
    
    case EXPO_DISPLAY:
    
        Expo_Display();   
        if (Button_Pulse[MFD_BUTTON_BACK_NUM]) {
            buzzeractivate = 1;          // activate buzzer
            clearPLCD();
            ModeDispSet = MENU_1_DISPLAY;
            EEPROM_Update();
            Button_Pulse[MFD_BUTTON_BACK_NUM] = 0;
        }
    break;
    
    } // Switch
}

void Menu_Display(){

    switch(Menu_Display_Index){
    
        case MENU_1_DISPLAY:

            cursorSet(1,0);
            Serial3.print("AIRCRAFT MENU");
            cursorSet(1,1);
            Serial3.print("TRIM ADJUST");
            cursorSet(1,2);
            Serial3.print("EXPO ADJUST");
            cursorSet(1,3);
            Serial3.print("TIMER ADJUST");
            
        break;
        
    }
    
    if (Button_Pulse[MFD_BUTTON_ENTER_NUM]) {
        buzzeractivate = 1;          // activate buzzer
        clearPLCD();
        switch(Menu_Pointer_Index){
        
            case 0:
                ModeDispSet = MODEL_MENU;
            break;
            
            case 1:
                ModeDispSet = TRIM_DISPLAY;
            break;
            
            case 2:
                ModeDispSet = EXPO_DISPLAY;
            break;
            
            case 3:
                ModeDispSet = TIMER_ADJUST;
                cursorSet(7+Menu_Cursor_Pos,3);
                EEPROM_Peek(active_model_num);
                active_model = peek_model;
                Serial3.write(94);
            break;
        }     
        Menu_Pointer_Index = 0;
        Menu_Display_Index = 1;
        Button_Pulse[MFD_BUTTON_ENTER_NUM] = 0;
    }
}

void Pointer_Display(){

    deletePLCD(0,0);
    deletePLCD(0,1);
    deletePLCD(0,2);
    deletePLCD(0,3);
    cursorSet(0,Menu_Pointer_Index);
    Serial3.write(126);
    
    if (Button_Pulse[HAT_SWITCH_UP_NUM]) {
        buzzeractivate = 1;          // activate buzzer
        Button_Pulse[HAT_SWITCH_UP_NUM] = false;
        Menu_Pointer_Index--;
        if (Menu_Pointer_Index > 3){
            Menu_Pointer_Index = 0;
        }
    }
    
    if (Button_Pulse[HAT_SWITCH_DOWN_NUM]) {
        buzzeractivate = 1;          // activate buzzer
        Button_Pulse[HAT_SWITCH_DOWN_NUM] = false;
        Menu_Pointer_Index++;
        if (Menu_Pointer_Index > 3 ){
            Menu_Pointer_Index = 3;
            Menu_Display_Index++;
        }
        if (Menu_Display_Index > 0){
            Menu_Display_Index = 0;
        }
    }

}

void Aircraft_Menu(){

    cursorSet(1,0);
    Serial3.print("SELECT AIRCRAFT");
    cursorSet(1,1);
    Serial3.print("EDIT AIRCRAFT NAME");
    cursorSet(1,2);
    Serial3.print("COPY AIRCRAFT");
    cursorSet(1,3);
    Serial3.print("DELETE AIRCRAFT");
    
    if (Button_Pulse[MFD_BUTTON_ENTER_NUM]) {
        buzzeractivate = 1;          // activate buzzer
        clearPLCD();
        switch(Menu_Pointer_Index){
        
            case 0:
                ModeDispSet = MODEL_SELECT_DISPLAY;
            break;
        }     
        Menu_Pointer_Index = 0;
        Button_Pulse[MFD_BUTTON_ENTER_NUM] = 0;
    }
}
    

void Aircraft_Choose(){

    static byte peek_model_num = active_model_num;
    static bool peek = true;
    cursorSet(1,0);
    Serial3.print("CURRENT MODEL:");
    cursorSet(18,0);
    Serial3.print(active_model_num);
    Model_Name_Display(1);
    
    if (Button_Pulse[HAT_SWITCH_DOWN_NUM]) {
        buzzeractivate = 2;
        peek_model_num++;
        if (peek_model_num > MODEL_MEMORY_NUM){
            peek_model_num = 1;
        }
        Button_Pulse[HAT_SWITCH_DOWN_NUM] = false;
        peek = true;
    }
    
    if (Button_Pulse[HAT_SWITCH_UP_NUM]) {
        buzzeractivate = 2;
        peek_model_num--;
        if (peek_model_num == 0){
            peek_model_num = 1;
        }
        Button_Pulse[HAT_SWITCH_UP_NUM] = false;
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
    if (active_timer2_min < 10) {
        cursorSet(10,2);
        Serial3.print("0");
        cursorSet(11,2);
        Serial3.print(active_timer2_min);
    }
    
    if (active_timer2_min >= 10) {
        cursorSet(10,2);
        Serial3.print(active_timer2_min);
    }
    
    cursorSet(12,2);
    Serial3.print(":");
    if (active_timer2_sec < 10) {
        cursorSet(13,2);
        Serial3.print("0");
        cursorSet(14,2);
        Serial3.print(active_timer2_sec);
    }
    
    if (active_timer2_sec >= 10) {
        cursorSet(13,2);
        Serial3.print(active_timer2_sec);
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
    cursorSet(3,0);
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

void Timer_Adjust(){

    cursorSet(4,0);
    Serial3.print("TIMER ADJUST");
    
    if (active_model.timer2_min < 10) {
        cursorSet(7,2);
        Serial3.print("0");
        cursorSet(8,2);
        Serial3.print(active_model.timer2_min);
    }
    
    if (active_model.timer2_min >= 10) {
        cursorSet(7,2);
        Serial3.print(active_model.timer2_min);
    }
    
    cursorSet(9,2);
    Serial3.print(":");
    
    if (active_model.timer2_sec < 10) {
        cursorSet(10,2);
        Serial3.print("0");
        cursorSet(11,2);
        Serial3.print(active_model.timer2_sec);
    }
    
    if (active_model.timer2_sec >= 10) {
        cursorSet(10,2);
        Serial3.print(active_model.timer2_sec);
    }

    if (Button_Pulse[HAT_SWITCH_RIGHT_NUM]) {
        buzzeractivate = 1;          // activate buzzer
        deletePLCD(7+Menu_Cursor_Pos,3);
        Button_Pulse[HAT_SWITCH_RIGHT_NUM] = false;
        Menu_Cursor_Pos++;
        if (Menu_Cursor_Pos > 4){
            Menu_Cursor_Pos = 4;
        }
        if (Menu_Cursor_Pos == 2){
            Menu_Cursor_Pos = 3;
        }
        cursorSet(7+Menu_Cursor_Pos,3);
        Serial3.write(94);
    }
    
    if (Button_Pulse[HAT_SWITCH_LEFT_NUM]) {
        buzzeractivate = 1;          // activate buzzer
        deletePLCD(7+Menu_Cursor_Pos,3);
        Button_Pulse[HAT_SWITCH_LEFT_NUM] = false;
        Menu_Cursor_Pos--;
        if (Menu_Cursor_Pos > 5){
            Menu_Cursor_Pos = 0;
        }
        if (Menu_Cursor_Pos == 2){
            Menu_Cursor_Pos = 1;
        }
        cursorSet(7+Menu_Cursor_Pos,3);
        Serial3.write(94);
    }
    
    if (Button_Pulse[HAT_SWITCH_UP_NUM]) {
        buzzeractivate = 1;          // activate buzzer
        Button_Pulse[HAT_SWITCH_UP_NUM] = false;
        
        if (Menu_Cursor_Pos == 0){
            if (active_model.timer2_min < 90){
                active_model.timer2_min += 10;
            }
        }
        if (Menu_Cursor_Pos == 1){
            if (active_model.timer2_min < 99){
                active_model.timer2_min ++ ;
            }
        }
        if (Menu_Cursor_Pos == 3){
            if (active_model.timer2_sec < 90){
                active_model.timer2_sec += 10;
            }
        }
        if (Menu_Cursor_Pos == 4){
            if (active_model.timer2_sec < 99){
                active_model.timer2_sec ++ ;
            }
        }
    }
    
    if (Button_Pulse[HAT_SWITCH_DOWN_NUM]) {
        buzzeractivate = 1;          // activate buzzer
        Button_Pulse[HAT_SWITCH_DOWN_NUM] = false;
        
        if (Menu_Cursor_Pos == 0){
            if (active_model.timer2_min > 10){
                active_model.timer2_min -= 10;
            }
        }
        if (Menu_Cursor_Pos == 1){
            if (active_model.timer2_min >= 1){
                active_model.timer2_min -- ;
            }
        }
        if (Menu_Cursor_Pos == 3){
            if (active_model.timer2_sec > 10){
                active_model.timer2_sec -= 10;
            }
        }
        if (Menu_Cursor_Pos == 4){
            if (active_model.timer2_sec >= 1){
                active_model.timer2_sec -- ;
            }
        }
    }    
}

// Exponential Modes
void Expo_Display() {

char* MenuExponentialMode[]={"OFF", " ON"};

	// AEL Exponential Mode setting, 1=OFF, 2=ON

    cursorSet(2,0);
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