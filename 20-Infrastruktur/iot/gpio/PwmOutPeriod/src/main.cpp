/** Pulsweitenmodulation - Generieren eines x Hz Tones mittels PWM
*/
#include "mbed.h"

PwmOut speaker( D7 );

int main()
{
    while   ( 1 ) 
    {
        // Polizei Sirene
        speaker.period( 1.0 / 3969.0 );      // 3969 = Tonfrequenz in Hz
        speaker = 0.5f;
        wait( 0.5f );
        speaker.period( 1.0 / 2800.0 );
        wait( 0.5f );
    }
}