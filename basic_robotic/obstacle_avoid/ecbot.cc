/*
 *  Player - One Hell of a Robot Server
 *  Copyright (C) 2000  
 *     Brian Gerkey, Kasper Stoy, Richard Vaughan, & Andrew Howard
 *
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */

/* Copyright (C) 2004
 *   Toby Collett, University of Auckland Robotics Group
 */


/** @ingroup drivers */
/** @{ */
/** @defgroup driver_ECBot ECBot
 * @brief EMQBIT ECBOT mobile robot

The ECBot driver is used to interface to the EMQBIT ECBOT robot. 

This driver is experimental and should be treated with caution. At
this point it supports the @ref interface_position2d and 
@ref interface_ir interfaces.

TODO: 
 - Add support for position control (currently only velocity control)
 - Add proper calibration for IR sensors
 - Add LED driver
 - Add Camera driver

@par Compile-time dependencies

- none

@par Provides

- @ref interface_position2d
- @ref interface_ir

@par Requires

- none

@par Supported configuration requests

- The @ref interface_position2d interface supports:
  - PLAYER_POSITION_GET_GEOM_REQ
  - PLAYER_POSITION_SET_ODOM_REQ :
  - PLAYER_POSITION_RESET_ODOM_REQ :
  - PLAYER_POSITION_POWER_REQ :
  - PLAYER_POSITION_SPEED_PID_REQ :
  - PLAYER_POSITION_POSITION_PID_REQ :
  - PLAYER_POSITION_SPEED_PROF_REQ :
  - PLAYER_IR_GET_GEOM_REQ :

- The @ref interface_ir interface supports:
  - PLAYER_IR_POSE_REQ

@par Configuration file options

- port (string)
  - Default: "/dev/i2c-0"
  - I2C port used to communicate with the robot.
- scale_factor (float)
  - Default: 10
  - As the ECBOT is so small the actual geometry doesnt make much sense
    with many of the existing defaults so the geometries can all be scaled
    by this factor.
- position_pose (float tuple)
  - Default: [0 0 0]
  - The pose of the robot in player coordinates (mm, mm, deg).
- position_size (float tuple)
  - Default: [120, 120]
  - The size of the robot approximated to a rectangle (mm, mm).
- ir_pose_count (integer)
  - Default: 8
  - The number of ir poses.
- ir_poses (float tuple)
  - Default: [-42 36 XX -53 15 XX -5 56 XX 51 28 XX -53 -15 XX -42 -36 XX 5 -56 XX 51 -28 XX]
  - Poses of the IRs (mm mm deg for each one)

@par Example 

@verbatim
driver
(
  name "ecbot"
  provides ["position2d:0" "ir:0"]
)
@endverbatim

@author Carlos Camargo
*/
/** @} */

#include <fcntl.h>
#include <signal.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <stdio.h>
#include <string.h>
#include <termios.h>
#include <unistd.h>
#include <math.h>
#include <stdlib.h>  /* for abs() */
#include <netinet/in.h>
#include <ctype.h>

#include <assert.h>

#include "ecbot.h"
#include "i2c-io-api.h"

#include <error.h>
#include <playertime.h>

#include <devicetable.h>

// useful macros
#define DEG2RAD(x) (((double)(x))*0.01745329251994)
#define RAD2DEG(x) (((double)(x))*57.29577951308232)


#define DEG2RAD_FIX(x) ((x) * 174)
#define RAD2DEG_FIX(x) ((x) * 572958)

//#define DEBUG

// Initialize the driver.
Driver*
ECBot_Init(ConfigFile *cf, int section)
{
  #ifdef DEBUG
    printf("Initialize ECBOT's Driver..\n");
  #endif
  return (Driver *) new ECBot( cf, section);
}

// Register the ECBOT IR driver in the drivertable
void
ECBot_Register(DriverTable *table) 
{
  table->AddDriver("ecbot", ECBot_Init);
}

