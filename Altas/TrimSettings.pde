/*

AEL/ELE Trim

*/


// Trim Settings
void Trim_Adjust() {
    
    // Thumb stick trim
        
    if (Button_State[HAT_SWITCH_RIGHT_NUM] == 0 && active_model.trim[0] < MAX_TRIM) {     // Ael trim up via thumb stick
            buzzeractivate = 2;         // activate buzzer
            active_model.trim[0]++;
            if (active_model.trim[0] > MAX_TRIM) { active_model.trim[0] = MAX_TRIM; }
    }
    if (Button_State[HAT_SWITCH_LEFT_NUM] == 0 && active_model.trim[0] > MIN_TRIM) {     // Ael trim down via thumb stick
            buzzeractivate = 2;         // activate buzzer
            active_model.trim[0]--;
            if (active_model.trim[0] < MIN_TRIM) { active_model.trim[0] = MIN_TRIM; }
    }	
    if (Button_State[HAT_SWITCH_DOWN_NUM] == 0 && active_model.trim[1] < MAX_TRIM) {     // Ele trim up via thumb stick
            buzzeractivate = 2;         // activate buzzer
            active_model.trim[1]++;
            if (active_model.trim[1] > MAX_TRIM) { active_model.trim[1] = MAX_TRIM; }
    }
    if (Button_State[HAT_SWITCH_UP_NUM] == 0 && active_model.trim[1] > MIN_TRIM) {     // Ele trim down via thumb stick
            buzzeractivate = 2;         // activate buzzer
            active_model.trim[1]--;
            if (active_model.trim[1] < MIN_TRIM) { active_model.trim[1] = MIN_TRIM; }
    }			
}


