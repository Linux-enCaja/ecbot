#include <iostream>
#include <ostream>
#include <fstream>
#include <math.h>
#include <string>

using namespace std;
#include <time.h>
#include <stdlib.h>

#include "rcservo.h"

int
main(int argc, char* argv[]){

CRCServo servo(QES_DEFAULT_SERVOS);
unsigned char i;
unsigned long d;

for (int i=0; i<16; i++)
    servo.SetBounds(i, 32, 228);

  while(1)

    {
      atoi(argv[0]),atoi(argv[1]),atoi(argv[2]);
      for (i=0; i<16; i++)
	servo.SetPosition(i, atoi(argv[1]));
      printf("Pos: 0x%x\n", servo.GetPosition(0));
    }
}