////////////////////////////////////////////////////////////////////////////////
// Constructor.  Retrieve options from the configuration file and do any
// pre-Setup() setup.
ECBot::ECBot(ConfigFile *cf, int section) : Driver(cf, section)
{
  // zero ids, so that we'll know later which interfaces were requested
  memset(&position_addr, 0, sizeof(this->position_addr));
  memset(&ir_addr, 0, sizeof(ir_addr));
  memset(&blinkenlight_addr, 0, sizeof(blinkenlight_addr));
  this->position_subscriptions = this->ir_subscriptions = this->blinkenlight_subscriptions = 0;

  // Create position2d interface
  if(cf->ReadDeviceAddr(&(this->position_addr), section, "provides", 
                      PLAYER_POSITION2D_CODE, -1, NULL) == 0)
  {
    #ifdef DEBUG
      printf("Add Position2D Interface..\n");
    #endif
    if(this->AddInterface(this->position_addr) != 0)
    {
      this->SetError(-1);    
      return;
    }
  }

  // Create IR interface
  if(cf->ReadDeviceAddr(&(this->ir_addr), section, "provides", 
                      PLAYER_IR_CODE, -1, NULL) == 0)
  {
    #ifdef DEBUG
      printf("Add IR Interface..\n");
    #endif
    if(this->AddInterface(this->ir_addr) != 0)
    {
      this->SetError(-1);    
      return;
    }
  }

  // Create LED interface
  if(cf->ReadDeviceAddr(&(this->blinkenlight_addr), section, "provides", 
                      PLAYER_BLINKENLIGHT_CODE, -1, NULL) == 0)
  {
    #ifdef DEBUG
      printf("Add LED Interface..\n");
    #endif
    if(this->AddInterface(this->blinkenlight_addr) != 0)
    {
      this->SetError(-1);    
      return;
    }
  }

  // Read options from the configuration file
  geometry = new player_ECBot_geom_t;
  geometry->PortName= NULL;
  geometry->scale = 0;

  // now we have to look up our parameters.  this should be given as an argument
  if (geometry->PortName == NULL)
    geometry->PortName = strdup(cf->ReadString(section, "port", ECBOT_DEFAULT_I2C_PORT));
  if (geometry->scale == 0)
    geometry->scale = cf->ReadFloat(section, "scale_factor", ECBOT_DEFAULT_SCALE);


  geometry->encoder_res = cf->ReadFloat(section,"encoder_res", ECBOT_DEFAULT_ENCODER_RES);

  // Load position config
  geometry->position.pose.px = cf->ReadTupleFloat(section,"position_pose",0,0) * geometry->scale;
  geometry->position.pose.py = cf->ReadTupleFloat(section,"position_pose",1,0) * geometry->scale;
  geometry->position.pose.pa = cf->ReadTupleFloat(section,"position_pose",2,0) * geometry->scale;

  // load dimension of the base
  geometry->position.size.sw = cf->ReadTupleFloat(section,"position_size",0,57) * geometry->scale;
  geometry->position.size.sl = cf->ReadTupleFloat(section,"position_size",1,57) * geometry->scale;

  // load ir geometry config
//  geometry->ir.poses_count = (cf->ReadInt(section,"ir_pose_count", 8));
    geometry->ir.poses_count = 8;
  if (geometry->ir.poses_count == 8 && cf->ReadTupleFloat(section,"ir_poses",0,-1) == -1)
  {
    // load the default ir geometry 
    // [-42 36 XX -53 15 XX -5 56 XX 51 28 XX -53 -15 XX -42 -36 XX 5 -56 XX 51 -28 XX]
    geometry->ir.poses[0].px =  42/1000*geometry->scale;
    geometry->ir.poses[0].py = -36/1000*geometry->scale;
    geometry->ir.poses[0].pa =  DTOR(-41);

    geometry->ir.poses[1].px =  53/1000*geometry->scale;
    geometry->ir.poses[1].py = -15/1000*geometry->scale;
    geometry->ir.poses[1].pa =  DTOR(-16);

    geometry->ir.poses[2].px =   5/1000*geometry->scale;
    geometry->ir.poses[2].py = -56/1000*geometry->scale;
    geometry->ir.poses[2].pa =  DTOR(-85);

    geometry->ir.poses[3].px = -51/1000*geometry->scale;
    geometry->ir.poses[3].py = -28/1000*geometry->scale;
    geometry->ir.poses[3].pa =  DTOR(-151);

    geometry->ir.poses[4].px =  53/1000*geometry->scale;
    geometry->ir.poses[4].py =  15/1000*geometry->scale;
    geometry->ir.poses[4].pa =  DTOR(16);

    geometry->ir.poses[5].px =  42/1000*geometry->scale;
    geometry->ir.poses[5].py =  36/1000*geometry->scale;
    geometry->ir.poses[5].pa =  DTOR(41);

    geometry->ir.poses[6].px =  -5/1000*geometry->scale;
    geometry->ir.poses[6].py =  56/1000*geometry->scale;
    geometry->ir.poses[6].pa =  DTOR(95);

    geometry->ir.poses[7].px = -51/1000*geometry->scale;
    geometry->ir.poses[7].py =  28/1000*geometry->scale;
    geometry->ir.poses[7].pa =  DTOR(151);
  }
  else
  {
    // laod geom from config file
    for (unsigned int i = 0; i < geometry->ir.poses_count; ++i)
    {
      geometry->ir.poses[i].px = cf->ReadTupleFloat(section,"ir_poses",3*i,0)*geometry->scale;
      geometry->ir.poses[i].py = cf->ReadTupleFloat(section,"ir_poses",3*i+1,0)*geometry->scale;
      geometry->ir.poses[i].pa = cf->ReadTupleFloat(section,"ir_poses",3*i+2,0);
    }				
  }
  // laod ir calibration from config file
  geometry->ir_calib_a = new double[geometry->ir.poses_count];
  geometry->ir_calib_b = new double[geometry->ir.poses_count];
  for (unsigned int i = 0; i < geometry->ir.poses_count; ++i)
  {
    geometry->ir_calib_a[i] = cf->ReadTupleFloat(section,"ir_calib_a", i, ECBOT_DEFAULT_IR_CALIB_A);
    geometry->ir_calib_b[i] = cf->ReadTupleFloat(section,"ir_calib_b", i, ECBOT_DEFAULT_IR_CALIB_B);
  }
  geometry->ir.poses_count = geometry->ir.poses_count;

  // zero position counters
  last_lpos = 0;
  last_rpos = 0;
  last_x_f=0;
  last_y_f=0;
  last_theta = 0.0;
  
  
}

