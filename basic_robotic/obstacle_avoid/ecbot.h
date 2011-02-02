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

/* Copyright (C) 2007
 *   Carlos Camargo , Universidad Nacional de Colombia
 *
 * Header for the ECBOT robot.
 */

#ifndef _KHEPERADEVICE_H
#define _KHEPERADEVICE_H

#include <pthread.h>
#include <sys/time.h>
#include <errno.h>

#include <replace/replace.h>
#include <libplayercore/playercore.h>

#include <player.h>


#define ECBOT_CONFIG_BUFFER_SIZE 1024
#define ECBOT_BAUDRATE B38400
#define ECBOT_DEFAULT_I2C_PORT "/dev/i2c-0"
#define ECBOT_DEFAULT_SCALE 10
#define ECBOT_DEFAULT_ENCODER_RES (1.0/12.0) 
#define ECBOT_DEFAULT_IR_CALIB_A (64.158)
#define ECBOT_DEFAULT_IR_CALIB_B (-0.1238)

#define ECBOT_MOTOR_LEFT 0
#define ECBOT_MOTOR_RIGHT 1

#define ECBOT_MAX_ACC 0xD0
#define ECBOT_MIN_ACC 0x70


#define ECBOT_IR_START 1
#define ECBOT_IR_STOP 0

#define ECBOT_FIXED_FACTOR 10000

#define CRLF "\r\n"
#define ECBOT_COMMAND_PROMPT "\r\n"

#ifndef ABS
#define ABS(x) ((x) < 0 ? -(x) : (x))
#endif

#ifndef SGN
#define SGN(x) ((x) < 0 ? -1 : 1)
#endif

typedef struct player_ECBot_geom
{
	char * PortName;
	double scale;
	player_ir_pose_t ir;
	double * ir_calib_a;
	double * ir_calib_b;
	player_position2d_geom_t position;
	double encoder_res;
} __attribute__ ((packed)) player_ECBot_geom_t;
	

class ECBot : public Driver 
{
public:
  
  ECBot(ConfigFile *cf, int section);

  /* the main thread */
  virtual void Main();

  virtual int Subscribe(player_devaddr_t addr);
  virtual int Unsubscribe(player_devaddr_t addr);
  
  virtual int Setup();
  virtual int Shutdown();
  
  int ResetOdometry();
  
  // handle IR
  void SetIRState(int);

  // handle LED
  void SetLEDState(int);


  void UpdateData(void);

  void UpdateIRData(player_ir_data_t *);
  void UpdatePosData(player_position2d_data_t *);

  // this handles motor control
  int ReadSpeed(int*, int*);
  int SetPos(int, int);
  int SetPosCounter(int, int);
  int ReadPos(int *, int*);


  int i2cDev;
  

  // MessageHandler
  int ProcessMessage(MessageQueue* resp_queue, player_msghdr * hdr, void * data);

  void ProcessPos2dVelCmd(player_msghdr_t* hdr, player_position2d_cmd_vel_t &data);
  void ProcessSetColorCmd(player_msghdr_t* hdr, player_blinkenlight_cmd_t &data);



  void ProcessPos2dPosCmd(player_msghdr_t* hdr, player_position2d_cmd_pos_t &data);

  void ProcessSpeechCommand(player_msghdr_t* hdr, player_speech_cmd_t &data);
  void ProcessDioCommand(player_msghdr_t* hdr, player_dio_cmd_t &data);

  void ProcessPos2dGeomReq(player_msghdr_t* hdr);
  void ProcessIrPoseReq(player_msghdr_t* hdr);

private:
  player_devaddr_t ir_addr;
  player_devaddr_t position_addr;
  player_devaddr_t blinkenlight_addr;

  int position_subscriptions;
  int ir_subscriptions;
  int blinkenlight_subscriptions;

  player_ECBot_geom_t* geometry;

  int param_index;  // index in the RobotParams table for this robot
  int ECBot_fd;     // ECBOT device file descriptor
  
  struct timeval last_position; // last position update
  bool refresh_last_position;
  int last_lpos, last_rpos;
  double x,y,yaw;
  int last_x_f, last_y_f;
  double last_theta;

  struct timeval last_pos_update; // time of last pos update
  struct timeval last_ir_update;

  int pos_update_period;

  short desired_heading;

  int ir_sequence;
  struct timeval last_ir;

  bool motors_enabled;
  bool velocity_mode;
  bool direct_velocity_control;

  // device used to communicate with reb
  char ECBot_serial_port[MAX_FILENAME_SIZE]; 

  //struct pollfd write_pfd, read_pfd;

  
};


#endif
