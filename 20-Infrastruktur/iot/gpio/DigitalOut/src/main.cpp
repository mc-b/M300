/** Mittels DigitalOut kann eine Positive Spannung an einem Pin erzeugt werden.
*/
#include "mbed.h"

DigitalOut led( D10 );

int main()
{
    while(1) 
    {
        led.write( 0 );
        wait(0.8);
        
        led.write( 1 );
        wait(1.0);
    }
}  