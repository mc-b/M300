/** DigitalIn liest den Status eines Pins aus.
*/
#include "mbed.h"

DigitalIn button1( A1, PullUp );
DigitalOut led1( D10 );

int main()
{
    while   ( 1 ) 
    {
        led1 = 0;
        if  ( button1 == 0 ) 
        {
            led1 = 1;
            wait( 1.0 );
        }

    }
}