HARDWARE
========

  Arduino Nano V3.0 (will work with other Arduino's - Atmega328)
  LRS Tx module (Thomas Scherrer's system) or any other system using compatible PPM input.
  12vdc battery (i.e. 1500mah 3S Lipo)
  Analogue Joystick (direct interface to pots & switches)
  LCD - LCD0821 Matrix Orbital serial TTL. IMPORTANT: To avoid bricking the LCD, when uploading to the Arduino then disconnect Tx to LCD.

Analogue Inputs pins:
  Pin 0 = Roll potentiometer        --> PPM Ch.1   (averaged) (Invert mode) (Exponential mode)
  Pin 1 = Pitch potentiometer       --> PPM Ch.2   (averaged) (Invert mode) (Exponential mode)
  Pin 2 = Throttle potentiometer    --> PPM Ch.3   (averaged) 
  Pin 3 = Yaw potentiometer         --> PPM Ch.4   (averaged) (Invert mode) (Exponential mode)
  Pin 4 = Aux potentiometer 1       --> PPM Ch.6
  Pin 5 = Aux potentiometer 2       --> PPM Ch.8
  Pin 6 = Battery Voltage (2.2v at input to display 12.6v)

Digital Input pins:
  Pin 2 = Function panel button
  Pin 3 = Trim adj panel button
  Pin 4 = Trim adj panel button
  Pin 5 = HI/LO rates set panel button
  Pin 6 = Thumb stick AEL up
  Pin 7 = Thumb stick AEL down
  Pin 8 = Thumb stick ELE up
  Pin 9 = Thumb stick ELE down
  Pin 13 = Aux switch 1             --> PPM Ch.5
  Pin 11 = Aux switch 2             --> PPM Ch.8
  
Digital Output pins:
  Pin 12 = Buzzer output
  Pin 10 = PPM output


  
SOURCE CODE NOTES
=================

ModeDispSet pointer:
  1  trim setting AEL
  2  trim setting ELE
  3  trim setting RUD
  4  elevon mode
  5  exponential AEL mode
  6  exponential ELE mode
  7  exponential RUD mode
  8  mode test
  9  invert AEL mode
  10 invert ELE mode
  11 invert RUD mode


PPM TIMING INFO
===============

PPM example - 8ch * (1700mS + 300mS) = 16000mS max, therefore 22500 - 16000 = 6500mS sync pulse minimum.

Standard ( =< 9 Channel) PPM Frame Spec is 22.5mS (22500uS)

Each frame consists of 4 to 9 channels (5 to 10 pulses),
700uS to 1700uS in length followed by a sync gap >250uS
in length..

The width of each channel is 1 to 2mS (1.5mS when sticks centered).
The sync gap is at least 2.5mS long,
The frame length is approximately 22.5 mS (2250 uS).

The output signal should look something like this:-

           |<---------------- 1 frame (~22.5mS) ---------------->|
           |< 1~2mS >|                                
            _         _        _        _        _                _
___________| |_______| |______| |______| |______| |______________| |____
sync gap   ch1       ch2      ch3      ch4      etc.  sync gap   ch1
     
9 Channels should take a maximum of 18mS (18000uS) leaving
4.5mS (450uS) for syncronization.

NOTES

(1)    PPM frame period duration is not critical and depends on
       RC Transmitter type & Manufacturer.

       JR/Graupner, Sanwa/Airtronics use POSITIVE shift

       Futaba, Hitec, Tower Hobbies use NEGATIVE shift

(2)    Frame separation sync gap depends on number of transmitter
       channels and will vary accordingly.

       
Debounce Code From http://blog.moamindustries.com/2012/10/09/debouncing-inputs-and-rising-edge-detection-in-arduino/
=====================================================================================================================
Micro Controlers are amazing devices however their resources must be used sparingly. Whilst it is ideal
to debounce many inputs at the hardware level with a combination of capacitors and schmitt triggers sometimes
it is not practical so debouncing is performed by the Microcontroller and it’s internal timers. To debounce
an input you need to register 3 things:

The input has changed
The input has remained changed for a set ammount of time
Update the status of the input
This is typically done with a section of code similar to that below, this is for an “Up” navigation button.

int historicUP = 0;
int stateUP = 0;
long upTime;

int debounce(){

    int up_reading = digitalRead(1);                //read the digital input

    if(historicUp != up_reading){                   //state has changed since last input scan
        upTime = millis();                          // reset time count
        historicUp = up_reading;                    // Record the current state
    }else if( millis() – upTime > 30){              // The state has not changed within the time frame defined
        stateUp = up_reading;                       //  Store the debounced state
    }
}       
       
However sometimes it can be benefitial to detect just the rising edge of a button. With this it becomes easier
to navigate menus and events which increment/decrement with each button push. This can be achieved with the addition
of a few extra lines of code and is much less resource hungry than multiple delay timers and calls to the millis()
function. So the code is similar to before but notice the few additons
 
if(historicUp != up_reading){                       //State has changed since last input scan
    upTime = millis();                              // Reset time count
    historicUp = up_reading;                        // Record the current state
} else if( millis() – upTime > debounceTime ){      // The state has not changed within the time frame defined
    if(menuUp != up_reading){                       // If the previous debounced state is not the same as the previous time it was called
        if(up_reading){                             // If the input is high, could just as easily work for falling edge detection
            upRising = 1;                           // Toggle the rising edge bit high
        }
    }else{                                          // Elsewise the bit has not changed therefore no longer a rising edge since previous function call
        upRising = 0;                               // Toggle the rising edge bit low
    }
    menuUp = up_reading;                            //Store the new debounced state ready for refernce elsewhere and for the next call of this routine.
}


 