// Process an incoming message
int ECBot::ProcessMessage(MessageQueue * resp_queue, player_msghdr * hdr, void * data)
{
  assert(hdr);
  assert(data);

  // ##############################################    POSITION2D COMMANDS
  if(Message::MatchMessage(hdr, PLAYER_MSGTYPE_CMD, PLAYER_POSITION2D_CMD_VEL, position_addr))
  {
    #ifdef DEBUG
      printf("Processing PLAYER_POSITION2D_CMD_VEL ..\n");
    #endif
    assert(hdr->size == sizeof(player_position2d_cmd_vel_t));
    ProcessPos2dVelCmd(hdr, *reinterpret_cast<player_position2d_cmd_vel_t *>(data));
    return(0);
  }

  if(Message::MatchMessage(hdr, PLAYER_MSGTYPE_REQ, PLAYER_POSITION2D_REQ_MOTOR_POWER, position_addr))
  {
    #ifdef DEBUG
      printf("Processing PLAYER_POSITION2D_REQ_MOTOR_POWER ..\n");
    #endif
    this->motors_enabled = ((player_position2d_power_config_t *)data)->state;
    Publish(position_addr, resp_queue, PLAYER_MSGTYPE_RESP_ACK,hdr->subtype);
    return 0;
  }

  if(Message::MatchMessage(hdr, PLAYER_MSGTYPE_REQ, PLAYER_POSITION2D_REQ_GET_GEOM, position_addr))
  {
    #ifdef DEBUG
      printf("Processing PLAYER_POSITION2D_REQ_GET_GEOM ..\n");
    #endif
    Publish(position_addr, resp_queue, PLAYER_MSGTYPE_RESP_ACK, hdr->subtype, &geometry->position, sizeof(geometry->position));
    return 0;
  }
  

  if(Message::MatchMessage(hdr, PLAYER_MSGTYPE_REQ, PLAYER_POSITION2D_REQ_VELOCITY_MODE, position_addr))
  {
    #ifdef DEBUG
      printf("Processing PLAYER_POSITION2D_REQ_VELOCITY_MODE ..\n");
    #endif
    Publish(position_addr, resp_queue, PLAYER_MSGTYPE_RESP_ACK,hdr->subtype);
    return 0;
  }

  if(Message::MatchMessage(hdr, PLAYER_MSGTYPE_REQ, PLAYER_POSITION2D_REQ_RESET_ODOM, position_addr))
  {
    #ifdef DEBUG
       printf("Processing PLAYER_POSITION2D_REQ_VELOCITY_MODE ..\n");
    #endif
    ResetOdometry();
    Publish(position_addr, resp_queue, PLAYER_POSITION2D_REQ_RESET_ODOM,hdr->subtype);
    return 0;
  }

  if(Message::MatchMessage(hdr, PLAYER_MSGTYPE_REQ, PLAYER_POSITION2D_REQ_SET_ODOM, position_addr))
  {
    #ifdef DEBUG
      printf("Processing PLAYER_POSITION2D_REQ_SET_ODOM ..\n");
    #endif		
    Publish(position_addr, resp_queue, PLAYER_MSGTYPE_RESP_NACK,hdr->subtype);
    return 0;
  }

  // ##############################################    PID COMMANDS
  if (Message::MatchMessage(hdr, PLAYER_MSGTYPE_REQ, PLAYER_POSITION2D_REQ_SPEED_PID, position_addr))
  {
  	assert(hdr->size == sizeof(player_position2d_speed_pid_req_t));
  	player_position2d_speed_pid_req_t * pid = reinterpret_cast<player_position2d_speed_pid_req_t *> (data);

    int kp = ntohl(pid->kp);
    int ki = ntohl(pid->ki);
    int kd = ntohl(pid->kd);

#ifdef DEBUG
    printf("ECBOT: SPEED_PID_REQ kp=%d ki=%d kd=%d\n", kp, ki, kd);
#endif

    ConfigSpeedPID(i2cDev, kp, ki, kd);

    Publish(position_addr, resp_queue, PLAYER_MSGTYPE_RESP_ACK, PLAYER_POSITION2D_REQ_SPEED_PID);
    return 0;
  }


  if (Message::MatchMessage(hdr, PLAYER_MSGTYPE_REQ, PLAYER_POSITION2D_REQ_POSITION_PID, position_addr))
  {
  	assert(hdr->size == sizeof(player_position2d_position_pid_req_t));
  	player_position2d_position_pid_req_t * pid = reinterpret_cast<player_position2d_position_pid_req_t *> (data);

    int kp = ntohl(pid->kp);
    int ki = ntohl(pid->ki);
    int kd = ntohl(pid->kd);

#ifdef DEBUG
    printf("ECBOT: POS_PID_REQ kp=%d ki=%d kd=%d\n", kp, ki, kd);
#endif

    ConfigPosPID(i2cDev, kp, ki, kd);
    Publish(position_addr, resp_queue, PLAYER_MSGTYPE_RESP_ACK, PLAYER_POSITION2D_REQ_POSITION_PID);
    return 0;
  }

  if (Message::MatchMessage(hdr, PLAYER_MSGTYPE_REQ, PLAYER_POSITION2D_REQ_SPEED_PROF, position_addr))
  {
  	assert(hdr->size == sizeof(player_position2d_speed_prof_req_t));
  	player_position2d_speed_prof_req_t * prof = reinterpret_cast<player_position2d_speed_prof_req_t *> (data);

    int spd = ntohs(prof->speed);
    int acc = ntohs(prof->acc);

#ifdef DEBUG
    printf("ECBOT: SPEED_PROF_REQ: spd=%d acc=%d \n", spd, acc);
#endif

    if (acc > ECBOT_MAX_ACC) {
      acc = ECBOT_MAX_ACC;
    } else if (acc == 0) {
      acc = ECBOT_MIN_ACC;
    }

#ifdef DEBUG
    printf("ECBOT: SPEED_PROF_REQ: SPD=%d  ACC=%d\n", spd, acc);
    ConfigSpeedProfile(i2cDev, spd, acc);
#endif

    Publish(position_addr, resp_queue, PLAYER_MSGTYPE_RESP_ACK, PLAYER_POSITION2D_REQ_SPEED_PROF);
    return 0;
  }


  // ##############################################    IR
  if(Message::MatchMessage(hdr, PLAYER_MSGTYPE_REQ, PLAYER_IR_POSE, ir_addr))
  {
    #ifdef DEBUG
      printf("Processing PLAYER_IR_POSE ..\n");
    #endif
    Publish(ir_addr, resp_queue, PLAYER_MSGTYPE_RESP_ACK, hdr->subtype, &geometry->ir, sizeof(geometry->ir));
    return 0;
  }

  // ##############################################   LEDs
  if(Message::MatchMessage(hdr, PLAYER_MSGTYPE_CMD, PLAYER_BLINKENLIGHT_CMD_STATE, blinkenlight_addr))
  {
    #ifdef DEBUG
      printf("Processing PLAYER_BLINKENLIGHT_POSE ..\n");
    #endif

    assert(hdr->size == sizeof(player_blinkenlight_cmd_t));
    ProcessSetColorCmd(hdr, *reinterpret_cast<player_blinkenlight_cmd_t *>(data));
    return 0;
  }

  return -1;
}

