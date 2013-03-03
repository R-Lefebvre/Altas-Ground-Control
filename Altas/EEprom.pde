/*
EEPROM Allocation Description
This program is intended to use an Arduino Mega which includes 4KB of RAM, or 4096 bytes.
The first 256 bytes will be reserved for general usage, such as active Model#.
There will be 256 bytes used for each Model Memory.  There will be 7 Model Memories.
The first Model Memory space will start at byte 256, and each subsequent model will use
next 256 bytes.  Therefore, the 7th Model space will end at byte 2047.
This leaves us with another 2048 bytes of EEPROM space on a Mega, which could be used
for more Model Memories in the future, or whatever expansion we need which is unforseen
at this time.
*/

void EEPROM_Setup(){

    EEPROM.setMemPool(0, EEPROMSizeMega);
    
    bool initialized = false;
    byte init_check;
    init_check = EEPROM.readByte(INIT_EEPROM_LOC);
    
    
    if ( init_check == INIT_CHECK_VAL ){ initialized = true; }
    
    Serial.println(init_check, DEC);
    Serial.println(initialized, true);
    
    if ( !initialized ){
        cursorSet(0,0);
        Serial3.print("Initializing EEPROM");
        cursorSet(0,1);
        Serial3.print("please wait...");
        EEPROM.setMaxAllowedWrites(10000);
        EEPROM_Clear();
        for (int i=1; i <= MODEL_MEMORY_NUM; i++){
            Serial.println(i, DEC);
            EEPROM_Delete_Model(i);
        }
        EEPROM.updateByte(INIT_EEPROM_LOC,INIT_CHECK_VAL);
    }

    active_model_num = EEPROM.readByte(ACTIVE_MODEL_LOC);
    if ((active_model_num < 1) || (active_model_num>MODEL_MEMORY_NUM)){
        active_model_num = 1;
    }
    int model_index = active_model_num * 256;
    EEPROM.readBlock(model_index, active_model); 
    active_model.timer2_sec = 0;   
}

void EEPROM_Clear(){
    for (int i = 0; i < 4096; i++){
        Serial.println(i, DEC);
        EEPROM.updateByte(i, 0);            
    }
}

void EEPROM_Update(){
    int model_index = active_model_num * 256;
    EEPROM.updateBlock(model_index, active_model);
}

void EEPROM_Peek(byte peek){
    int model_index = peek * 256;
    EEPROM.readBlock(model_index, peek_model);
}

void EEPROM_Load(byte load_num){
    int model_index = load_num * 256;
    EEPROM.readBlock(model_index, active_model);
    EEPROM.updateByte(ACTIVE_MODEL_LOC, load_num);
}

void EEPROM_Delete_Model(byte delete_num){

    model_struct temp;
    String reset_name = "Blank Model         ";
    
    reset_name.getBytes(temp.model_name, 21);
    for (int i=0; i<8; i++){
        temp.channel_reverse[i] = false;
        temp.EP_high[i] = PWM_MAX;
        temp.EP_low[i] = PWM_MIN;
    }
    for (int i=0; i<4; i++){
        temp.trim[i] = 0;
        temp.expo_high[i] = 0;
        temp.expo_low[i] = 0;
        temp.dual_rate[i] = 100;
    }
    temp.timer2_min = DEFAULT_TIMER_VAL;
    temp.timer2_sec = 0;
    
    int index = delete_num * 256;
    EEPROM.updateBlock(index, temp);
    
}
    
    
  
    
    

