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

    EEPROM.setMemPool(0, 4096);

    //active_model_num = EEPROM.readByte(ACTIVE_MODEL_LOC);
    unsigned int model_index = active_model_num * 256;
    EEPROM.readBlock(model_index, active_model);
    
}

void EEPROM_Clear(){
    for (int i = 0; i < 4096; i++){
            EEPROM.write(i, 0);            
    }
}

