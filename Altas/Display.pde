/*
Display
*/


void Display(){

    switch (ModeDispSet){
        ////////////////////////////////////////////////////////////////////
        case MAIN_CONTROL_DISPLAY:

            Model_Name_Display(0);
            Timer_Display();
            Battery_Display(); 
            if (Button_Pulse[MFD_BUTTON_ENTER_NUM]) {
                buzzeractivate = 1;                                             // activate buzzer
                clearPLCD();
                ModeDispSet = MENU_1_DISPLAY;
                Button_Pulse[MFD_BUTTON_ENTER_NUM] = 0;
            }
        break;
        ////////////////////////////////////////////////////////////////////
        case MENU_1_DISPLAY:
        
            Pointer_Display();
            Menu_Display();
            if (Button_Pulse[MFD_BUTTON_BACK_NUM]) {
                buzzeractivate = 1;                                             // activate buzzer
                clearPLCD();
                ModeDispSet = MAIN_CONTROL_DISPLAY;
                Button_Pulse[MFD_BUTTON_BACK_NUM] = 0;
                Menu_Pointer_Index = 0;
                Menu_Display_Index = 1;
            }
        break;
        ////////////////////////////////////////////////////////////////////
        case MODEL_MENU:
        
            Pointer_Display();
            Aircraft_Menu();
            if (Button_Pulse[MFD_BUTTON_BACK_NUM]) {
                buzzeractivate = 1;                                             // activate buzzer
                clearPLCD();
                ModeDispSet = MENU_1_DISPLAY;
                Button_Pulse[MFD_BUTTON_BACK_NUM] = 0;
                Menu_Pointer_Index = 0;
                Menu_Display_Index = 1;
            }
        break;
        ////////////////////////////////////////////////////////////////////
        case MODEL_SELECT_DISPLAY:
        
            Aircraft_Choose();
            if (Button_Pulse[MFD_BUTTON_BACK_NUM]) {
                buzzeractivate = 1;                                             // activate buzzer
                clearPLCD();
                ModeDispSet = MODEL_MENU;
                EEPROM_Update();
                active_timer2_min = active_model.timer2_min;
                active_timer2_sec = active_model.timer2_sec; 
                Button_Pulse[MFD_BUTTON_BACK_NUM] = 0;
            }
        break;
        ////////////////////////////////////////////////////////////////////
        case MODEL_NAME_CHANGE_DISPLAY:
        
            Aircraft_Rename();
            if (Button_Pulse[MFD_BUTTON_BACK_NUM]) {
                buzzeractivate = 1;                                             // activate buzzer
                clearPLCD();
                Menu_Cursor_Pos = 0;
                ModeDispSet = MODEL_MENU;
                EEPROM_Update();
                Button_Pulse[MFD_BUTTON_BACK_NUM] = 0;
            }
        break;
        ////////////////////////////////////////////////////////////////////
        case MODEL_COPY_DISPLAY:
        
            Aircraft_Copy();
            if (Button_Pulse[MFD_BUTTON_BACK_NUM]) {
                buzzeractivate = 1;                                             // activate buzzer
                clearPLCD();
                ModeDispSet = MODEL_MENU;
                Button_Pulse[MFD_BUTTON_BACK_NUM] = 0;
            }
        break;
        ////////////////////////////////////////////////////////////////////
        case MODEL_DELETE_DISPLAY:
        
            Aircraft_Delete();
            if (Button_Pulse[MFD_BUTTON_BACK_NUM]) {
                buzzeractivate = 1;                                             // activate buzzer
                clearPLCD();
                Menu_Cursor_Pos = 0;
                ModeDispSet = MODEL_MENU;
                Button_Pulse[MFD_BUTTON_BACK_NUM] = 0;
            }
        break;
        ////////////////////////////////////////////////////////////////////
        case TRIM_DISPLAY:
        
            Trim_Adjust();
            Trim_Display();
            if (Button_Pulse[MFD_BUTTON_BACK_NUM]) {
                buzzeractivate = 1;                                             // activate buzzer
                clearPLCD();
                ModeDispSet = MENU_1_DISPLAY;
                EEPROM_Update();
                Button_Pulse[MFD_BUTTON_BACK_NUM] = 0;
            }
        break;
        ////////////////////////////////////////////////////////////////////
        case EXPO_DISPLAY:
        
            Expo_Display();   
            if (Button_Pulse[MFD_BUTTON_BACK_NUM]) {
                buzzeractivate = 1;                                             // activate buzzer
                clearPLCD();
                ModeDispSet = MENU_1_DISPLAY;
                EEPROM_Update();
                Button_Pulse[MFD_BUTTON_BACK_NUM] = 0;
            }
        break;
        ////////////////////////////////////////////////////////////////////
        case TIMER_ADJUST:
        
            Timer_Adjust();
            if (Button_Pulse[MFD_BUTTON_BACK_NUM]) {
                buzzeractivate = 1;                                             // activate buzzer
                clearPLCD();
                Menu_Cursor_Pos = 0;
                ModeDispSet = MENU_1_DISPLAY;
                EEPROM_Update();
                active_timer2_min = active_model.timer2_min;
                active_timer2_sec = active_model.timer2_sec; 
                Button_Pulse[MFD_BUTTON_BACK_NUM] = 0;
            }
        break;
        ////////////////////////////////////////////////////////////////////
        case ENDPOINT_DISPLAY:
        
            if (Button_Pulse[MFD_BUTTON_BACK_NUM]) {
                buzzeractivate = 1;                                             // activate buzzer
                clearPLCD();
                ModeDispSet = MENU_1_DISPLAY;
                EEPROM_Update();
                Button_Pulse[MFD_BUTTON_BACK_NUM] = 0;
            }
        break;
        ////////////////////////////////////////////////////////////////////
        case DUAL_RATES_DISPLAY:
        
            if (Button_Pulse[MFD_BUTTON_BACK_NUM]) {
                buzzeractivate = 1;                                             // activate buzzer
                clearPLCD();
                ModeDispSet = MENU_1_DISPLAY;
                EEPROM_Update();
                Button_Pulse[MFD_BUTTON_BACK_NUM] = 0;
            }
        break;
        ////////////////////////////////////////////////////////////////////
        case THROTTLE_SWITCH_DISPLAY:
        
            Throttle_Switch_Display();
            if (Button_Pulse[MFD_BUTTON_BACK_NUM]) {
                buzzeractivate = 1;                                             // activate buzzer
                clearPLCD();
                ModeDispSet = MENU_1_DISPLAY;
                EEPROM_Update();
                Button_Pulse[MFD_BUTTON_BACK_NUM] = 0;
            }
        break;
        ////////////////////////////////////////////////////////////////////
        
    }   // Switch
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
        
        case MENU_2_DISPLAY:

            cursorSet(1,0);
            Serial3.print("ENDPOINT ADJUST");
            cursorSet(1,1);
            Serial3.print("DUAL RATES ADJUST");
            cursorSet(1,2);
            Serial3.print("THROTTLE SWITCH");
            
        break;
        
    }
    
    if (Button_Pulse[HAT_SWITCH_UP_NUM]) {
        buzzeractivate = 1;                                     // activate buzzer
        Button_Pulse[HAT_SWITCH_UP_NUM] = false;
        Menu_Pointer_Index--;
        if (Menu_Pointer_Index > 3){                            // If the pointer index has wrapped to 255, and...
            if (Menu_Display_Index == MENU_1_DISPLAY){          // If we're on the top level already, 
                Menu_Pointer_Index = 0;                         // hold the pointer at zero.
            } else if (Menu_Display_Index > MENU_1_DISPLAY){    // Otherwise
                clearPLCD();
                Menu_Display_Index--;                           // Move up one menu level and set the pointer at the bottom row.
                Menu_Pointer_Index = 3;
            }
        }
    }
    
    if (Button_Pulse[HAT_SWITCH_DOWN_NUM]) {
        buzzeractivate = 1;                                     // activate buzzer
        Button_Pulse[HAT_SWITCH_DOWN_NUM] = false;
        Menu_Pointer_Index++;
        if (Menu_Pointer_Index > 3 ){                           // If the pointer has gone down to line 4...
            if (Menu_Display_Index < MENU_2_DISPLAY){           // And if we are not already on the bottom level...
                clearPLCD();
                Menu_Display_Index++;                           // Move down one menu level.
                Menu_Pointer_Index = 0;                         // And set the pointer on the top row.
            } else if (Menu_Display_Index == MENU_2_DISPLAY){   // Otherwise we have reached the end of the menus
                Menu_Pointer_Index = 3;                         // Hold the pointer at the bottom row.
            }
        }    
    }
    
    if (Button_Pulse[MFD_BUTTON_ENTER_NUM]) {
        buzzeractivate = 1;                                 // activate buzzer
        clearPLCD();
        switch(Menu_Display_Index){
            case MENU_1_DISPLAY:
                switch(Menu_Pointer_Index){
                    //////////////////////////////////
                    case 0:
                        ModeDispSet = MODEL_MENU;
                    break;
                    //////////////////////////////////
                    case 1:
                        ModeDispSet = TRIM_DISPLAY;
                    break;
                    //////////////////////////////////
                    case 2:
                        ModeDispSet = EXPO_DISPLAY;
                    break;
                    //////////////////////////////////
                    case 3:
                        ModeDispSet = TIMER_ADJUST;
                        EEPROM_Peek(active_model_num);
                        active_model = peek_model;
                        cursorSet(7+Menu_Cursor_Pos,3);
                        Serial3.write(94);
                    break;
                    //////////////////////////////////
                } 
            break;
            
            case MENU_2_DISPLAY:
                switch(Menu_Pointer_Index){
                    //////////////////////////////////
                    case 0:
                        ModeDispSet = MODEL_MENU;
                    break;
                    //////////////////////////////////
                    case 1:
                        ModeDispSet = TRIM_DISPLAY;
                    break;
                    //////////////////////////////////
                    case 2:
                        ModeDispSet = THROTTLE_SWITCH_DISPLAY;
                    break;
                    //////////////////////////////////
                }
            break;
        }
        Menu_Pointer_Index = 0;
        // Menu_Display_Index = 1;                          // Let's try not doing this...
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
    
    if (Button_Pulse[HAT_SWITCH_UP_NUM]) {
        buzzeractivate = 1;                                 // activate buzzer
        Button_Pulse[HAT_SWITCH_UP_NUM] = false;
        Menu_Pointer_Index--;
        if (Menu_Pointer_Index > 3){                        // If the pointer index has wrapped to 255, and...
            Menu_Pointer_Index = 0;                         // hold the pointer at zero.
        }
    }
    
    if (Button_Pulse[HAT_SWITCH_DOWN_NUM]) {
        buzzeractivate = 1;                                 // activate buzzer
        Button_Pulse[HAT_SWITCH_DOWN_NUM] = false;
        Menu_Pointer_Index++;
        if (Menu_Pointer_Index > 3 ){                       // If the pointer has gone down to line 4...
            Menu_Pointer_Index = 3;                         // Hold the pointer at the bottom row.
        }    
    }
    
    if (Button_Pulse[MFD_BUTTON_ENTER_NUM]) {
        buzzeractivate = 1;          // activate buzzer
        clearPLCD();
        switch(Menu_Pointer_Index){
        
            case 0:
                ModeDispSet = MODEL_SELECT_DISPLAY;
            break;
            
            case 1:
                ModeDispSet = MODEL_NAME_CHANGE_DISPLAY;
                cursorSet(0,3);
                Serial3.write(94);
            break;
            
            case 2:
                ModeDispSet = MODEL_COPY_DISPLAY;
            break;
            
            case 3:
                ModeDispSet = MODEL_DELETE_DISPLAY;
                cursorSet(7+Menu_Cursor_Pos,3);
                Serial3.write(94);
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
        peek = false;
    }
    cursorSet(1,2);
    Serial3.print("CHANGE TO MODEL:");
    cursorSet(18,2);
    Serial3.print(peek_model_num);
    cursorSet(0,3);
    for (int i = 0; i < 20; i++){
        Serial3.write(peek_model.model_name[i]);
    }
    
    if (Button_Pulse[MFD_BUTTON_ENTER_NUM] && peek_model_num != active_model_num) {
        buzzeractivate = 2;
        Button_Pulse[MFD_BUTTON_ENTER_NUM] = 0;
        active_model_num = peek_model_num;
        EEPROM_Load(active_model_num);
    }    
}

void Aircraft_Rename(){

    cursorSet(1,0);
    Serial3.print("EDIT AIRCRAFT NAME");
    
    Model_Name_Display(2);
  
    if (Button_Pulse[HAT_SWITCH_RIGHT_NUM]) {
        buzzeractivate = 1;          // activate buzzer
        deletePLCD(Menu_Cursor_Pos,3);
        Button_Pulse[HAT_SWITCH_RIGHT_NUM] = false;
        Menu_Cursor_Pos++;
        if (Menu_Cursor_Pos > 19){
            Menu_Cursor_Pos = 19;
        }
        cursorSet(Menu_Cursor_Pos,3);
        Serial3.write(94);
    }
    
    if (Button_Pulse[HAT_SWITCH_LEFT_NUM]) {
        buzzeractivate = 1;          // activate buzzer
        deletePLCD(Menu_Cursor_Pos,3);
        Button_Pulse[HAT_SWITCH_LEFT_NUM] = false;
        Menu_Cursor_Pos--;
        if (Menu_Cursor_Pos > 19){
            Menu_Cursor_Pos = 0;
        }
        cursorSet(Menu_Cursor_Pos,3);
        Serial3.write(94);
    }
    
    if (Button_State[HAT_SWITCH_UP_NUM] == 0) {
        buzzeractivate = 1;          // activate buzzer
        Button_Pulse[HAT_SWITCH_UP_NUM] = false;
        active_model.model_name[Menu_Cursor_Pos]++;
        if (active_model.model_name[Menu_Cursor_Pos] == 33){active_model.model_name[Menu_Cursor_Pos] = 48;}
        if (active_model.model_name[Menu_Cursor_Pos] == 58){active_model.model_name[Menu_Cursor_Pos] = 65;}
        if (active_model.model_name[Menu_Cursor_Pos] == 91){active_model.model_name[Menu_Cursor_Pos] = 97;}
        if (active_model.model_name[Menu_Cursor_Pos] == 123){active_model.model_name[Menu_Cursor_Pos] = 32;}
    }
    
    if (Button_State[HAT_SWITCH_DOWN_NUM] == 0) {
        buzzeractivate = 1;          // activate buzzer
        Button_Pulse[HAT_SWITCH_DOWN_NUM] = false;
        active_model.model_name[Menu_Cursor_Pos]--;
        if (active_model.model_name[Menu_Cursor_Pos] == 31){active_model.model_name[Menu_Cursor_Pos] = 122;}
        if (active_model.model_name[Menu_Cursor_Pos] == 47){active_model.model_name[Menu_Cursor_Pos] = 32;}
        if (active_model.model_name[Menu_Cursor_Pos] == 64){active_model.model_name[Menu_Cursor_Pos] = 57;}
        if (active_model.model_name[Menu_Cursor_Pos] == 96){active_model.model_name[Menu_Cursor_Pos] = 90;}
    }    
}

void Aircraft_Copy(){

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
        peek = false;
    }
    cursorSet(1,2);
    Serial3.print("COPY TO MODEL:");
    cursorSet(18,2);
    Serial3.print(peek_model_num);
    cursorSet(0,3);
    for (int i = 0; i < 20; i++){
        Serial3.write(peek_model.model_name[i]);
    }
    
    if (Button_Pulse[MFD_BUTTON_ENTER_NUM] && peek_model_num != active_model_num) {
        buzzeractivate = 2;
        Button_Pulse[MFD_BUTTON_ENTER_NUM] = 0;
        EEPROM_Copy(peek_model_num);
        peek = true;
    }    
}