void
ECBot::ProcessPos2dVelCmd(player_msghdr_t* hdr, player_position2d_cmd_vel_t &data)
{
  // need to calculate the left and right velocities
  char transvel = static_cast<char> (static_cast<char> (data.vel.px));
  char rotvel = static_cast<char> (static_cast<char> (data.vel.pa));
  char leftvel = transvel - rotvel;
  char rightvel = transvel + rotvel;

  // now we set the speed
  if (this->motors_enabled) 
    SetSpeed(i2cDev, leftvel,rightvel);
  else 
    SetSpeed(i2cDev, 0, 0);
}

void
ECBot::ProcessSetColorCmd(player_msghdr_t* hdr, player_blinkenlight_cmd_t &data)
{
    char LedRed  = static_cast<char> (static_cast<char> (data.color.red));
    char LedGrn  = static_cast<char> (static_cast<char> (data.color.green));
    char LedBlu  = static_cast<char> (static_cast<char> (data.color.blue));

    SetLedColor(i2cDev, LedRed, LedGrn, LedBlu);
}

int 
ECBot::Subscribe(player_devaddr_t addr)
{
  int setupResult;

  // do the subscription
  if((setupResult = Driver::Subscribe(addr)) == 0)
  {
    // also increment the appropriate subscription counter
    switch(addr.interf)
    {
      case PLAYER_POSITION2D_CODE:
        this->position_subscriptions++;
        break;
      case PLAYER_IR_CODE:
        this->ir_subscriptions++;
        break;
      case PLAYER_LED_CODE:
        this->blinkenlight_subscriptions++;
        break;    }
  }

  return(setupResult);
}

