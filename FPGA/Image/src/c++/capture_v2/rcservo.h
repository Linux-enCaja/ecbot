//  BEGIN LICENSE BLOCK
// 
//  Version: MPL 1.1
// 
//  The contents of this file are subject to the Mozilla Public License Version
//  1.1 (the "License"); you may not use this file except in compliance with
//  the License. You may obtain a copy of the License at
//  http://www.mozilla.org/MPL/
// 
//  Software distributed under the License is distributed on an "AS IS" basis,
//  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
//  for the specific language governing rights and limitations under the
//  License.
// 
//  The Original Code is The Xport Software Distribution.
// 
//  The Initial Developer of the Original Code is Charmed Labs LLC.
//  Portions created by the Initial Developer are Copyright (C) 2003
//  the Initial Developer. All Rights Reserved.
// 
//  Contributor(s): Rich LeGrand (rich@charmedlabs.com)
// 
//  END LICENSE BLOCK 

#ifndef _RCSERVO_H
#define _RCSERVO_H

#include "memmap.h"

#define MAP_SIZE 0x2000000l    // ECBOT USE A11 to A25 
#define MAP_MASK (MAP_SIZE - 1)

//A22 ... A19 
// CSP0   From 0000 to 0011
// CSP1   From 0100 to 0111: 200000 - 2C0000
// CSP2   From 1000 to 1011:
// CSP3   From 1100 to 1101:
// CSPIC  From 1110 to 1111:
#define SERVO_BASE               0x40200000l
#define QES_DEFAULT_SERVOS       16
#define QES_DEFAULT_ADDR         0x400

class CRCServo
{
public:
  CRCServo(unsigned char num=QES_DEFAULT_SERVOS, unsigned long addr=QES_DEFAULT_ADDR, bool enable=true);
  ~CRCServo();

  void Disable();	// turn off all servos
  void Enable();  // turn on all servos
  unsigned char GetPosition(unsigned char index);
  void SetPosition(unsigned char index, unsigned char pos);
  void SetBounds(unsigned char index, unsigned char lower, unsigned char upper);
	
private:
  unsigned char *m_boundUpper;
  unsigned char *m_boundLower;
  unsigned char *m_shadowPos;  // use shadow registers to save read-back logic
  unsigned char m_num;

  MemMap m_addr;
};

#endif