void Aircraft_Delete(){

    static byte pointer_level = 0;
    static byte peek_model_num = active_model_num;
    static bool peek = true;
    cursorSet(1,0);
    Serial3.print("DELETE AIRCRAFT:");
    cursorSet(18,0);
    Serial3.print(peek_model_num, DEC);
   
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
        peek = false;
    }
    cursorSet(0,1);
    for (int i = 0; i < 20; i++){
        Serial3.write(peek_model.model_name[i]);
    }
    cursorSet(6,2);
    Serial3.write("NO...YES");
    cursorSet(6,3);
    Serial3.write(124);
    cursorSet(12,3);
    Serial3.write(124);
    
    if (Button_Pulse[HAT_SWITCH_RIGHT_NUM]) {
        buzzeractivate = 1;          // activate buzzer
        deletePLCD(7+Menu_Cursor_Pos,3);
        Button_Pulse[HAT_SWITCH_RIGHT_NUM] = false;
        Menu_Cursor_Pos++;
        if (Menu_Cursor_Pos > 4){
            Menu_Cursor_Pos = 4;
        }
        cursorSet(7+Menu_Cursor_Pos,3);
        Serial3.write(94);
    }
    
    if (Button_Pulse[HAT_SWITCH_LEFT_NUM]) {
        buzzeractivate = 1;          // activate buzzer
        deletePLCD(7+Menu_Cursor_Pos,3);
        Button_Pulse[HAT_SWITCH_LEFT_NUM] = false;
        Menu_Cursor_Pos--;
        if (Menu_Cursor_Pos > 4){
            Menu_Cursor_Pos = 0;
        }
        cursorSet(7+Menu_Cursor_Pos,3);
        Serial3.write(94);
    }
    
    if (Button_Pulse[MFD_BUTTON_ENTER_NUM] && Menu_Cursor_Pos == 4) {
        buzzeractivate = 2;
        Button_Pulse[MFD_BUTTON_ENTER_NUM] = 0;
        EEPROM_Delete_Model(peek_model_num);
        if (peek_model_num == active_model_num){
            EEPROM_Load(active_model_num);
        }
        peek = true;
        
    } else if (Button_Pulse[MFD_BUTTON_ENTER_NUM]){
        buzzeractivate = 2;
        Button_Pulse[MFD_BUTTON_ENTER_NUM] = 0;
        deletePLCD(7+Menu_Cursor_Pos,3);
        Menu_Cursor_Pos = 0;
        cursorSet(7+Menu_Cursor_Pos,3);
        Serial3.write(94);
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

void Throttle_Switch_Display(){

    char* ThrottleSwitchMode[]={"No Function", "Throttle   ", "Ch8 Knob   "};

    cursorSet(2,0);
    Serial3.print("Throttle Switch");
    cursorSet(0,1);
    Serial3.print("Setting:");          // 8 chars
    cursorSet(9,1);
    Serial3.print(ThrottleSwitchMode[active_model.thr_switch_mode]);
    if (Button_Pulse[HAT_SWITCH_UP_NUM]) {
        buzzeractivate = 1;                         // activate buzzer
        Button_Pulse[HAT_SWITCH_UP_NUM] = false;
        active_model.thr_switch_mode--;
        if (active_model.thr_switch_mode > 2){      // If the byte has wrapped to 255
            active_model.thr_switch_mode = 0;       // Hold it at 0
        }
    }
    
    if (Button_Pulse[HAT_SWITCH_DOWN_NUM]) {
        buzzeractivate = 1;                         // activate buzzer
        Button_Pulse[HAT_SWITCH_DOWN_NUM] = false;
        active_model.thr_switch_mode--;
        if (active_model.thr_switch_mode > 2 ){     // If the pointer has gone further than 2
            active_model.thr_switch_mode = 2;       // Hold it at 2
        }    
    }
}
    