int 
ECBot::Unsubscribe(player_devaddr_t addr)
{
  int shutdownResult;

  // do the unsubscription
  if((shutdownResult = Driver::Unsubscribe(addr)) == 0)
  {
    // also decrement the appropriate subscription counter
    switch(addr.interf)
    {
      case PLAYER_POSITION2D_CODE:
        assert(--this->position_subscriptions >= 0);
        break;
      case PLAYER_IR_CODE:
        assert(--this->ir_subscriptions >= 0);
        break;
    }
  }

  return(shutdownResult);
}

/* called the first time a client connects
 *
 * returns: 0 on success
 */
int 
ECBot::Setup()
{
  // open and initialize the serial to -> Khepera  
  printf("ECBOT: initializing ...");
  fflush(stdout);


  refresh_last_position = false;
  motors_enabled = false;
  velocity_mode = true;
  direct_velocity_control = false;

  desired_heading = 0;

  /* now spawn reading thread */
  StartThread();

  printf("Done \n");
  return(0);
}


int 
ECBot::Shutdown()
{
  printf("ECBOT: SHUTDOWN\n");
  StopThread();
  SetSpeed(i2cDev, 0, 0);
  return(0);
}

void 
ECBot::Main()
{
  int last_position_subscrcount=0;

  pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED,NULL);

  while (1) 
  {
    // we want to reset the odometry and enable the motors if the first 
    // client just subscribed to the position device, and we want to stop 
    // and disable the motors if the last client unsubscribed.
    if(!last_position_subscrcount && this->position_subscriptions)
    {
      printf("ECBOT: first pos sub. turn off and reset\n");
      // then first sub for pos, so turn off motors and reset odom
      SetSpeed(i2cDev, 0, 0);
      ResetOdometry();

    } 
    else if(last_position_subscrcount && !(this->position_subscriptions))
    {
      // last sub just unsubbed
      printf("ECBot: last pos sub gone\n");
      SetSpeed(i2cDev, 0, 0);
    }
    last_position_subscrcount = this->position_subscriptions;


    ProcessMessages();
    pthread_testcancel();

    // now lets get new data...
    UpdateData();

    pthread_testcancel();
  }
  pthread_exit(NULL);
}



/* this will update the data that is sent to clients
 * just call separate functions to take care of it
 *
 * returns:
 */
void
ECBot::UpdateData()
{
  player_position2d_data_t position_data;
  player_ir_data_t ir_data;

  UpdatePosData(&position_data);

  // put position data
  Publish(position_addr,NULL,PLAYER_MSGTYPE_DATA, PLAYER_POSITION2D_DATA_STATE, (unsigned char *) &position_data, sizeof(player_position2d_data_t),NULL);

  UpdateIRData(&ir_data);

  // put ir data
  this->Publish(this-> ir_addr,NULL,PLAYER_MSGTYPE_DATA, PLAYER_IR_DATA_RANGES, (void*)&ir_data, sizeof(player_ir_data_t),NULL);

}

/* this will update the IR part of the client data
 * it entails reading the currently active IR sensors
 * and then changing their state to off and turning on
 * 2 new IRs.  
 *
 * returns:
 */
void
ECBot::UpdateIRData(player_ir_data_t * d)
{
  char i;
  ReadAllIR(i2cDev, d);
  d->ranges_count   = 8;
  d->voltages_count = 8;

}

  
/* this will update the position data.  this entails odometry, etc
 */ 
void
ECBot::UpdatePosData(player_position2d_data_t *d)
{
  // calculate position data
  int pos_left, pos_right;
  ECBot::ReadPos(&pos_left, &pos_right);
//  int change_left = pos_left - last_lpos;
//  int change_right = pos_right - last_rpos;
  last_lpos = pos_left;
  last_rpos = pos_right;

  d->pos.pa = DTOR(yaw);
//  d->vel.px = trans_vel/geometry->scale;
//  d->vel.pa = DTOR(rot_vel_deg);
}

/* this will set the odometry to a given position
 * ****NOTE: assumes that the arguments are in network byte order!*****
 *
 * returns: 
 */
int
ECBot::ResetOdometry()
{
  printf("Reset Odometry\n");
  int Values[2];
  Values[0] = 0;
  Values[1] = 0;
//  if (Serial->ECBotCommand('G',2,Values,0,NULL) < 0)
//    return -1;

  last_lpos = 0;
  last_rpos = 0;

  player_position2d_data_t data;
  memset(&data,0,sizeof(player_position2d_data_t));
  Publish(position_addr, NULL, PLAYER_MSGTYPE_DATA, PLAYER_POSITION2D_DATA_STATE, &data, sizeof(data),NULL);

  x=y=yaw=0;
  return 0;
}



/* reads the current speed of motor mn
 *
 * returns: the speed of mn
 */
int
ECBot::ReadSpeed(int * left,int * right)
{
	int Values[2];
//	if (Serial->ECBotCommand('E',0,NULL,2,Values) < 0)
//		return -1;
	*left = Values[0];
	*right = Values[1];
	return 0;
}

/* this sets the desired position motor mn should go to
 *
 * returns:
 */
/*void
REB::SetPos(int mn, int pos)
{
  char buf[64];
  
  sprintf(buf,"C,%c,%d\r", '0'+mn,pos);

  write_command(buf, strlen(buf), sizeof(buf));
}*/

/* this sets the position counter of motor mn to the given value
 *
 * returns:
 */
int
ECBot::SetPosCounter(int pos1, int pos2)
{
	int Values[2];
	Values[0] = pos1;
	Values[1] = pos2;
	return 0;
}

/* this will read the current value of the position counter
 * for motor mn
 *
 * returns: the current position for mn
 */
int
ECBot::ReadPos(int * pos1, int * pos2)
{
	int Values[2];
//	if (Serial->ECBotCommand('H',0,NULL,2,Values) < 0)
//		return -1;
	*pos1 = Values[0];
	*pos2 = Values[1];
	return 0;
}



