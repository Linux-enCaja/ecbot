# $Id: avrdude.conf.in 916 2010-01-15 16:36:13Z joerg_wunsch $
#
# AVRDUDE Configuration File
#
# This file contains configuration data used by AVRDUDE which describes
# the programming hardware pinouts and also provides part definitions.
# AVRDUDE's "-C" command line option specifies the location of the
# configuration file.  The "-c" option names the programmer configuration
# which must match one of the entry's "id" parameter.  The "-p" option
# identifies which part AVRDUDE is going to be programming and must match
# one of the parts' "id" parameter.
#
# Possible entry formats are:
#
#   programmer
#       id       = <id1> [, <id2> [, <id3>] ...] ;  # <idN> are quoted strings
#       desc     = <description> ;                  # quoted string
#       type     = par | stk500 | stk500v2 | stk500pp | stk500hvsp | stk500generic |
#                  stk600 | stk600pp | stk600hvsp |
#                  avr910 | butterfly | usbasp |
#                  jtagmki | jtagmkii | jtagmkii_isp | jtagmkii_dw |
#                  jtagmkII_avr32 | jtagmkii_pdi |
#                  dragon_dw | dragon_jtag | dragon_isp | dragon_pp |
#                  dragon_hvsp | dragon_pdi | arduino; # programmer type
#       baudrate = <num> ;                          # baudrate for avr910-programmer
#       vcc      = <num1> [, <num2> ... ] ;         # pin number(s)
#       reset    = <num> ;                          # pin number
#       sck      = <num> ;                          # pin number
#       mosi     = <num> ;                          # pin number
#       miso     = <num> ;                          # pin number
#       errled   = <num> ;                          # pin number
#       rdyled   = <num> ;                          # pin number
#       pgmled   = <num> ;                          # pin number
#       vfyled   = <num> ;                          # pin number
#     ;
#
#   part
#       id               = <id> ;                 # quoted string
#       desc             = <description> ;        # quoted string
#       has_jtag         = <yes/no> ;             # part has JTAG i/f
#       has_debugwire    = <yes/no> ;             # part has debugWire i/f
#       has_pdi          = <yes/no> ;             # part has PDI i/f
#       has_tpi          = <yes/no> ;             # part has TPI i/f
#       devicecode       = <num> ;            # deprecated, use stk500_devcode
#       stk500_devcode   = <num> ;                # numeric
#       avr910_devcode   = <num> ;                # numeric
#       signature        = <num> <num> <num> ;    # signature bytes
#       chip_erase_delay = <num> ;                # micro-seconds
#       reset            = dedicated | io;
#       retry_pulse      = reset | sck;
#       pgm_enable       = <instruction format> ;
#       chip_erase       = <instruction format> ;
#       chip_erase_delay = <num> ;                # chip erase delay (us)
#       # STK500 parameters (parallel programming IO lines)
#       pagel            = <num> ;                # pin name in hex, i.e., 0xD7
#       bs2              = <num> ;                # pin name in hex, i.e., 0xA0
#       serial           = <yes/no> ;             # can use serial downloading
#       parallel         = <yes/no/pseudo>;       # can use par. programming
#       # STK500v2 parameters, to be taken from Atmel's XML files
#       timeout          = <num> ;
#       stabdelay        = <num> ;
#       cmdexedelay      = <num> ;
#       synchloops       = <num> ;
#       bytedelay        = <num> ;
#       pollvalue        = <num> ;
#       pollindex        = <num> ;
#       predelay         = <num> ;
#       postdelay        = <num> ;
#       pollmethod       = <num> ;
#       mode             = <num> ;
#       delay            = <num> ;
#       blocksize        = <num> ;
#       readsize         = <num> ;
#       hvspcmdexedelay  = <num> ;
#       # STK500v2 HV programming parameters, from XML
#       pp_controlstack  = <num>, <num>, ...;   # PP only
#       hvsp_controlstack = <num>, <num>, ...;  # HVSP only
#       hventerstabdelay = <num>;
#       progmodedelay    = <num>;               # PP only
#       latchcycles      = <num>;
#       togglevtg        = <num>;
#       poweroffdelay    = <num>;
#       resetdelayms     = <num>;
#       resetdelayus     = <num>;
#       hvleavestabdelay = <num>;
#       resetdelay       = <num>;
#       synchcycles      = <num>;               # HVSP only
#       chiperasepulsewidth = <num>;            # PP only
#       chiperasepolltimeout = <num>;
#       chiperasetime    = <num>;               # HVSP only
#       programfusepulsewidth = <num>;          # PP only
#       programfusepolltimeout = <num>;
#       programlockpulsewidth = <num>;          # PP only
#       programlockpolltimeout = <num>;
#       # JTAG ICE mkII parameters, also from XML files
#       allowfullpagebitstream = <yes/no> ;
#       enablepageprogramming = <yes/no> ;
#       idr              = <num> ;                # IO addr of IDR (OCD) reg.
#       rampz            = <num> ;                # IO addr of RAMPZ reg.
#       spmcr            = <num> ;                # mem addr of SPMC[S]R reg.
#       eecr             = <num> ;                # mem addr of EECR reg.
#                                                 # (only when != 0x3c)
#       is_avr32         = <yes/no> ;             # AVR32 part
#
#       memory <memtype>
#           paged           = <yes/no> ;          # yes / no
#           size            = <num> ;             # bytes
#           page_size       = <num> ;             # bytes
#           num_pages       = <num> ;             # numeric
#           min_write_delay = <num> ;             # micro-seconds
#           max_write_delay = <num> ;             # micro-seconds
#           readback_p1     = <num> ;             # byte value
#           readback_p2     = <num> ;             # byte value
#           pwroff_after_write = <yes/no> ;       # yes / no
#           read            = <instruction format> ;
#           write           = <instruction format> ;
#           read_lo         = <instruction format> ;
#           read_hi         = <instruction format> ;
#           write_lo        = <instruction format> ;
#           write_hi        = <instruction format> ;
#           loadpage_lo     = <instruction format> ;
#           loadpage_hi     = <instruction format> ;
#           writepage       = <instruction format> ;
#         ;
#     ;
#
# If any of the above parameters are not specified, the default value
# of 0 is used for numerics or the empty string ("") for string
# values.  If a required parameter is left empty, AVRDUDE will
# complain.
#
# NOTES:
#   * 'devicecode' is the device code used by the STK500 (see codes 
#       listed below)
#   * Not all memory types will implement all instructions.
#   * AVR Fuse bits and Lock bits are implemented as a type of memory.
#   * Example memory types are:
#       "flash", "eeprom", "fuse", "lfuse" (low fuse), "hfuse" (high
#       fuse), "signature", "calibration", "lock"
#   * The memory type specified on the avrdude command line must match
#     one of the memory types defined for the specified chip.
#   * The pwroff_after_write flag causes avrdude to attempt to
#     power the device off and back on after an unsuccessful write to
#     the affected memory area if VCC programmer pins are defined.  If
#     VCC pins are not defined for the programmer, a message
#     indicating that the device needs a power-cycle is printed out.
#     This flag was added to work around a problem with the
#     at90s4433/2333's; see the at90s4433 errata at:
#
#         http://www.atmel.com/atmel/acrobat/doc1280.pdf
#
# INSTRUCTION FORMATS
#
#    Instruction formats are specified as a comma seperated list of
#    string values containing information (bit specifiers) about each
#    of the 32 bits of the instruction.  Bit specifiers may be one of
#    the following formats:
#
#       '1'  = the bit is always set on input as well as output
#
#       '0'  = the bit is always clear on input as well as output
#
#       'x'  = the bit is ignored on input and output
#
#       'a'  = the bit is an address bit, the bit-number matches this bit
#              specifier's position within the current instruction byte
#
#       'aN' = the bit is the Nth address bit, bit-number = N, i.e., a12
#              is address bit 12 on input, a0 is address bit 0.
#
#       'i'  = the bit is an input data bit
#
#       'o'  = the bit is an output data bit
#
#    Each instruction must be composed of 32 bit specifiers.  The
#    instruction specification closely follows the instruction data
#    provided in Atmel's data sheets for their parts.
#
# See below for some examples.
#
#
# The following are STK500 part device codes to use for the
# "devicecode" field of the part.  These came from Atmel's software
# section avr061.zip which accompanies the application note
# AVR061 available from:
#
#      http://www.atmel.com/atmel/acrobat/doc2525.pdf
#

#define ATTINY10    0x10  /* the _old_ one that never existed! */
#define ATTINY11    0x11
#define ATTINY12    0x12
#define ATTINY15    0x13
#define ATTINY13    0x14

#define ATTINY22    0x20
#define ATTINY26    0x21
#define ATTINY28    0x22
#define ATTINY2313  0x23

#define AT90S1200   0x33

#define AT90S2313   0x40
#define AT90S2323   0x41
#define AT90S2333   0x42
#define AT90S2343   0x43

#define AT90S4414   0x50
#define AT90S4433   0x51
#define AT90S4434   0x52
#define ATMEGA48    0x59

#define AT90S8515   0x60
#define AT90S8535   0x61
#define AT90C8534   0x62
#define ATMEGA8515  0x63
#define ATMEGA8535  0x64

#define ATMEGA8     0x70
#define ATMEGA88    0x73
#define ATMEGA168   0x86

#define ATMEGA161   0x80
#define ATMEGA163   0x81
#define ATMEGA16    0x82
#define ATMEGA162   0x83
#define ATMEGA169   0x84

#define ATMEGA323   0x90
#define ATMEGA32    0x91

#define ATMEGA64    0xA0

#define ATMEGA103   0xB1
#define ATMEGA128   0xB2
#define AT90CAN128  0xB3
#define AT90CAN64   0xB3
#define AT90CAN32   0xB3

#define AT86RF401   0xD0

#define AT89START   0xE0
#define AT89S51	    0xE0
#define AT89S52	    0xE1

# The following table lists the devices in the original AVR910
# appnote:
# |Device |Signature | Code |
# +-------+----------+------+
# |tiny12 | 1E 90 05 | 0x55 |
# |tiny15 | 1E 90 06 | 0x56 |
# |       |          |      |
# | S1200 | 1E 90 01 | 0x13 |
# |       |          |      |
# | S2313 | 1E 91 01 | 0x20 |
# | S2323 | 1E 91 02 | 0x48 |
# | S2333 | 1E 91 05 | 0x34 |
# | S2343 | 1E 91 03 | 0x4C |
# |       |          |      |
# | S4414 | 1E 92 01 | 0x28 |
# | S4433 | 1E 92 03 | 0x30 |
# | S4434 | 1E 92 02 | 0x6C |
# |       |          |      |
# | S8515 | 1E 93 01 | 0x38 |
# | S8535 | 1E 93 03 | 0x68 |
# |       |          |      |
# |mega32 | 1E 95 01 | 0x72 |
# |mega83 | 1E 93 05 | 0x65 |
# |mega103| 1E 97 01 | 0x41 |
# |mega161| 1E 94 01 | 0x60 |
# |mega163| 1E 94 02 | 0x64 |

# Appnote AVR109 also has a table of AVR910 device codes, which
# lists:
# dev         avr910   signature
# ATmega8     0x77     0x1E 0x93 0x07
# ATmega8515  0x3B     0x1E 0x93 0x06
# ATmega8535  0x6A     0x1E 0x93 0x08
# ATmega16    0x75     0x1E 0x94 0x03
# ATmega162   0x63     0x1E 0x94 0x04
# ATmega163   0x66     0x1E 0x94 0x02
# ATmega169   0x79     0x1E 0x94 0x05
# ATmega32    0x7F     0x1E 0x95 0x02
# ATmega323   0x73     0x1E 0x95 0x01
# ATmega64    0x46     0x1E 0x96 0x02
# ATmega128   0x44     0x1E 0x97 0x02
#
# These codes refer to "BOOT" device codes which are apparently
# different than standard device codes, for whatever reasons
# (often one above the standard code).

# There are several extended versions of AVR910 implementations around
# in the Internet.  These add the following codes (only devices that
# actually exist are listed):

# ATmega8515	0x3A
# ATmega128	0x43
# ATmega64	0x45
# ATtiny26	0x5E
# ATmega8535	0x69
# ATmega32	0x72
# ATmega16	0x74
# ATmega8	0x76
# ATmega169	0x78

#
# Overall avrdude defaults
#
default_parallel   = "/dev/parport0";
default_serial     = "/dev/ttyS0";


#
# PROGRAMMER DEFINITIONS
#

programmer
  id    = "arduino";
  desc  = "Arduino";
  type  = arduino;
;

programmer
  id	= "avrftdi";
  desc	= "FT2232D based generic programmer";
  type	= avrftdi;
  usbvid     = 0x0403;
  usbpid     = 0x6010;
  usbvendor  = "";
  usbproduct = "";
   reset  = 4;  
   sck    = 1;  
   miso   = 3;  
   mosi   = 2; 
;

programmer
  id    = "avrisp";
  desc  = "Atmel AVR ISP";
  type  = stk500;
;

programmer
  id    = "avrispv2";
  desc  = "Atmel AVR ISP V2";
  type  =  stk500v2;
;

programmer
  id    = "avrispmkII";
  desc  = "Atmel AVR ISP mkII";
  type  =  stk500v2;
;

programmer
  id    = "avrisp2";
  desc  = "Atmel AVR ISP mkII";
  type  =  stk500v2;
;

programmer
  id    = "buspirate";
  desc  = "The Bus Pirate";
  type  = buspirate;
;

# This is supposed to be the "default" STK500 entry.
# Attempts to select the correct firmware version
# by probing for it.  Better use one of the entries
# below instead.
programmer
  id    = "stk500";
  desc  = "Atmel STK500";
  type  = stk500generic;
;

programmer
  id    = "stk500v1";
  desc  = "Atmel STK500 Version 1.x firmware";
  type  = stk500;
;

programmer
  id    = "mib510";
  desc  = "Crossbow MIB510 programming board";
  type  = stk500;
;

programmer
  id    = "stk500v2";
  desc  = "Atmel STK500 Version 2.x firmware";
  type  = stk500v2;
;

programmer
  id    = "stk500pp";
  desc  = "Atmel STK500 V2 in parallel programming mode";
  type  = stk500pp;
;

programmer
  id    = "stk500hvsp";
  desc  = "Atmel STK500 V2 in high-voltage serial programming mode";
  type  = stk500hvsp;
;

programmer
  id    = "stk600";
  desc  = "Atmel STK600";
  type  = stk600;
;

programmer
  id    = "stk600pp";
  desc  = "Atmel STK600 in parallel programming mode";
  type  = stk600pp;
;

programmer
  id    = "stk600hvsp";
  desc  = "Atmel STK600 in high-voltage serial programming mode";
  type  = stk600hvsp;
;

programmer
  id    = "avr910";
  desc  = "Atmel Low Cost Serial Programmer";
  type  = avr910;
;

programmer
  id    = "usbasp";
  desc  = "USBasp, http://www.fischl.de/usbasp/";
  type  = usbasp;
;

programmer
  id    = "usbtiny";
  desc  = "USBtiny simple USB programmer, http://www.ladyada.net/make/usbtinyisp/";
  type  = usbtiny;
;

programmer
  id    = "butterfly";
  desc  = "Atmel Butterfly Development Board";
  type  = butterfly;
;

programmer
  id    = "avr109";
  desc  = "Atmel AppNote AVR109 Boot Loader";
  type  = butterfly;
;

programmer
  id    = "avr911";
  desc  = "Atmel AppNote AVR911 AVROSP";
  type  = butterfly;
;

programmer
  id    = "jtagmkI";
  desc  = "Atmel JTAG ICE (mkI)";
  baudrate = 115200;    # default is 115200
  type  = jtagmki;
;

# easier to type
programmer
  id    = "jtag1";
  desc  = "Atmel JTAG ICE (mkI)";
  baudrate = 115200;    # default is 115200
  type  = jtagmki;
;

# easier to type
programmer
  id    = "jtag1slow";
  desc  = "Atmel JTAG ICE (mkI)";
  baudrate = 19200;
  type  = jtagmki;
;

programmer
  id    = "jtagmkII";
  desc  = "Atmel JTAG ICE mkII";
  baudrate = 19200;    # default is 19200
  type  = jtagmkii;
;

# easier to type
programmer
  id    = "jtag2slow";
  desc  = "Atmel JTAG ICE mkII";
  baudrate = 19200;    # default is 19200
  type  = jtagmkii;
;

# JTAG ICE mkII @ 115200 Bd
programmer
  id    = "jtag2fast";
  desc  = "Atmel JTAG ICE mkII";
  baudrate = 115200;
  type  = jtagmkii;
;

# make the fast one the default, people will love that
programmer
  id    = "jtag2";
  desc  = "Atmel JTAG ICE mkII";
  baudrate = 115200;
  type  = jtagmkii;
;

# JTAG ICE mkII in ISP mode
programmer
  id    = "jtag2isp";
  desc  = "Atmel JTAG ICE mkII in ISP mode";
  baudrate = 115200;
  type  = jtagmkii_isp;
;

# JTAG ICE mkII in debugWire mode
programmer
  id    = "jtag2dw";
  desc  = "Atmel JTAG ICE mkII in debugWire mode";
  baudrate = 115200;
  type  = jtagmkii_dw;
;

# JTAG ICE mkII in AVR32 mode
programmer
  id    = "jtagmkII_avr32";
  desc  = "Atmel JTAG ICE mkII im AVR32 mode";
  baudrate = 115200;
  type  = jtagmkii_avr32;
;

# JTAG ICE mkII in AVR32 mode
programmer
  id    = "jtag2avr32";
  desc  = "Atmel JTAG ICE mkII im AVR32 mode";
  baudrate = 115200;
  type  = jtagmkii_avr32;
;

# JTAG ICE mkII in PDI mode
programmer
  id    = "jtag2pdi";
  desc  = "Atmel JTAG ICE mkII PDI mode";
  baudrate = 115200;
  type  = jtagmkii_pdi;
;

# AVR Dragon in JTAG mode
programmer
  id    = "dragon_jtag";
  desc  = "Atmel AVR Dragon in JTAG mode";
  baudrate = 115200;
  type  = dragon_jtag;
;

# AVR Dragon in ISP mode
programmer
  id    = "dragon_isp";
  desc  = "Atmel AVR Dragon in ISP mode";
  baudrate = 115200;
  type  = dragon_isp;
;

# AVR Dragon in PP mode
programmer
  id    = "dragon_pp";
  desc  = "Atmel AVR Dragon in PP mode";
  baudrate = 115200;
  type  = dragon_pp;
;

# AVR Dragon in HVSP mode
programmer
  id    = "dragon_hvsp";
  desc  = "Atmel AVR Dragon in HVSP mode";
  baudrate = 115200;
  type  = dragon_hvsp;
;

# AVR Dragon in debugWire mode
programmer
  id    = "dragon_dw";
  desc  = "Atmel AVR Dragon in debugWire mode";
  baudrate = 115200;
  type  = dragon_dw;
;

# AVR Dragon in PDI mode
programmer
  id    = "dragon_pdi";
  desc  = "Atmel AVR Dragon in PDI mode";
  baudrate = 115200;
  type  = dragon_pdi;
;

programmer
  id    = "pavr";
  desc  = "Jason Kyle's pAVR Serial Programmer";
  type  = avr910;
;

# Parallel port programmers.

programmer
  id    = "bsd";
  desc  = "Brian Dean's Programmer, http://www.bsdhome.com/avrdude/";
  type  = par;
  vcc   = 2, 3, 4, 5;
  reset = 7;
  sck   = 8;
  mosi  = 9;
  miso  = 10;
;

programmer
  id    = "stk200";
  desc  = "STK200";
  type  = par;
  buff  = 4, 5;
  sck   = 6;
  mosi  = 7;
  reset = 9;
  miso  = 10;
;

# The programming dongle used by the popular Ponyprog
# utility.  It is almost similar to the STK200 one,
# except that there is a LED indicating that the
# programming is currently in progress.

programmer
  id    = "pony-stk200";
  desc  = "Pony Prog STK200";
  type  = par;
  buff  = 4, 5;
  sck   = 6;
  mosi  = 7;
  reset = 9;
  miso  = 10;
  pgmled = 8; 
;

programmer
  id    = "dt006";
  desc  = "Dontronics DT006";
  type  = par;
  reset = 4;
  sck   = 5;
  mosi  = 2;
  miso  = 11;
;

programmer
  id    = "bascom";
  desc  = "Bascom SAMPLE programming cable";
  type  = par;
  reset = 4;
  sck   = 5;
  mosi  = 2;
  miso  = 11;
;

programmer
  id     = "alf";
  desc   = "Nightshade ALF-PgmAVR, http://nightshade.homeip.net/";
  type   = par;
  vcc    = 2, 3, 4, 5;
  buff   = 6;
  reset  = 7;
  sck    = 8;
  mosi   = 9;
  miso   = 10;
  errled = 1;
  rdyled = 14;
  pgmled = 16;
  vfyled = 17;
;

programmer
  id    = "sp12";
  desc  = "Steve Bolt's Programmer";
  type  = par;
  vcc   = 4,5,6,7,8;
  reset = 3;
  sck   = 2;
  mosi  = 9;
  miso  = 11;
;

programmer
  id     = "picoweb";
  desc   = "Picoweb Programming Cable, http://www.picoweb.net/";
  type   = par;
  reset  = 2;
  sck    = 3;
  mosi   = 4;
  miso   = 13;
;

programmer
  id    = "abcmini";
  desc  = "ABCmini Board, aka Dick Smith HOTCHIP";
  type  = par;
  reset = 4;
  sck   = 3;
  mosi  = 2;
  miso  = 10;
;

programmer
  id    = "futurlec";
  desc  = "Futurlec.com programming cable.";
  type  = par;
  reset = 3;
  sck   = 2;
  mosi  = 1;
  miso  = 10;
;


# From the contributor of the "xil" jtag cable:
# The "vcc" definition isn't really vcc (the cable gets its power from
# the programming circuit) but is necessary to switch one of the
# buffer lines (trying to add it to the "buff" lines doesn't work).
# With this, TMS connects to RESET, TDI to MOSI, TDO to MISO and TCK
# to SCK (plus vcc/gnd of course)
programmer
  id    = "xil";
  desc  = "Xilinx JTAG cable";
  type  = par;
  mosi  = 2;
  sck   = 3;
  reset = 4;
  buff  = 5;
  miso  = 13;
  vcc   = 6;
;


programmer
  id = "dapa";
  desc = "Direct AVR Parallel Access cable";
  type = par;
  vcc   = 3;
  reset = 16;
  sck = 1;
  mosi = 2;
  miso = 11;
;

programmer
  id    = "atisp";
  desc  = "AT-ISP V1.1 programming cable for AVR-SDK1 from <http://micro-research.co.th/> micro-research.co.th";
  type  = par;
  reset = ~6;
  sck   = ~8;
  mosi  = ~7;
  miso  = ~10;
;

programmer
  id    = "ere-isp-avr";
  desc  = "ERE ISP-AVR <http://www.ere.co.th/download/sch050713.pdf>";
  type  = par;
  reset = ~4;
  sck   = 3;
  mosi  = 2;
  miso  = 10;
;

programmer
  id    = "blaster";
  desc  = "Altera ByteBlaster";
  type  = par;
  sck   = 2;
  miso  = 11;
  reset = 3;
  mosi  = 8;
  buff  = 14;
;

# It is almost same as pony-stk200, except vcc on pin 5 to auto
# disconnect port (download on http://electropol.free.fr)
programmer
  id    = "frank-stk200";
  desc  = "Frank STK200";
  type  = par;
  vcc   = 5;
  sck   = 6;
  mosi  = 7;
  reset = 9;
  miso  = 10;
  pgmled = 8;
;

# The AT98ISP Cable is a simple parallel dongle for AT89 family.
# http://www.atmel.com/dyn/products/tools_card.asp?tool_id=2877
programmer
id = "89isp";
desc = "Atmel at89isp cable";
type = par;
reset = 17;
sck = 1;
mosi = 2;
miso = 10;
;


#
# some ultra cheap programmers use bitbanging on the 
# serialport.
#
# PC - DB9 - Pins for RS232:
#
# GND   5   -- |O
#              |   O| <-   9   RI
# DTR   4   <- |O   |
#              |   O| <-   8   CTS
# TXD   3   <- |O   |
#              |   O| ->   7   RTS
# RXD   2   -> |O   |
#              |   O| <-   6   DSR
# DCD   1   -> |O
#
# Using RXD is currently not supported.
# Using RI is not supported under Win32 but is supported under Posix.

# serial ponyprog design (dasa2 in uisp)
# reset=!txd sck=rts mosi=dtr miso=cts

programmer
  id    = "ponyser";
  desc  = "design ponyprog serial, reset=!txd sck=rts mosi=dtr miso=cts";
  type  = serbb;
  reset = ~3;
  sck   = 7;
  mosi  = 4;
  miso  = 8;
;

# Same as above, different name
# reset=!txd sck=rts mosi=dtr miso=cts

programmer
  id    = "siprog";
  desc  = "Lancos SI-Prog <http://www.lancos.com/siprogsch.html>";
  type  = serbb;
  reset = ~3;
  sck   = 7;
  mosi  = 4;
  miso  = 8;
;

# unknown (dasa in uisp)
# reset=rts sck=dtr mosi=txd miso=cts

programmer
  id    = "dasa";
  desc  = "serial port banging, reset=rts sck=dtr mosi=txd miso=cts";
  type  = serbb;
  reset = 7;
  sck   = 4;
  mosi  = 3;
  miso  = 8;
;

# unknown (dasa3 in uisp)
# reset=!dtr sck=rts mosi=txd miso=cts

programmer
  id    = "dasa3";
  desc  = "serial port banging, reset=!dtr sck=rts mosi=txd miso=cts";
  type  = serbb;
  reset = ~4;
  sck   = 7;
  mosi  = 3;
  miso  = 8;
;

# C2N232i (jumper configuration "auto")
# reset=dtr sck=!rts mosi=!txd miso=!cts

programmer
  id    = "c2n232i";
  desc  = "serial port banging, reset=dtr sck=!rts mosi=!txd miso=!cts";
  type  = serbb;
  reset = 4;
  sck   = ~7;
  mosi  = ~3;
  miso  = ~8;
;

#
# PART DEFINITIONS
#

#------------------------------------------------------------
# ATtiny11
#------------------------------------------------------------

# This is an HVSP-only device.

part
    id                  = "t11";
    desc                = "ATtiny11";
    stk500_devcode      = 0x11;
    signature           = 0x1e 0x90 0x04;
    chip_erase_delay    = 20000;

    timeout		= 200;
    hvsp_controlstack     =
        0x4C, 0x0C, 0x1C, 0x2C, 0x3C, 0x64, 0x74, 0x00,
        0x68, 0x78, 0x68, 0x68, 0x00, 0x00, 0x68, 0x78,
        0x78, 0x00, 0x6D, 0x0C, 0x80, 0x40, 0x20, 0x10,
        0x11, 0x08, 0x04, 0x02, 0x03, 0x08, 0x04, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    hvspcmdexedelay     = 0;
    synchcycles         = 6;
    latchcycles         = 1;
    togglevtg           = 1;
    poweroffdelay       = 25;
    resetdelayms        = 0;
    resetdelayus        = 50;
    hvleavestabdelay    = 100;
    resetdelay          = 25;
    chiperasepolltimeout = 40;
    chiperasetime       = 0;
    programfusepolltimeout = 25;
    programlockpolltimeout = 25;

    memory "eeprom"
        size            = 64;
	blocksize	= 64;
	readsize	= 256;
	delay		= 5;
    ;

    memory "flash"
        size            = 1024;
	blocksize	= 128;
	readsize	= 256;
	delay		= 3;
    ;

    memory "signature"
        size            = 3;
    ;

    memory "lock"
        size            = 1;
    ;

    memory "calibration"
        size            = 1;
    ;

    memory "fuse"
        size            = 1;
    ;
;

#------------------------------------------------------------
# ATtiny12
#------------------------------------------------------------

part
    id                  = "t12";
    desc                = "ATtiny12";
    stk500_devcode      = 0x12;
    avr910_devcode      = 0x55;
    signature           = 0x1e 0x90 0x05;
    chip_erase_delay    = 20000;
    pgm_enable          = "1 0 1 0  1 1 0 0   0 1 0 1  0 0 1 1",
                          "x x x x  x x x x   x x x x  x x x x";

    chip_erase          = "1 0 1 0  1 1 0 0   1 0 0 x  x x x x",
                          "x x x x  x x x x   x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    hvsp_controlstack   =
        0x4C, 0x0C, 0x1C, 0x2C, 0x3C, 0x64, 0x74, 0x00,
        0x68, 0x78, 0x68, 0x68, 0x00, 0x00, 0x68, 0x78,
        0x78, 0x00, 0x6D, 0x0C, 0x80, 0x40, 0x20, 0x10,
        0x11, 0x08, 0x04, 0x02, 0x03, 0x08, 0x04, 0x00;
    hventerstabdelay    = 100;
    hvspcmdexedelay     = 0;
    synchcycles         = 6;
    latchcycles         = 1;
    togglevtg           = 1;
    poweroffdelay       = 25;
    resetdelayms        = 0;
    resetdelayus        = 50;
    hvleavestabdelay    = 100;
    resetdelay          = 25;
    chiperasepolltimeout = 40;
    chiperasetime       = 0;
    programfusepolltimeout = 25;
    programlockpolltimeout = 25;

    memory "eeprom"
        size            = 64;
        min_write_delay = 9000;
        max_write_delay = 20000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read            = "1  0  1  0   0  0  0  0    x x x x  x x x x",
                          "x  x a5 a4  a3 a2 a1 a0    o o o o  o o o o";

        write           = "1  1  0  0   0  0  0  0    x x x x  x x x x",
                          "x  x a5 a4  a3 a2 a1 a0    i i i i  i i i i";

	mode		= 0x04;
	delay		= 8;
	blocksize	= 64;
	readsize	= 256;
    ;

    memory "flash"
        size            = 1024;
        min_write_delay = 4500;
        max_write_delay = 20000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0  0  1  0   0  0  0  0",
                          "  x  x  x  x   x  x  x a8",
                          " a7 a6 a5 a4  a3 a2 a1 a0",
                          "  o  o  o  o   o  o  o  o";

        read_hi         = "  0  0  1  0   1  0  0  0",
                          "  x  x  x  x   x  x  x a8",
                          " a7 a6 a5 a4  a3 a2 a1 a0",
                          "  o  o  o  o   o  o  o  o";

        write_lo        = "  0  1  0  0   0  0  0  0",
                          "  x  x  x  x   x  x  x a8",
                          " a7 a6 a5 a4  a3 a2 a1 a0",
                          "  i  i  i  i   i  i  i  i";

        write_hi        = "  0  1  0  0   1  0  0  0",
                          "  x  x  x  x   x  x  x a8",
                          " a7 a6 a5 a4  a3 a2 a1 a0",
                          "  i  i  i  i   i  i  i  i";

	mode		= 0x04;
	delay		= 5;
	blocksize	= 128;
	readsize	= 256;
    ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0    x x x x  x x x x",
                          "0  0  0  0   0  0 a1 a0    o o o o  o o o o";
    ;

    memory "lock"
        size            = 1;
        read            = "0  1  0  1   1  0  0  0    x x x x  x x x x",
                          "x  x  x  x   x  x  x  x    x x x x  x o o x";

        write           = "1  0  1  0   1  1  0  0    1 1 1 1  1 i i 1",
                          "x  x  x  x   x  x  x  x    x x x x  x x x x";
        min_write_delay = 9000;
        max_write_delay = 9000;
    ;

    memory "calibration"
        size            = 1;
        read            = "0  0  1  1   1  0  0  0    x x x x  x x x x",
                          "0  0  0  0   0  0  0  0    o o o o  o o o o";
    ;

    memory "fuse"
        size            = 1;
        read            = "0  1  0  1   0  0  0  0    x x x x  x x x x",
                          "x  x  x  x   x  x  x  x    o o o o  o o o o";

        write           = "1  0  1  0   1  1  0  0    1 0 1 x  x x x x",
                          "x  x  x  x   x  x  x  x    i i i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
    ;
;

#------------------------------------------------------------
# ATtiny13
#------------------------------------------------------------

part
    id                  = "t13";
    desc                = "ATtiny13";
     has_debugwire = yes;
     flash_instr   = 0xB4, 0x0E, 0x1E;
     eeprom_instr  = 0xBB, 0xFE, 0xBB, 0xEE, 0xBB, 0xCC, 0xB2, 0x0D,
	             0xBC, 0x0E, 0xB4, 0x0E, 0xBA, 0x0D, 0xBB, 0xBC,
	             0x99, 0xE1, 0xBB, 0xAC;
    stk500_devcode      = 0x14;
    signature           = 0x1e 0x90 0x07;
    chip_erase_delay    = 4000;
    pgm_enable          = "1 0 1 0  1 1 0 0   0 1 0 1  0 0 1 1",
                          "x x x x  x x x x   x x x x  x x x x";

    chip_erase          = "1 0 1 0  1 1 0 0   1 0 0 x  x x x x",
                          "x x x x  x x x x   x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    hvsp_controlstack     =
	0x4C, 0x0C, 0x1C, 0x2C, 0x3C, 0x64, 0x74, 0x66,
        0x68, 0x78, 0x68, 0x68, 0x7A, 0x6A, 0x68, 0x78,
        0x78, 0x7D, 0x6D, 0x0C, 0x80, 0x40, 0x20, 0x10,
        0x11, 0x08, 0x04, 0x02, 0x03, 0x08, 0x04, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    hvspcmdexedelay     = 0;
    synchcycles         = 6;
    latchcycles         = 1;
    togglevtg           = 1;
    poweroffdelay       = 25;
    resetdelayms        = 0;
    resetdelayus        = 90;
    hvleavestabdelay    = 100;
    resetdelay          = 25;
    chiperasepolltimeout = 40;
    chiperasetime       = 0;
    programfusepolltimeout = 25;
    programlockpolltimeout = 25;

    memory "eeprom"
        size            = 64;
        page_size       = 4;
        min_write_delay = 4000;
        max_write_delay = 4000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read            = "1  0  1  0   0  0  0  0    0 0 0 x  x x x x",
                          "x  x a5 a4  a3 a2 a1 a0    o o o o  o o o o";

        write           = "1  1  0  0   0  0  0  0    0 0 0 x  x x x x",
                          "x  x a5 a4  a3 a2 a1 a0    i i i i  i i i i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x   x   x",
			  "  x   x  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 5;
	blocksize	= 4;
	readsize	= 256;
    ;

    memory "flash"
        paged           = yes;
        size            = 1024;
        page_size       = 32;
        num_pages       = 32;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0  0  1  0   0  0  0  0",
                          "  0  0  0  0   0  0  0 a8",
                          " a7 a6 a5 a4  a3 a2 a1 a0",
                          "  o  o  o  o   o  o  o  o";

        read_hi         = "  0  0  1  0   1  0  0  0",
                          "  0  0  0  0   0  0  0 a8",
                          " a7 a6 a5 a4  a3 a2 a1 a0",
                          "  o  o  o  o   o  o  o  o";

        loadpage_lo     = "  0  1  0  0   0  0  0  0",
                          "  0  0  0  x   x  x  x  x",
                          "  x  x  x  x  a3 a2 a1 a0",
                          "  i  i  i  i   i  i  i  i";

        loadpage_hi     = "  0  1  0  0   1  0  0  0",
                          "  0  0  0  x   x  x  x  x",
                          "  x  x  x  x  a3 a2 a1 a0",
                          "  i  i  i  i   i  i  i  i";

        writepage       = "  0  1  0  0   1  1  0  0",
                          "  0  0  0  0   0  0  0 a8",
                          " a7 a6 a5 a4   x  x  x  x",
                          "  x  x  x  x   x  x  x  x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 32;
	readsize	= 256;
    ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0    0 0 0 x  x x x x",
                          "x  x  x  x   x  x a1 a0    o o o o  o o o o";
    ;

    memory "lock"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;

	read            = "0  1  0  1   1  0  0  0    0 0 0 0  0 0 0 0",
                          "x  x  x  x   x  x  x  x    x x o o  o o o o";

        write           = "1  0  1  0   1  1  0  0    1 1 1 x  x x x x",
                          "x  x  x  x   x  x  x  x    1 1 i i  i i i i";
    ;

    memory "calibration"
        size            = 2;
        read            = "0  0  1  1   1  0  0  0    0 0 0 x  x x x x",
                          "0  0  0  0   0  0  0 a0    o o o o  o o o o";
    ;

    memory "lfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;

        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
      ;

    memory "hfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;

        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
      ;

;


#------------------------------------------------------------
# ATtiny15
#------------------------------------------------------------

part
    id                  = "t15";
    desc                = "ATtiny15";
    stk500_devcode      = 0x13;
    avr910_devcode      = 0x56;
    signature           = 0x1e 0x90 0x06;
    chip_erase_delay    = 8200;
    pgm_enable          = "1 0 1 0  1 1 0 0   0 1 0 1  0 0 1 1",
                          "x x x x  x x x x   x x x x  x x x x";

    chip_erase          = "1 0 1 0  1 1 0 0   1 0 0 x  x x x x",
                          "x x x x  x x x x   x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    hvsp_controlstack   =
        0x4C, 0x0C, 0x1C, 0x2C, 0x3C, 0x64, 0x74, 0x00,
        0x68, 0x78, 0x68, 0x68, 0x00, 0x00, 0x68, 0x78,
        0x78, 0x00, 0x6D, 0x0C, 0x80, 0x40, 0x20, 0x10,
        0x11, 0x08, 0x04, 0x02, 0x03, 0x08, 0x04, 0x00;
    hventerstabdelay    = 100;
    hvspcmdexedelay     = 5;
    synchcycles         = 6;
    latchcycles         = 16;
    togglevtg           = 1;
    poweroffdelay       = 25;
    resetdelayms        = 0;
    resetdelayus        = 50;
    hvleavestabdelay    = 100;
    resetdelay          = 25;
    chiperasepolltimeout = 40;
    chiperasetime       = 0;
    programfusepolltimeout = 25;
    programlockpolltimeout = 25;

    memory "eeprom"
        size            = 64;
        min_write_delay = 8200;
        max_write_delay = 8200;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read            = "1  0  1  0   0  0  0  0    x x x x  x x x x",
                          "x  x a5 a4  a3 a2 a1 a0    o o o o  o o o o";

        write           = "1  1  0  0   0  0  0  0    x x x x  x x x x",
                          "x  x a5 a4  a3 a2 a1 a0    i i i i  i i i i";

	mode		= 0x04;
	delay		= 10;
	blocksize	= 64;
	readsize	= 256;
    ;

    memory "flash"
        size            = 1024;
        min_write_delay = 4100;
        max_write_delay = 4100;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0  0  1  0   0  0  0  0",
                          "  x  x  x  x   x  x  x a8",
                          " a7 a6 a5 a4  a3 a2 a1 a0",
                          "  o  o  o  o   o  o  o  o";

        read_hi         = "  0  0  1  0   1  0  0  0",
                          "  x  x  x  x   x  x  x a8",
                          " a7 a6 a5 a4  a3 a2 a1 a0",
                          "  o  o  o  o   o  o  o  o";

        write_lo        = "  0  1  0  0   0  0  0  0",
                          "  x  x  x  x   x  x  x a8",
                          " a7 a6 a5 a4  a3 a2 a1 a0",
                          "  i  i  i  i   i  i  i  i";

        write_hi        = "  0  1  0  0   1  0  0  0",
                          "  x  x  x  x   x  x  x a8",
                          " a7 a6 a5 a4  a3 a2 a1 a0",
                          "  i  i  i  i   i  i  i  i";

	mode		= 0x04;
	delay		= 5;
	blocksize	= 128;
	readsize	= 256;
    ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0    x x x x  x x x x",
                          "0  0  0  0   0  0 a1 a0    o o o o  o o o o";
    ;

    memory "lock"
        size            = 1;
        read            = "0  1  0  1   1  0  0  0    x x x x  x x x x",
                          "x  x  x  x   x  x  x  x    x x x x  x o o x";

        write           = "1  0  1  0   1  1  0  0    1 1 1 1  1 i i 1",
                          "x  x  x  x   x  x  x  x    x x x x  x x x x";
        min_write_delay = 9000;
        max_write_delay = 9000;
    ;

    memory "calibration"
        size            = 1;
        read            = "0  0  1  1   1  0  0  0    x x x x  x x x x",
                          "0  0  0  0   0  0  0  0    o o o o  o o o o";
    ;

    memory "fuse"
        size            = 1;
        read            = "0  1  0  1   0  0  0  0    x x x x  x x x x",
                          "x  x  x  x   x  x  x  x    o o o o  x x o o";

        write           = "1  0  1  0   1  1  0  0    1 0 1 x  x x x x",
                          "x  x  x  x   x  x  x  x    i i i i  1 1 i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
    ;
;

#------------------------------------------------------------
# AT90s1200
#------------------------------------------------------------

part
    id               = "1200";
    desc             = "AT90S1200";
    stk500_devcode   = 0x33;
    avr910_devcode   = 0x13;
    signature        = 0x1e 0x90 0x01;
    pagel            = 0xd7;
    bs2              = 0xa0;
    chip_erase_delay = 20000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 1;
    bytedelay		= 0;
    pollindex		= 0;
    pollvalue		= 0xFF;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 0;
    togglevtg           = 0;
    poweroffdelay       = 0;
    resetdelayms        = 0;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 15;
    chiperasepolltimeout = 0;
    programfusepulsewidth = 2;
    programfusepolltimeout = 0;
    programlockpulsewidth = 0;
    programlockpolltimeout = 1;

    memory "eeprom"
        size            = 64;
        min_write_delay = 4000;
        max_write_delay = 9000;
        readback_p1     = 0x00;
        readback_p2     = 0xff;
        read            = "1 0  1  0   0  0  0  0   x x x x  x x x x", 
                          "x x a5 a4  a3 a2 a1 a0   o o o o  o o o o";

        write           = "1 1  0  0   0  0  0  0   x x x x  x x x x",
                          "x x a5 a4  a3 a2 a1 a0   i i i i  i i i i";

	mode		= 0x04;
	delay		= 20;
	blocksize	= 32;
	readsize	= 256;
      ;
    memory "flash"
        size            = 1024;
        min_write_delay = 4000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0    0   0   0   0",
                          "  x   x   x   x    x   x   x  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        read_hi         = "  0   0   1   0    1   0   0   0",
                          "  x   x   x   x    x   x   x  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        write_lo        = "  0   1   0   0    0   0   0   0",
                          "  x   x   x   x    x   x   x  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  i   i   i   i    i   i   i   i";

        write_hi        = "  0   1   0   0    1   0   0   0",
                          "  x   x   x   x    x   x   x  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  i   i   i   i    i   i   i   i";

	mode		= 0x02;
	delay		= 15;
	blocksize	= 128;
	readsize	= 256;
      ;
    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
    memory "fuse"
        size            = 1;
      ;
    memory "lock"
        size            = 1;
        min_write_delay = 9000;
        max_write_delay = 20000;
        write           = "1 0 1 0  1 1 0 0   1 1 1 1  1 i i 1",
                          "x x x x  x x x x   x x x x  x x x x";
      ;
  ;

#------------------------------------------------------------
# AT90s4414
#------------------------------------------------------------

part
    id               = "4414";
    desc             = "AT90S4414";
    stk500_devcode   = 0x50;
    avr910_devcode   = 0x28;
    signature        = 0x1e 0x92 0x01;
    chip_erase_delay = 20000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 0;
    togglevtg           = 0;
    poweroffdelay       = 0;
    resetdelayms        = 0;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 15;
    chiperasepolltimeout = 0;
    programfusepulsewidth = 2;
    programfusepolltimeout = 0;
    programlockpulsewidth = 0;
    programlockpolltimeout = 1;

    memory "eeprom"
        size            = 256;
        min_write_delay = 9000;
        max_write_delay = 20000;
        readback_p1     = 0x80;
        readback_p2     = 0x7f;
        read            = " 1  0  1  0   0  0  0  0  x x x x  x x x a8", 
                          "a7 a6 a5 a4 a3 a2 a1 a0   o o o o  o o o o";

        write           = " 1  1  0  0   0  0  0  0   x x x x  x x x a8",
                          "a7 a6 a5 a4  a3 a2 a1 a0   i i i i  i i i i";

	mode		= 0x04;
	delay		= 12;
	blocksize	= 64;
	readsize	= 256;
      ;
    memory "flash"
        size            = 4096;
        min_write_delay = 9000;
        max_write_delay = 20000;
        readback_p1     = 0x7f;
        readback_p2     = 0x7f;
        read_lo         = "  0   0   1   0    0   0   0   0",
                          "  x   x   x   x  a11 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        read_hi         = "  0   0   1   0    1   0   0   0",
                          "  x   x   x   x  a11 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        write_lo        = "  0   1   0   0    0   0   0   0",
                          "  x   x   x   x  a11 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  i   i   i   i    i   i   i   i";

        write_hi        = "  0   1   0   0    1   0   0   0",
                          "  x   x   x   x  a11 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  i   i   i   i    i   i   i   i";

	mode		= 0x04;
	delay		= 12;
	blocksize	= 64;
	readsize	= 256;
      ;
    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
    memory "fuse"
	size		= 1;
      ;
    memory "lock"
	size		= 1;
	write		= "1  0  1  0   1  1  0  0   1  1  1  1   1  i  i  1",
			  "x  x  x  x   x  x  x  x   x  x  x  x   x  x  x  x";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;
  ;

#------------------------------------------------------------
# AT90s2313
#------------------------------------------------------------

part
    id               = "2313";
    desc             = "AT90S2313";
    stk500_devcode   = 0x40;
    avr910_devcode   = 0x20;
    signature        = 0x1e 0x91 0x01;
    chip_erase_delay = 20000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 0;
    togglevtg           = 0;
    poweroffdelay       = 0;
    resetdelayms        = 0;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 15;
    chiperasepolltimeout = 0;
    programfusepulsewidth = 2;
    programfusepolltimeout = 0;
    programlockpulsewidth = 0;
    programlockpolltimeout = 1;

    memory "eeprom"
        size            = 128;
        min_write_delay = 4000;
        max_write_delay = 9000;
        readback_p1     = 0x80;
        readback_p2     = 0x7f;
        read            = "1  0  1  0   0  0  0  0   x x x x  x x x x", 
                          "x a6 a5 a4  a3 a2 a1 a0   o o o o  o o o o";

        write           = "1  1  0  0   0  0  0  0   x x x x  x x x x",
                          "x a6 a5 a4  a3 a2 a1 a0   i i i i  i i i i";

	mode		= 0x04;
	delay		= 12;
	blocksize	= 64;
	readsize	= 256;
      ;
    memory "flash"
        size            = 2048;
        min_write_delay = 4000;
        max_write_delay = 9000;
        readback_p1     = 0x7f;
        readback_p2     = 0x7f;
        read_lo         = "  0   0   1   0    0   0   0   0",
                          "  x   x   x   x    x   x  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        read_hi         = "  0   0   1   0    1   0   0   0",
                          "  x   x   x   x    x   x  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        write_lo        = "  0   1   0   0    0   0   0   0",
                          "  x   x   x   x    x   x  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  i   i   i   i    i   i   i   i";

        write_hi        = "  0   1   0   0    1   0   0   0",
                          "  x   x   x   x    x   x  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  i   i   i   i    i   i   i   i";

	mode		= 0x04;
	delay		= 12;
	blocksize	= 128;
	readsize	= 256;
      ;
    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
    memory "fuse"
        size            = 1;
      ;
    memory "lock"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 1 1 x  x i i x",
                          "x x x x  x x x x  x x x x  x x x x";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;
  ;

#------------------------------------------------------------
# AT90s2333
#------------------------------------------------------------

part
    id               = "2333";
##### WARNING: No XML file for device 'AT90S2333'! #####
    desc             = "AT90S2333";
    stk500_devcode   = 0x42;
    avr910_devcode   = 0x34;
    signature        = 0x1e 0x91 0x05;
    chip_erase_delay = 20000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 0;
    togglevtg           = 0;
    poweroffdelay       = 0;
    resetdelayms        = 0;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 15;
    chiperasepolltimeout = 0;
    programfusepulsewidth = 2;
    programfusepolltimeout = 0;
    programlockpulsewidth = 0;
    programlockpolltimeout = 1;

    memory "eeprom"
        size            = 128;
        min_write_delay = 9000;
        max_write_delay = 20000;
        readback_p1     = 0x00;
        readback_p2     = 0xff;
        read            = "1  0  1  0   0  0  0  0   x x x x  x x x x", 
                          "x a6 a5 a4  a3 a2 a1 a0   o o o o  o o o o";

        write           = "1  1  0  0   0  0  0  0   x x x x  x x x x",
                          "x a6 a5 a4  a3 a2 a1 a0   i i i i  i i i i";

	mode		= 0x04;
	delay		= 12;
	blocksize	= 128;
	readsize	= 256;
      ;

    memory "flash"
        size            = 2048;
        min_write_delay = 9000;
        max_write_delay = 20000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0    0   0   0   0",
                          "  x   x   x   x    x   x  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        read_hi         = "  0   0   1   0    1   0   0   0",
                          "  x   x   x   x    x   x  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        write_lo        = "  0   1   0   0    0   0   0   0",
                          "  x   x   x   x    x   x  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  i   i   i   i    i   i   i   i";

        write_hi        = "  0   1   0   0    1   0   0   0",
                          "  x   x   x   x    x   x  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  i   i   i   i    i   i   i   i";

	mode		= 0x04;
	delay		= 12;
	blocksize	= 128;
	readsize	= 256;
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
    memory "fuse"
        size            = 1;
        min_write_delay = 9000;
        max_write_delay = 20000;
        pwroff_after_write = yes;
        read            = "0 1 0 1  0 0 0 0   x x x x  x x x x",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 i  i i i i",
                          "x x x x  x x x x   x x x x  x x x x";
      ;
    memory "lock"
        size            = 1;
        min_write_delay = 9000;
        max_write_delay = 20000;
        read            = "0 1 0 1  1 0 0 0   x x x x  x x x x",
                          "x x x x  x x x x   x x x x  x o o x";

        write           = "1 0 1 0  1 1 0 0   1 1 1 1  1 i i 1",
                          "x x x x  x x x x   x x x x  x x x x";
      ;
  ;


#------------------------------------------------------------
# AT90s2343 (also AT90s2323 and ATtiny22)
#------------------------------------------------------------

part
    id               = "2343";
    desc             = "AT90S2343";
    stk500_devcode   = 0x43;
    avr910_devcode   = 0x4c;
    signature        = 0x1e 0x91 0x03;
    chip_erase_delay = 18000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    hvsp_controlstack   =
        0x4C, 0x0C, 0x1C, 0x2C, 0x3C, 0x64, 0x74, 0x00,
        0x68, 0x78, 0x68, 0x68, 0x00, 0x00, 0x68, 0x78,
        0x78, 0x00, 0x6D, 0x0C, 0x80, 0x40, 0x20, 0x10,
        0x11, 0x08, 0x04, 0x02, 0x03, 0x08, 0x04, 0x00;
    hventerstabdelay    = 100;
    hvspcmdexedelay     = 0;
    synchcycles         = 6;
    latchcycles         = 1;
    togglevtg           = 0;
    poweroffdelay       = 25;
    resetdelayms        = 0;
    resetdelayus        = 50;
    hvleavestabdelay    = 100;
    resetdelay          = 25;
    chiperasepolltimeout = 40;
    chiperasetime       = 0;
    programfusepolltimeout = 25;
    programlockpolltimeout = 25;

    memory "eeprom"
        size            = 128;
        min_write_delay = 9000;
        max_write_delay = 20000;
        readback_p1     = 0x00;
        readback_p2     = 0xff;
        read            = "1  0  1  0   0  0  0  0   0 0 0 0  0 0 0 0", 
                          "x a6 a5 a4  a3 a2 a1 a0   o o o o  o o o o";

        write           = "1  1  0  0   0  0  0  0   0 0 0 0  0 0 0 0",
                          "x a6 a5 a4  a3 a2 a1 a0   i i i i  i i i i";

	mode		= 0x04;
	delay		= 12;
	blocksize	= 64;
	readsize	= 256;
      ;
    memory "flash"
        size            = 2048;
        min_write_delay = 9000;
        max_write_delay = 20000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0    0   0   0   0",
                          "  x   x   x   x    x   x  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        read_hi         = "  0   0   1   0    1   0   0   0",
                          "  x   x   x   x    x   x  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        write_lo        = "  0   1   0   0    0   0   0   0",
                          "  x   x   x   x    x   x  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  i   i   i   i    i   i   i   i";

        write_hi        = "  0   1   0   0    1   0   0   0",
                          "  x   x   x   x    x   x  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  i   i   i   i    i   i   i   i";

	mode		= 0x04;
	delay		= 12;
	blocksize	= 128;
	readsize	= 128;
      ;
    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
    memory "fuse"
        size            = 1;
        min_write_delay = 9000;
        max_write_delay = 20000;
        read            = "0 1 0 1  1 0 0 0   x x x x  x x x x",
                          "x x x x  x x x x   o o o x  x x x o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 1  1 1 1 i",
                          "x x x x  x x x x   x x x x  x x x x";
      ;
    memory "lock"
        size            = 1;
        min_write_delay = 9000;
        max_write_delay = 20000;
        read            = "0 1 0 1  1 0 0 0   x x x x  x x x x",
                          "x x x x  x x x x   o o o x  x x x o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 1  1 i i 1",
                          "x x x x  x x x x   x x x x  x x x x";
      ;
  ;


#------------------------------------------------------------
# AT90s4433
#------------------------------------------------------------

part
    id               = "4433";
    desc             = "AT90S4433";
    stk500_devcode   = 0x51;
    avr910_devcode   = 0x30;
    signature        = 0x1e 0x92 0x03;
    chip_erase_delay = 20000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 0;
    togglevtg           = 0;
    poweroffdelay       = 0;
    resetdelayms        = 0;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 15;
    chiperasepolltimeout = 0;
    programfusepulsewidth = 2;
    programfusepolltimeout = 0;
    programlockpulsewidth = 0;
    programlockpolltimeout = 1;

    memory "eeprom"
        size            = 256;
        min_write_delay = 9000;
        max_write_delay = 20000;
        readback_p1     = 0x00;
        readback_p2     = 0xff;
        read            = " 1  0  1  0   0  0  0  0   x x x x  x x x x", 
                          "a7 a6 a5 a4  a3 a2 a1 a0   o o o o  o o o o";

        write           = " 1  1  0  0   0  0  0  0   x x x x  x x x x",
                          "a7 a6 a5 a4  a3 a2 a1 a0   i i i i  i i i i";

	mode		= 0x04;
	delay		= 12;
	blocksize	= 128;
	readsize	= 256;
      ;
    memory "flash"
        size            = 4096;
        min_write_delay = 9000;
        max_write_delay = 20000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0    0   0   0   0",
                          "  x   x   x   x    x a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        read_hi         = "  0   0   1   0    1   0   0   0",
                          "  x   x   x   x    x a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        write_lo        = "  0   1   0   0    0   0   0   0",
                          "  x   x   x   x    x a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  i   i   i   i    i   i   i   i";

        write_hi        = "  0   1   0   0    1   0   0   0",
                          "  x   x   x   x    x a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  i   i   i   i    i   i   i   i";

	mode		= 0x04;
	delay		= 12;
	blocksize	= 128;
	readsize	= 256;
      ;
    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
    memory "fuse"
        size            = 1;
        min_write_delay = 9000;
        max_write_delay = 20000;
        pwroff_after_write = yes;
        read            = "0 1 0 1  0 0 0 0   x x x x  x x x x",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 i  i i i i",
                          "x x x x  x x x x   x x x x  x x x x";
      ;
    memory "lock"
        size            = 1;
        min_write_delay = 9000;
        max_write_delay = 20000;
        read            = "0 1 0 1  1 0 0 0   x x x x  x x x x",
                          "x x x x  x x x x   x x x x  x o o x";

        write           = "1 0 1 0  1 1 0 0   1 1 1 1  1 i i 1",
                          "x x x x  x x x x   x x x x  x x x x";
      ;
  ;

#------------------------------------------------------------
# AT90s4434
#------------------------------------------------------------

part
    id               = "4434";
##### WARNING: No XML file for device 'AT90S4434'! #####
    desc             = "AT90S4434";
    stk500_devcode   = 0x52;
    avr910_devcode   = 0x6c;
    signature        = 0x1e 0x92 0x02;
    chip_erase_delay = 20000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";

    memory "eeprom"
        size            = 256;
        min_write_delay = 9000;
        max_write_delay = 20000;
        readback_p1     = 0x00;
        readback_p2     = 0xff;
        read            = " 1  0  1  0   0  0  0  0   x x x x  x x x x", 
                          "a7 a6 a5 a4  a3 a2 a1 a0   o o o o  o o o o";

        write           = " 1  1  0  0   0  0  0  0   x x x x  x x x x",
                          "a7 a6 a5 a4  a3 a2 a1 a0   i i i i  i i i i";
      ;
    memory "flash"
        size            = 4096;
        min_write_delay = 9000;
        max_write_delay = 20000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0    0   0   0   0",
                          "  x   x   x   x    x a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        read_hi         = "  0   0   1   0    1   0   0   0",
                          "  x   x   x   x    x a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        write_lo        = "  0   1   0   0    0   0   0   0",
                          "  x   x   x   x    x a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  i   i   i   i    i   i   i   i";

        write_hi        = "  0   1   0   0    1   0   0   0",
                          "  x   x   x   x    x a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  i   i   i   i    i   i   i   i";
      ;
    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
    memory "fuse"
        size            = 1;
        min_write_delay = 9000;
        max_write_delay = 20000;
        read            = "0 1 0 1  0 0 0 0   x x x x  x x x x",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 i  i i i i",
                          "x x x x  x x x x   x x x x  x x x x";
      ;
    memory "lock"
        size            = 1;
        min_write_delay = 9000;
        max_write_delay = 20000;
        read            = "0 1 0 1  1 0 0 0   x x x x  x x x x",
                          "x x x x  x x x x   x x x x  x o o x";

        write           = "1 0 1 0  1 1 0 0   1 1 1 1  1 i i 1",
                          "x x x x  x x x x   x x x x  x x x x";
      ;
  ;

#------------------------------------------------------------
# AT90s8515
#------------------------------------------------------------

part
    id               = "8515";
    desc             = "AT90S8515";
    stk500_devcode   = 0x60;
    avr910_devcode   = 0x38;
    signature        = 0x1e 0x93 0x01;
    chip_erase_delay = 20000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
	0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
	0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
	0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
	0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 0;
    togglevtg           = 0;
    poweroffdelay       = 0;
    resetdelayms        = 0;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    resetdelay          = 15;
    chiperasepulsewidth = 15;
    chiperasepolltimeout = 0;
    programfusepulsewidth = 2;
    programfusepolltimeout = 0;
    programlockpulsewidth = 0;
    programlockpolltimeout = 1;

    memory "eeprom"
        size            = 512;
        min_write_delay = 4000;
        max_write_delay = 9000;
        readback_p1     = 0x80;
        readback_p2     = 0x7f;
        read            = " 1  0  1  0   0  0  0  0  x x x x  x x x a8", 
                          "a7 a6 a5 a4 a3 a2 a1 a0   o o o o  o o o o";

        write           = " 1  1  0  0   0  0  0  0   x x x x  x x x a8",
                          "a7 a6 a5 a4  a3 a2 a1 a0   i i i i  i i i i";

	mode		= 0x04;
	delay		= 12;
	blocksize	= 128;
	readsize	= 256;
      ;
    memory "flash"
        size            = 8192;
        min_write_delay = 4000;
        max_write_delay = 9000;
        readback_p1     = 0x7f;
        readback_p2     = 0x7f;
        read_lo         = "  0   0   1   0    0   0   0   0",
                          "  x   x   x   x  a11 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        read_hi         = "  0   0   1   0    1   0   0   0",
                          "  x   x   x   x  a11 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        write_lo        = "  0   1   0   0    0   0   0   0",
                          "  x   x   x   x  a11 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  i   i   i   i    i   i   i   i";

        write_hi        = "  0   1   0   0    1   0   0   0",
                          "  x   x   x   x  a11 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  i   i   i   i    i   i   i   i";

	mode		= 0x04;
	delay		= 12;
	blocksize	= 128;
	readsize	= 256;
      ;
    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
    memory "fuse"
	size		= 1;
      ;
    memory "lock"
	size		= 1;
	write		= "1  0  1  0   1  1  0  0   1  1  1  1   1  i  i  1",
			  "x  x  x  x   x  x  x  x   x  x  x  x   x  x  x  x";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;
  ;

#------------------------------------------------------------
# AT90s8535
#------------------------------------------------------------

part
    id               = "8535";
    desc             = "AT90S8535";
    stk500_devcode   = 0x61;
    avr910_devcode   = 0x68;
    signature        = 0x1e 0x93 0x03;
    chip_erase_delay = 20000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 0;
    togglevtg           = 0;
    poweroffdelay       = 0;
    resetdelayms        = 0;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 15;
    chiperasepolltimeout = 0;
    programfusepulsewidth = 2;
    programfusepolltimeout = 0;
    programlockpulsewidth = 0;
    programlockpolltimeout = 1;

    memory "eeprom"
        size            = 512;
        min_write_delay = 9000;
        max_write_delay = 20000;
        readback_p1     = 0x00;
        readback_p2     = 0xff;
        read            = " 1  0  1  0   0  0  0  0   x x x x  x x x a8", 
                          "a7 a6 a5 a4  a3 a2 a1 a0   o o o o  o o o o";

        write           = " 1  1  0  0   0  0  0  0   x x x x  x x x a8",
                          "a7 a6 a5 a4  a3 a2 a1 a0   i i i i  i i i i";

	mode		= 0x04;
	delay		= 12;
	blocksize	= 128;
	readsize	= 256;
      ;
    memory "flash"
        size            = 8192;
        min_write_delay = 9000;
        max_write_delay = 20000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0    0   0   0   0",
                          "  x   x   x   x  a11 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        read_hi         = "  0   0   1   0    1   0   0   0",
                          "  x   x   x   x  a11 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        write_lo        = "  0   1   0   0    0   0   0   0",
                          "  x   x   x   x  a11 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  i   i   i   i    i   i   i   i";

        write_hi        = "  0   1   0   0    1   0   0   0",
                          "  x   x   x   x  a11 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  i   i   i   i    i   i   i   i";

	mode		= 0x04;
	delay		= 12;
	blocksize	= 128;
	readsize	= 256;
      ;
    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
    memory "fuse"
	size		= 1;
	read		= "0  1  0  1   1  0  0  0   x  x  x  x   x  x  x  x",
			  "x  x  x  x   x  x  x  x   x  x  x  x   x  x  x  o";
	write		= "1  0  1  0   1  1  0  0   1  0  1  1   1  1  1  i",
			  "x  x  x  x   x  x  x  x   x  x  x  x   x  x  x  x";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;
    memory "lock"
	size		= 1;
	read		= "0  1  0  1   1  0  0  0   x  x  x  x   x  x  x  x",
			  "x  x  x  x   x  x  x  x   o  o  x  x   x  x  x  x";
	write		= "1  0  1  0   1  1  0  0   1  1  1  1   1  i  i  1",
			  "x  x  x  x   x  x  x  x   x  x  x  x   x  x  x  x";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;
  ;

#------------------------------------------------------------
# ATmega103
#------------------------------------------------------------

part
    id               = "m103";
    desc             = "ATMEGA103";
    stk500_devcode   = 0xB1;
    avr910_devcode   = 0x41;
    signature        = 0x1e 0x97 0x01;
    chip_erase_delay = 112000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
        0x0E, 0x1E, 0x8E, 0x9E, 0x2E, 0x3E, 0xAE, 0xBE,
        0x4E, 0x5E, 0xCE, 0xDE, 0x6E, 0x7E, 0xEE, 0xDE,
        0x66, 0x76, 0xE6, 0xF6, 0x6A, 0x7A, 0xEA, 0x7A,
        0x7F, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 0;
    togglevtg           = 0;
    poweroffdelay       = 0;
    resetdelayms        = 0;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 15;
    chiperasepolltimeout = 0;
    programfusepulsewidth = 2;
    programfusepolltimeout = 0;
    programlockpulsewidth = 0;
    programlockpolltimeout = 10;

    memory "eeprom"
        size            = 4096;
        min_write_delay = 4000;
        max_write_delay = 9000;
        readback_p1     = 0x80;
        readback_p2     = 0x7f;
	read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	mode		= 0x04;
	delay		= 12;
	blocksize	= 64;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 131072;
        page_size       = 256;
        num_pages       = 512;
        min_write_delay = 22000;
        max_write_delay = 56000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7   x   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x11;
	delay		= 70;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "fuse"
        size            = 1;
        read            = "0 1 0 1  0 0 0 0  x x x x  x x x x",
                          "x x x x  x x x x  x x o x  o 1 o o";

        write           = "1 0 1 0  1 1 0 0  1 0 1 1  i 1 i i",
                          "x x x x  x x x x  x x x x  x x x x";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   x x x x  x x x x",
                          "x x x x  x x x x   x x x x  x o o x";

        write           = "1 0 1 0  1 1 0 0   1 1 1 1  1 i i 1",
                          "x x x x  x x x x   x x x x  x x x x";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;


#------------------------------------------------------------
# ATmega64
#------------------------------------------------------------

part
    id               = "m64";
    desc             = "ATMEGA64";
    has_jtag         = yes;
    stk500_devcode   = 0xA0;
    avr910_devcode   = 0x45;
    signature        = 0x1e 0x96 0x02;
    chip_erase_delay = 9000;
    pagel            = 0xD7;
    bs2              = 0xA0;
    reset            = dedicated;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 6;
    togglevtg           = 0;
    poweroffdelay       = 0;
    resetdelayms        = 0;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x22;
    spmcr               = 0x68;
    allowfullpagebitstream = yes;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 2048;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	mode		= 0x04;
	delay		= 20;
	blocksize	= 64;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 65536;
        page_size       = 256;
        num_pages       = 256;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "  x a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "  x a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";


        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  x a14 a13 a12    a11 a10  a9  a8",
                          " a7   x   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x21;
	delay		= 6;
	blocksize	= 128;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  x x x x  x x i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "calibration"
        size            = 4;
        read            = "0 0 1 1  1 0 0 0    x x x x  x x x x",
                          "0 0 0 0  0 0 a1 a0  o o o o  o o o o";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;




#------------------------------------------------------------
# ATmega128
#------------------------------------------------------------

part
    id               = "m128";
    desc             = "ATMEGA128";
    has_jtag         = yes;
    stk500_devcode   = 0xB2;
    avr910_devcode   = 0x43;
    signature        = 0x1e 0x97 0x02;
    chip_erase_delay = 9000;
    pagel            = 0xD7;
    bs2              = 0xA0;
    reset            = dedicated;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 6;
    togglevtg           = 0;
    poweroffdelay       = 0;
    resetdelayms        = 0;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x22;
    spmcr               = 0x68;
    rampz               = 0x3b;
    allowfullpagebitstream = yes;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 4096;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	mode		= 0x04;
	delay		= 12;
	blocksize	= 64;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 131072;
        page_size       = 256;
        num_pages       = 512;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7   x   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x21;
	delay		= 6;
	blocksize	= 128;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  x x x x  x x i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "calibration"
        size            = 4;
        read            = "0 0 1 1  1 0 0 0    x x x x  x x x x",
                          "0 0 0 0  0 0 a1 a0  o o o o  o o o o";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;

#------------------------------------------------------------
# AT90CAN128
#------------------------------------------------------------

part
    id               = "c128";
    desc             = "AT90CAN128";
    has_jtag         = yes;
    stk500_devcode   = 0xB3;
#    avr910_devcode   = 0x43;
    signature        = 0x1e 0x97 0x81;
    chip_erase_delay = 9000;
    pagel            = 0xD7;
    bs2              = 0xA0;
    reset            = dedicated;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 6;
    togglevtg           = 0;
    poweroffdelay       = 0;
    resetdelayms        = 0;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    rampz               = 0x3b;
    eecr                = 0x3f;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 4096;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   0   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   0   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0  a2  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x    a11 a10  a9  a8",
			  " a7  a6  a5  a4     a3   0   0   0",
			  "  x   x   x   x      x   x   x   x";


	mode		= 0x41;
	delay		= 20;
	blocksize	= 8;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 131072;
        page_size       = 256;
        num_pages       = 512;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  0   0   0   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  0   0   0   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7   x   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  x x x x  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0  0 0 0 x  x x x x",
                          "0 0 0 0  0 0 0 0  o o o o  o o o o";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;

#------------------------------------------------------------
# AT90CAN64
#------------------------------------------------------------

part
    id               = "c64";
    desc             = "AT90CAN64";
    has_jtag         = yes;
    stk500_devcode   = 0xB3;
#    avr910_devcode   = 0x43;
    signature        = 0x1e 0x96 0x81;
    chip_erase_delay = 9000;
    pagel            = 0xD7;
    bs2              = 0xA0;
    reset            = dedicated;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 6;
    togglevtg           = 0;
    poweroffdelay       = 0;
    resetdelayms        = 0;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    rampz               = 0x3b;
    eecr                = 0x3f;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 2048;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   0   x      x a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   0   x      x a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0  a2  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x a10  a9  a8",
			  " a7  a6  a5  a4     a3   0   0   0",
			  "  x   x   x   x      x   x   x   x";


	mode		= 0x41;
	delay		= 20;
	blocksize	= 8;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 65536;
        page_size       = 256;
        num_pages       = 256;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  0   0   0   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  0   0   0   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7   x   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  x x x x  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0  0 0 0 x  x x x x",
                          "0 0 0 0  0 0 0 0  o o o o  o o o o";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;

#------------------------------------------------------------
# AT90CAN32
#------------------------------------------------------------

part
    id               = "c32";
    desc             = "AT90CAN32";
    has_jtag         = yes;
    stk500_devcode   = 0xB3;
#    avr910_devcode   = 0x43;
    signature        = 0x1e 0x95 0x81;
    chip_erase_delay = 9000;
    pagel            = 0xD7;
    bs2              = 0xA0;
    reset            = dedicated;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 6;
    togglevtg           = 0;
    poweroffdelay       = 0;
    resetdelayms        = 0;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    rampz               = 0x3b;
    eecr                = 0x3f;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 1024;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   0   x      x   x  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   0   x      x   x  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0  a2  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x  a9  a8",
			  " a7  a6  a5  a4     a3   0   0   0",
			  "  x   x   x   x      x   x   x   x";


	mode		= 0x41;
	delay		= 20;
	blocksize	= 8;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 32768;
        page_size       = 256;
        num_pages       = 128;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  0   0   0   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  0   0   0   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7   x   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  x x x x  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0  0 0 0 x  x x x x",
                          "0 0 0 0  0 0 0 0  o o o o  o o o o";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;


#------------------------------------------------------------
# ATmega16
#------------------------------------------------------------

part
    id               = "m16";
    desc             = "ATMEGA16";
    has_jtag         = yes;
    stk500_devcode   = 0x82;
    avr910_devcode   = 0x74;
    signature        = 0x1e 0x94 0x03;
    pagel            = 0xd7;
    bs2              = 0xa0;
    chip_erase_delay = 9000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
	0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
	0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
	0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
	0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 100;
    latchcycles         = 6;
    togglevtg           = 0;
    poweroffdelay       = 0;
    resetdelayms        = 0;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    resetdelay          = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    allowfullpagebitstream = yes;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 4;  /* for parallel programming */
        size            = 512;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   x   x      x   x  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   x   x      x   x  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x  a9  a8",
			  " a7  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x04;
	delay		= 10;
	blocksize	= 128;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 16384;
        page_size       = 128;
        num_pages       = 128;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "  0   0 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "  0   0 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  0   0   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  0   0   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  0   0 a13 a12    a11 a10  a9  a8",
                          " a7  a6   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x21;
	delay		= 6;
	blocksize	= 128;
	readsize	= 256;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lfuse"
        size            = 1;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;
    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
    memory "calibration"
        size            = 4;

        read            = "0 0 1 1  1 0 0 0   0 0 0 x  x x x x",
                          "0 0 0 0  0 0 a1 a0 o o o o  o o o o";
        ;
  ;


#------------------------------------------------------------
# ATmega164P
#------------------------------------------------------------

# close to ATmega16

part
    id               = "m164p";
    desc             = "ATMEGA164P";
    has_jtag         = yes;
    stk500_devcode   = 0x82; # no STK500v1 support, use the ATmega16 one
    avr910_devcode   = 0x74;
    signature        = 0x1e 0x94 0x0a;
    pagel            = 0xd7;
    bs2              = 0xa0;
    chip_erase_delay = 9000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 4;  /* for parallel programming */
        size            = 512;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   x   x      x   x  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   x   x      x   x  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x  a9  a8",
			  " a7  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 128;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 16384;
        page_size       = 128;
        num_pages       = 128;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "  0   0 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "  0   0 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  0   0   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  0   0   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  0   0 a13 a12    a11 a10  a9  a8",
                          " a7  a6   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x21;
	delay		= 6;
	blocksize	= 128;
	readsize	= 256;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lfuse"
        size            = 1;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  1 1 1 1  1 i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;

    memory "calibration"
        size            = 1;

        read            = "0 0 1 1  1 0 0 0   0 0 0 x  x x x x",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";
        ;
  ;


#------------------------------------------------------------
# ATmega324P
#------------------------------------------------------------

# similar to ATmega164P

part
    id               = "m324p";
    desc             = "ATMEGA324P";
    has_jtag         = yes;
    stk500_devcode   = 0x82; # no STK500v1 support, use the ATmega16 one
    avr910_devcode   = 0x74;
    signature        = 0x1e 0x95 0x08;
    pagel            = 0xd7;
    bs2              = 0xa0;
    chip_erase_delay = 9000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 4;  /* for parallel programming */
        size            = 1024;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   x   x      x a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   x   x      x a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x a10  a9  a8",
			  " a7  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 128;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 32768;
        page_size       = 128;
        num_pages       = 256;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "  0 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "  0 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  0   0   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  0   0   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  0 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x21;
	delay		= 6;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lfuse"
        size            = 1;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  1 1 1 1  1 i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;

    memory "calibration"
        size            = 1;

        read            = "0 0 1 1  1 0 0 0   0 0 0 x  x x x x",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";
        ;
  ;


#------------------------------------------------------------
# ATmega644
#------------------------------------------------------------

# similar to ATmega164

part
    id               = "m644";
    desc             = "ATMEGA644";
    has_jtag         = yes;
    stk500_devcode   = 0x82; # no STK500v1 support, use the ATmega16 one
    avr910_devcode   = 0x74;
    signature        = 0x1e 0x96 0x09;
    pagel            = 0xd7;
    bs2              = 0xa0;
    chip_erase_delay = 9000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x02;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 6;
    togglevtg           = 0;
    poweroffdelay       = 0;
    resetdelayms        = 0;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 2048;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0  a2  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x    a11 a10  a9  a8",
			  " a7  a6  a5  a4     a3   0   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 128;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 65536;
        page_size       = 256;
        num_pages       = 256;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  0   0   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  0   0   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7   x   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x21;
	delay		= 6;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lfuse"
        size            = 1;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  1 1 1 1  1 i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;

    memory "calibration"
        size            = 1;

        read            = "0 0 1 1  1 0 0 0   0 0 0 x  x x x x",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";
        ;
  ;

#------------------------------------------------------------
# ATmega644P
#------------------------------------------------------------

# similar to ATmega164p

part
    id               = "m644p";
    desc             = "ATMEGA644P";
    has_jtag         = yes;
    stk500_devcode   = 0x82; # no STK500v1 support, use the ATmega16 one
    avr910_devcode   = 0x74;
    signature        = 0x1e 0x96 0x0a;
    pagel            = 0xd7;
    bs2              = 0xa0;
    chip_erase_delay = 9000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x02;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 6;
    togglevtg           = 0;
    poweroffdelay       = 0;
    resetdelayms        = 0;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 2048;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0  a2  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x    a11 a10  a9  a8",
			  " a7  a6  a5  a4     a3   0   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 128;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 65536;
        page_size       = 256;
        num_pages       = 256;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  0   0   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  0   0   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7   x   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x21;
	delay		= 6;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lfuse"
        size            = 1;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  1 1 1 1  1 i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;

    memory "calibration"
        size            = 1;

        read            = "0 0 1 1  1 0 0 0   0 0 0 x  x x x x",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";
        ;
  ;



#------------------------------------------------------------
# ATmega1284P
#------------------------------------------------------------

# similar to ATmega164p

part
    id               = "m1284p";
    desc             = "ATMEGA1284P";
    has_jtag         = yes;
    stk500_devcode   = 0x82; # no STK500v1 support, use the ATmega16 one
    avr910_devcode   = 0x74;
    signature        = 0x1e 0x97 0x05;
    pagel            = 0xd7;
    bs2              = 0xa0;
    chip_erase_delay = 9000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x02;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 6;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 4096;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0  a2  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x    a11 a10  a9  a8",
			  " a7  a6  a5  a4     a3   0   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 128;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 131072;
        page_size       = 256;
        num_pages       = 512;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  0   0   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  0   0   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7   x   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lfuse"
        size            = 1;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  1 1 1 1  1 i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;

    memory "calibration"
        size            = 1;

        read            = "0 0 1 1  1 0 0 0   0 0 0 x  x x x x",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";
        ;
  ;



#------------------------------------------------------------
# ATmega162
#------------------------------------------------------------

part
    id               = "m162";
    desc             = "ATMEGA162";
    has_jtag         = yes;
    stk500_devcode   = 0x83;
    avr910_devcode   = 0x63;
    signature        = 0x1e 0x94 0x04;
    chip_erase_delay = 9000;
    pagel            = 0xd7;
    bs2              = 0xa0;

    idr              = 0x04;
    spmcr            = 0x57;
    allowfullpagebitstream = yes;

    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                       "x x x x  x x x x    x x x x  x x x x";

    memory "flash"
        paged           = yes;
        size            = 16384;
        page_size       = 128;
        num_pages       = 128;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;

        read_lo         = "  0   0   1   0      0   0   0   0",
                          "  0   0 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "  0   0 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  0   0   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  0   0   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  0   0 a13 a12    a11 a10  a9  a8",
                          " a7  a6   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";
       mode        = 0x41;
    delay       = 10;
    blocksize   = 128;
    readsize    = 256;  

        ;

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 6;
    togglevtg           = 0;
    poweroffdelay       = 0;
    resetdelayms        = 0;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 4;  /* for parallel programming */
        size            = 512;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;

                read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   x   x      x   x  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

                write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   x   x      x   x  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x  a9  a8",
			  " a7  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 20;
	blocksize	= 4;
	readsize	= 256;
        ;

    memory "lfuse"
        size            = 1;
        min_write_delay = 16000;
        max_write_delay = 16000;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
        ;

    memory "hfuse"
        size            = 1;
        min_write_delay = 16000;
        max_write_delay = 16000;

        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
        ;

    memory "efuse"
        size            = 1;
        min_write_delay = 16000;
        max_write_delay = 16000;

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  1 1 1 1  1 i i i";
      ;

    memory "lock"
        size            = 1;
        min_write_delay = 16000;
        max_write_delay = 16000;

        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        ;

    memory "signature"
        size            = 3;

        read            = "0  0  1  1   0  0  0  0   0  0  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
        ;

    memory "calibration"
        size            = 1;

        read            = "0 0 1 1  1 0 0 0   0 0 x x  x x x x",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";
        ;
;



#------------------------------------------------------------
# ATmega163
#------------------------------------------------------------

part
    id               = "m163";
    desc             = "ATMEGA163";
    stk500_devcode   = 0x81;
    avr910_devcode   = 0x64;
    signature        = 0x1e 0x94 0x02;
    chip_erase_delay = 32000;
    pagel            = 0xd7;
    bs2              = 0xa0;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout             = 200;
    stabdelay           = 100;
    cmdexedelay         = 25;
    synchloops          = 32;
    bytedelay           = 0;
    pollindex           = 3;
    pollvalue           = 0x53;
    predelay            = 1;
    postdelay           = 1;
    pollmethod          = 0;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 0;
    togglevtg           = 0;
    poweroffdelay       = 0;
    resetdelayms        = 0;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 30;
    programfusepulsewidth = 0;
    programfusepolltimeout = 2;
    programlockpulsewidth = 0;
    programlockpolltimeout = 2;


   memory "eeprom"
        size            = 512;
        min_write_delay = 4000;
        max_write_delay = 4000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x      x   x   x  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";
        mode            = 0x41;
        delay           = 20;
        blocksize       = 4;
        readsize        = 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 16384;
        page_size       = 128;
        num_pages       = 128;
        min_write_delay = 16000;
        max_write_delay = 16000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "  x   x   x a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "  x   x   x a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  x   x   x a12    a11 a10  a9  a8",
                          " a7  a6   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x11;
	delay		= 20;
	blocksize	= 128;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        min_write_delay = 2000;
        max_write_delay = 2000;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   o o x x  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "x x x x  x x x x   i i 1 1  i i i i";
      ;

    memory "hfuse"
        size            = 1;
        min_write_delay = 2000;
        max_write_delay = 2000;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   x x x x  1 o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "x x x x  x x x x   1 1 1 1  1 i i i";
      ;

    memory "lock"
        size            = 1;
        min_write_delay = 2000;
        max_write_delay = 2000;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  0 x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0   x x x x  x x x x",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";
      ;
  ;

#------------------------------------------------------------
# ATmega169
#------------------------------------------------------------

part
    id               = "m169";
    desc             = "ATMEGA169";
    has_jtag         = yes;
    stk500_devcode   = 0x85;
    avr910_devcode   = 0x78;
    signature        = 0x1e 0x94 0x05;
    chip_erase_delay = 9000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";
    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;

   memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 4;  /* for parallel programming */
        size            = 512;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x      x   x   x  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x   x  a8",
			  " a7  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 20;
	blocksize	= 4;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 16384;
        page_size       = 128;
        num_pages       = 128;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "  x   x   x a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "  x   x   x a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  x   x   x a12    a11 a10  a9  a8",
                          " a7  a6   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 128;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        min_write_delay = 2000;
        max_write_delay = 2000;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "hfuse"
        size            = 1;
        min_write_delay = 2000;
        max_write_delay = 2000;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "efuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  x x x x  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
      ;

    memory "lock"
        size            = 1;
        min_write_delay = 2000;
        max_write_delay = 2000;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   0  0  0  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0   0 0 0 x  x x x x",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";
      ;
  ;

#------------------------------------------------------------
# ATmega329
#------------------------------------------------------------

part
    id               = "m329";
    desc             = "ATMEGA329";
    has_jtag         = yes;
#    stk500_devcode   = 0x85; # no STK500 support, only STK500v2
#    avr910_devcode   = 0x?;  # try the ATmega169 one:
    avr910_devcode   = 0x75;
    signature        = 0x1e 0x95 0x03;
    chip_erase_delay = 9000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";
    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;

   memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 4;  /* for parallel programming */
        size            = 1024;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x      x   x  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x  a9  a8",
			  " a7  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 20;
	blocksize	= 8;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 32768;
        page_size       = 128;
        num_pages       = 256;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "  x a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "  x a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  x   x   x a12    a11 a10  a9  a8",
                          " a7  a6   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "hfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "efuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 1 0 0",
                          "x x x x  x x x x   x x x x  x i i i";
      ;

    memory "lock"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   0  0  0  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0   0 0 0 x  x x x x",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";
      ;
  ;

#------------------------------------------------------------
# ATmega329P
#------------------------------------------------------------
# Identical to ATmega329 except of the signature

part
    id               = "m329p";
    desc             = "ATMEGA329P";
    has_jtag         = yes;
#    stk500_devcode   = 0x85; # no STK500 support, only STK500v2
#    avr910_devcode   = 0x?;  # try the ATmega169 one:
    avr910_devcode   = 0x75;
    signature        = 0x1e 0x95 0x0b;
    chip_erase_delay = 9000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";
    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;

   memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 4;  /* for parallel programming */
        size            = 1024;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x      x   x  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x  a9  a8",
			  " a7  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 20;
	blocksize	= 8;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 32768;
        page_size       = 128;
        num_pages       = 256;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "  x a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "  x a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  x   x   x a12    a11 a10  a9  a8",
                          " a7  a6   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "hfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "efuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 1 0 0",
                          "x x x x  x x x x   x x x x  x i i i";
      ;

    memory "lock"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   0  0  0  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0   0 0 0 x  x x x x",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";
      ;
  ;

#------------------------------------------------------------
# ATmega3290
#------------------------------------------------------------

# identical to ATmega329

part
    id               = "m3290";
    desc             = "ATMEGA3290";
    has_jtag         = yes;
#    stk500_devcode   = 0x85; # no STK500 support, only STK500v2
#    avr910_devcode   = 0x?;  # try the ATmega169 one:
    avr910_devcode   = 0x75;
    signature        = 0x1e 0x95 0x04;
    chip_erase_delay = 9000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";
    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;

   memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 4;  /* for parallel programming */
        size            = 1024;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x      x   x  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x  a9  a8",
			  " a7  a6  a5  a4     a3  a3   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 20;
	blocksize	= 8;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 32768;
        page_size       = 128;
        num_pages       = 256;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "  x a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "  x a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  x   x   x a12    a11 a10  a9  a8",
                          " a7  a6   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "hfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "efuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 1 0 0",
                          "x x x x  x x x x   x x x x  x i i i";
      ;

    memory "lock"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   0  0  0  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0   0 0 0 x  x x x x",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";
      ;
  ;

#------------------------------------------------------------
# ATmega3290P
#------------------------------------------------------------

# identical to ATmega3290 except of the signature

part
    id               = "m3290p";
    desc             = "ATMEGA3290P";
    has_jtag         = yes;
#    stk500_devcode   = 0x85; # no STK500 support, only STK500v2
#    avr910_devcode   = 0x?;  # try the ATmega169 one:
    avr910_devcode   = 0x75;
    signature        = 0x1e 0x95 0x0c;
    chip_erase_delay = 9000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";
    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;

   memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 4;  /* for parallel programming */
        size            = 1024;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x      x   x  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x  a9  a8",
			  " a7  a6  a5  a4     a3  a3   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 20;
	blocksize	= 8;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 32768;
        page_size       = 128;
        num_pages       = 256;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "  x a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "  x a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  x   x   x a12    a11 a10  a9  a8",
                          " a7  a6   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "hfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "efuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 1 0 0",
                          "x x x x  x x x x   x x x x  x i i i";
      ;

    memory "lock"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   0  0  0  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0   0 0 0 x  x x x x",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";
      ;
  ;

#------------------------------------------------------------
# ATmega649
#------------------------------------------------------------

part
    id               = "m649";
    desc             = "ATMEGA649";
    has_jtag         = yes;
#    stk500_devcode   = 0x85; # no STK500 support, only STK500v2
#    avr910_devcode   = 0x?;  # try the ATmega169 one:
    avr910_devcode   = 0x75;
    signature        = 0x1e 0x96 0x03;
    chip_erase_delay = 9000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";
    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;

   memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 2048;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x      x a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x      x a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0  a2  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x a10  a9  a8",
			  " a7  a6  a5  a4     a3   0   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 20;
	blocksize	= 8;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 65536;
        page_size       = 256;
        num_pages       = 256;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  x   x   x a12    a11 a10  a9  a8",
                          " a7   x   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "hfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "efuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 1 0 0",
                          "x x x x  x x x x   x x x x  x i i i";
      ;

    memory "lock"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   0  0  0  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0   0 0 0 x  x x x x",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";
      ;
  ;

#------------------------------------------------------------
# ATmega6490
#------------------------------------------------------------

# identical to ATmega649

part
    id               = "m6490";
    desc             = "ATMEGA6490";
    has_jtag         = yes;
#    stk500_devcode   = 0x85; # no STK500 support, only STK500v2
#    avr910_devcode   = 0x?;  # try the ATmega169 one:
    avr910_devcode   = 0x75;
    signature        = 0x1e 0x96 0x04;
    chip_erase_delay = 9000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";
    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;

   memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 2048;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x      x a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x      x a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0  a2  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x   x  a8",
			  " a7  a6  a5  a4     a3   0   0   0",
			  "  x   x   x   x      x   x   x   x";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0  a2  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x a10  a9  a8",
			  " a7  a6  a5  a4     a3   0   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 20;
	blocksize	= 8;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 65536;
        page_size       = 256;
        num_pages       = 256;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  x   x   x a12    a11 a10  a9  a8",
                          " a7   x   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "hfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "efuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 1 0 0",
                          "x x x x  x x x x   x x x x  x i i i";
      ;

    memory "lock"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   0  0  0  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0   0 0 0 x  x x x x",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";
      ;
  ;

#------------------------------------------------------------
# ATmega32
#------------------------------------------------------------

part
    id               = "m32";
    desc             = "ATMEGA32";
    has_jtag         = yes;
    stk500_devcode   = 0x91;
    avr910_devcode   = 0x72;
    signature        = 0x1e 0x95 0x02;
    chip_erase_delay = 9000;
    pagel            = 0xd7;
    bs2              = 0xa0;
    reset            = dedicated;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";
    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 6;
    togglevtg           = 0;
    poweroffdelay       = 0;
    resetdelayms        = 0;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    allowfullpagebitstream = yes;

   memory "eeprom"
        paged           = no;   /* leave this "no" */
        page_size       = 4;    /* for parallel programming */
        size            = 1024;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   x   x      x   x  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   x   x      x   x  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x  a9  a8",
			  " a7  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x04;
	delay		= 10;
	blocksize	= 64;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 32768;
        page_size       = 128;
        num_pages       = 256;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "  0   0 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "  0   0 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  0   0   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  0   0   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  0   0 a13 a12    a11 a10  a9  a8",
                          " a7  a6   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x21;
	delay		= 6;
	blocksize	= 64;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        min_write_delay = 2000;
        max_write_delay = 2000;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "hfuse"
        size            = 1;
        min_write_delay = 2000;
        max_write_delay = 2000;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "lock"
        size            = 1;
        min_write_delay = 2000;
        max_write_delay = 2000;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o o";
      ;

    memory "calibration"
        size            = 4;
        read            = "0 0 1 1  1 0 0 0    0 0 x x  x x x x",
                          "0 0 0 0  0 0 a1 a0  o o o o  o o o o";
      ;
  ;

#------------------------------------------------------------
# ATmega161
#------------------------------------------------------------

part
    id               = "m161";
    desc             = "ATMEGA161";
    stk500_devcode   = 0x80;
    avr910_devcode   = 0x60;
    signature        = 0x1e 0x94 0x01;
    chip_erase_delay = 28000;
    pagel            = 0xd7;
    bs2              = 0xa0;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";
    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 0;
    togglevtg           = 0;
    poweroffdelay       = 0;
    resetdelayms        = 0;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 30;
    programfusepulsewidth = 0;
    programfusepolltimeout = 2;
    programlockpulsewidth = 0;
    programlockpolltimeout = 2;

   memory "eeprom"
        size            = 512;
        min_write_delay = 3400;
        max_write_delay = 3400;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x      x   x   x  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

	mode		= 0x04;
	delay		= 5;
	blocksize	= 128;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 16384;
        page_size       = 128;
        num_pages       = 128;
        min_write_delay = 14000;
        max_write_delay = 14000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "  x   x   x a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "  x   x   x a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  x   x   x a12    a11 a10  a9  a8",
                          " a7  a6   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x21;
	delay		= 16;
	blocksize	= 128;
	readsize	= 256;
      ;

    memory "fuse"
        size            = 1;
        min_write_delay = 2000;
        max_write_delay = 2000;
        read            = "0 1 0 1  0 0 0 0   x x x x  x x x x",
                          "x x x x  x x x x   x o x o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 x  x x x x",
                          "x x x x  x x x x   1 i 1 i  i i i i";
      ;

    memory "lock"
        size            = 1;
        min_write_delay = 2000;
        max_write_delay = 2000;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
      ;
    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;


#------------------------------------------------------------
# ATmega8
#------------------------------------------------------------

part
    id               = "m8";
    desc             = "ATMEGA8";
    stk500_devcode   = 0x70;
    avr910_devcode   = 0x76;
    signature        = 0x1e 0x93 0x07;
    pagel            = 0xd7;
    bs2              = 0xc2;
    chip_erase_delay = 10000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
	0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
	0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
	0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
	0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 2;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    resetdelay          = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    memory "eeprom"
        size            = 512;
        page_size       = 4;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   x   x      x   x   x  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   x   x      x   x   x  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	mode		= 0x04;
	delay		= 20;
	blocksize	= 128;
	readsize	= 256;
      ;
    memory "flash"
        paged           = yes;
        size            = 8192;
        page_size       = 64;
        num_pages       = 128;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0x00;
        read_lo         = "  0   0   1   0    0   0   0   0",
                          "  0   0   0   0  a11 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        read_hi         = "  0   0   1   0    1   0   0   0",
                          "  0   0   0   0  a11 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  0   0   0   0      x   x   x   x",
                          "  x   x   x  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  0   0   0   0      x   x   x   x",
                          "  x   x   x  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  0   0   0   0    a11 a10  a9  a8",
                          " a7  a6  a5   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x21;
	delay		= 10;
	blocksize	= 64;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        min_write_delay = 2000;
        max_write_delay = 2000;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "hfuse"
        size            = 1;
        min_write_delay = 2000;
        max_write_delay = 2000;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "lock"
        size            = 1;
        min_write_delay = 2000;
        max_write_delay = 2000;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
      ;

    memory "calibration"
        size            = 4;
        read            = "0  0  1  1   1  0  0  0   0  0  x  x   x  x  x  x",
                          "0  0  0  0   0  0 a1 a0   o  o  o  o   o  o  o  o";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;



#------------------------------------------------------------
# ATmega8515
#------------------------------------------------------------

part
    id               = "m8515";
    desc             = "ATMEGA8515";
    stk500_devcode   = 0x63;
    avr910_devcode   = 0x3A;
    signature        = 0x1e 0x93 0x06;
    chip_erase_delay = 9000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 6;
    togglevtg           = 0;
    poweroffdelay       = 0;
    resetdelayms        = 0;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    memory "eeprom"
        size            = 512;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
 read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   x   x      x   x   x  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

 write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   x   x      x   x   x  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

	mode		= 0x04;
	delay		= 10;
	blocksize	= 128;
	readsize	= 256;
      ;
    memory "flash"
        paged           = yes;
        size            = 8192;
        page_size       = 64;
        num_pages       = 128;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0    0   0   0   0",
                          "  0   0   0   0  a11 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        read_hi         = "  0   0   1   0    1   0   0   0",
                          "  0   0   0   0  a11 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  0   0   0   0      x   x   x   x",
                          "  x   x   x  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  0   0   0   0      x   x   x   x",
                          "  x   x   x  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  0   0   0   0    a11 a10  a9  a8",
                          " a7  a6  a5   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x21;
	delay		= 6;
	blocksize	= 64;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "hfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "lock"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
      ;

    memory "calibration"
        size            = 4;
        read            = "0 0 1 1  1 0 0 0     0 0 x x  x x x x",
                          "0 0 0 0  0 0 a1 a0   o o o o  o o o o";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;




#------------------------------------------------------------
# ATmega8535
#------------------------------------------------------------

part
    id               = "m8535";
    desc             = "ATMEGA8535";
    stk500_devcode   = 0x64;
    avr910_devcode   = 0x69;
    signature        = 0x1e 0x93 0x08;
    pagel            = 0xd7;
    bs2              = 0xa0;
    chip_erase_delay = 9000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 6;
    togglevtg           = 0;
    poweroffdelay       = 0;
    resetdelayms        = 0;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    memory "eeprom"
        size            = 512;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   x   x      x   x   x  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   x   x      x   x   x  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

	mode		= 0x04;
	delay		= 10;
	blocksize	= 128;
	readsize	= 256;
      ;
    memory "flash"
        paged           = yes;
        size            = 8192;
        page_size       = 64;
        num_pages       = 128;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0    0   0   0   0",
                          "  0   0   0   0  a11 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        read_hi         = "  0   0   1   0    1   0   0   0",
                          "  0   0   0   0  a11 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  0   0   0   0      x   x   x   x",
                          "  x   x   x  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  0   0   0   0      x   x   x   x",
                          "  x   x   x  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  0   0   0   0    a11 a10  a9  a8",
                          " a7  a6  a5   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x21;
	delay		= 6;
	blocksize	= 64;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        min_write_delay = 2000;
        max_write_delay = 2000;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "hfuse"
        size            = 1;
        min_write_delay = 2000;
        max_write_delay = 2000;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "lock"
        size            = 1;
        min_write_delay = 2000;
        max_write_delay = 2000;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
      ;

    memory "calibration"
        size            = 4;
        read            = "0 0 1 1  1 0 0 0   0 0 x x  x x x x",
                          "0 0 0 0  0 0 a1 a0 o o o o  o o o o";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;


#------------------------------------------------------------
# ATtiny26
#------------------------------------------------------------

part
    id                  = "t26";
    desc                = "ATTINY26";
    stk500_devcode      = 0x21;
    avr910_devcode      = 0x5e;
    signature           = 0x1e 0x91 0x09;
    pagel               = 0xb3;
    bs2                 = 0xb2;
    chip_erase_delay    = 9000;
    pgm_enable          = "1 0 1 0  1 1 0 0   0 1 0 1  0 0 1 1",
                          "x x x x  x x x x   x x x x  x x x x";

    chip_erase          = "1 0 1 0  1 1 0 0   1 0 0 x  x x x x",
                          "x x x x  x x x x   x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
        0xC4, 0xE4, 0xC4, 0xE4, 0xCC, 0xEC, 0xCC, 0xEC,
        0xD4, 0xF4, 0xD4, 0xF4, 0xDC, 0xFC, 0xDC, 0xFC,
        0xC8, 0xE8, 0xD8, 0xF8, 0x4C, 0x6C, 0x5C, 0x7C,
        0xEC, 0xBC, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 2;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    memory "eeprom"
        size            = 128;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read            = "1  0  1  0   0  0  0  0    x x x x  x x x x",
                          "x a6 a5 a4  a3 a2 a1 a0    o o o o  o o o o";

        write           = "1  1  0  0   0  0  0  0    x x x x  x x x x",
                          "x a6 a5 a4  a3 a2 a1 a0    i i i i  i i i i";

	mode		= 0x04;
	delay		= 10;
	blocksize	= 64;
	readsize	= 256;
    ;

    memory "flash"
        paged           = yes;
        size            = 2048;
        page_size       = 32;
        num_pages       = 64;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0  0  1  0   0  0  0  0",
                          "  x  x  x  x   x  x a9 a8",
                          " a7 a6 a5 a4  a3 a2 a1 a0",
                          "  o  o  o  o   o  o  o  o";

        read_hi         = "  0  0  1  0   1  0  0  0",
                          "  x  x  x  x   x  x a9 a8",
                          " a7 a6 a5 a4  a3 a2 a1 a0",
                          "  o  o  o  o   o  o  o  o";

        loadpage_lo     = "  0  1  0  0   0  0  0  0",
                          "  x  x  x  x   x  x  x  x",
                          "  x  x  x  x  a3 a2 a1 a0",
                          "  i  i  i  i   i  i  i  i";

        loadpage_hi     = "  0  1  0  0   1  0  0  0",
                          "  x  x  x  x   x  x  x  x",
                          "  x  x  x  x  a3 a2 a1 a0",
                          "  i  i  i  i   i  i  i  i";

        writepage       = "  0  1  0  0   1  1  0  0",
                          "  x  x  x  x   x  x a9 a8",
                          " a7 a6 a5 a4   x  x  x  x",
                          "  x  x  x  x   x  x  x  x";

	mode		= 0x21;
	delay		= 6;
	blocksize	= 16;
	readsize	= 256;
    ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0    x x x x  x x x x",
                          "0  0  0  0   0  0 a1 a0    o o o o  o o o o";
    ;

    memory "lock"
        size            = 1;
        read            = "0  1  0  1   1  0  0  0    x x x x  x x x x",
                          "x  x  x  x   x  x  x  x    x x x x  x x o o";

        write           = "1  0  1  0   1  1  0  0    1 1 1 1  1 1 i i",
                          "x  x  x  x   x  x  x  x    x x x x  x x x x";
        min_write_delay = 9000;
        max_write_delay = 9000;
    ;

    memory "lfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  x x x i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  x x x o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "calibration"
        size            = 4;
        read            = "0  0  1  1   1  0  0  0    x x x x  x x x x",
                          "0  0  0  0   0  0 a1 a0    o o o o  o o o o";
    ;

;


#------------------------------------------------------------
# ATtiny261
#------------------------------------------------------------
# Close to ATtiny26

part
    id                  = "t261";
    desc                = "ATTINY261";
     has_debugwire = yes;
     flash_instr   = 0xB4, 0x00, 0x10;
     eeprom_instr  = 0xBB, 0xFF, 0xBB, 0xEE, 0xBB, 0xCC, 0xB2, 0x0D,
	             0xBC, 0x00, 0xB4, 0x00, 0xBA, 0x0D, 0xBB, 0xBC,
	             0x99, 0xE1, 0xBB, 0xAC;
#    stk500_devcode      = 0x21;
#    avr910_devcode      = 0x5e;
    signature           = 0x1e 0x91 0x0c;
    pagel               = 0xb3;
    bs2                 = 0xb2;
    chip_erase_delay    = 4000;

    pgm_enable          = "1 0 1 0  1 1 0 0   0 1 0 1  0 0 1 1",
                          "x x x x  x x x x   x x x x  x x x x";

    chip_erase          = "1 0 1 0  1 1 0 0   1 0 0 x  x x x x",
                          "x x x x  x x x x   x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
        0xC4, 0xE4, 0xC4, 0xE4, 0xCC, 0xEC, 0xCC, 0xEC,
        0xD4, 0xF4, 0xD4, 0xF4, 0xDC, 0xFC, 0xDC, 0xFC,
        0xC8, 0xE8, 0xD8, 0xF8, 0x4C, 0x6C, 0x5C, 0x7C,
        0xEC, 0xBC, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 2;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    memory "eeprom"
        paged           = no;
        size            = 128;
        page_size       = 4;
        num_pages       = 32;
        min_write_delay = 4000;
        max_write_delay = 4000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;

        read            = "1  0  1  0   0  0  0  0    x x x x  x x x x",
                          "x a6 a5 a4  a3 a2 a1 a0    o o o o  o o o o";

        write           = "1  1  0  0   0  0  0  0    x x x x  x x x x",
                          "x a6 a5 a4  a3 a2 a1 a0    i i i i  i i i i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x   x   x",
			  "  x  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 4;
	readsize	= 256;
    ;

    memory "flash"
        paged           = yes;
        size            = 2048;
        page_size       = 32;
        num_pages       = 64;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;

        read_lo         = "  0  0  1  0   0  0  0  0",
                          "  x  x  x  x   x  x a9 a8",
                          " a7 a6 a5 a4  a3 a2 a1 a0",
                          "  o  o  o  o   o  o  o  o";

        read_hi         = "  0  0  1  0   1  0  0  0",
                          "  x  x  x  x   x  x a9 a8",
                          " a7 a6 a5 a4  a3 a2 a1 a0",
                          "  o  o  o  o   o  o  o  o";

        loadpage_lo     = "  0  1  0  0   0  0  0  0",
                          "  x  x  x  x   x  x  x  x",
                          "  x  x  x  x  a3 a2 a1 a0",
                          "  i  i  i  i   i  i  i  i";

        loadpage_hi     = "  0  1  0  0   1  0  0  0",
                          "  x  x  x  x   x  x  x  x",
                          "  x  x  x  x  a3 a2 a1 a0",
                          "  i  i  i  i   i  i  i  i";

        writepage       = "  0  1  0  0   1  1  0  0",
                          "  x  x  x  x   x  x a9 a8",
                          " a7 a6 a5 a4   x  x  x  x",
                          "  x  x  x  x   x  x  x  x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 32;
	readsize	= 256;
    ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0    x x x x  x x x x",
                          "0  0  0  0   0  0 a1 a0    o o o o  o o o o";
    ;

    memory "lock"
        size            = 1;
        read            = "0  1  0  1   1  0  0  0    x x x x  x x x x",
                          "x  x  x  x   x  x  x  x    x x x x  x x o o";

        write           = "1  0  1  0   1  1  0  0    1 1 1 1  1 1 i i",
                          "x  x  x  x   x  x  x  x    x x x x  x x x x";
        min_write_delay = 4500;
        max_write_delay = 4500;
    ;

    memory "lfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 4500;
        max_write_delay = 4500;
      ;

    memory "hfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 4500;
        max_write_delay = 4500;
      ;

    memory "efuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 1 0 0",
                          "x x x x  x x x x   x x x x  x x x i";

        read            = "0 1 0 1  0 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   x x x x  x x x o";
        min_write_delay = 4500;
        max_write_delay = 4500;
      ;

    memory "calibration"
        size            = 1;
        read            = "0  0  1  1   1  0  0  0    x x x x  x x x x",
                          "0  0  0  0   0  0  0  0    o o o o  o o o o";
    ;

;


#------------------------------------------------------------
# ATtiny461
#------------------------------------------------------------
# Close to ATtiny261

part
    id                  = "t461";
    desc                = "ATTINY461";
     has_debugwire = yes;
     flash_instr   = 0xB4, 0x00, 0x10;
     eeprom_instr  = 0xBB, 0xFF, 0xBB, 0xEE, 0xBB, 0xCC, 0xB2, 0x0D,
	             0xBC, 0x00, 0xB4, 0x00, 0xBA, 0x0D, 0xBB, 0xBC,
	             0x99, 0xE1, 0xBB, 0xAC;
#    stk500_devcode      = 0x21;
#    avr910_devcode      = 0x5e;
    signature           = 0x1e 0x92 0x08;
    pagel               = 0xb3;
    bs2                 = 0xb2;
    chip_erase_delay    = 4000;

    pgm_enable          = "1 0 1 0  1 1 0 0   0 1 0 1  0 0 1 1",
                          "x x x x  x x x x   x x x x  x x x x";

    chip_erase          = "1 0 1 0  1 1 0 0   1 0 0 x  x x x x",
                          "x x x x  x x x x   x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
        0xC4, 0xE4, 0xC4, 0xE4, 0xCC, 0xEC, 0xCC, 0xEC,
        0xD4, 0xF4, 0xD4, 0xF4, 0xDC, 0xFC, 0xDC, 0xFC,
        0xC8, 0xE8, 0xD8, 0xF8, 0x4C, 0x6C, 0x5C, 0x7C,
        0xEC, 0xBC, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 2;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    memory "eeprom"
        paged           = no;
        size            = 256;
        page_size       = 4;
        num_pages       = 64;
        min_write_delay = 4000;
        max_write_delay = 4000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;

        read            = " 1  0  1  0   0  0  0  0    x x x x  x x x x",
                          "a7 a6 a5 a4  a3 a2 a1 a0    o o o o  o o o o";

        write           = " 1  1  0  0   0  0  0  0    x x x x  x x x x",
                          "a7 a6 a5 a4  a3 a2 a1 a0    i i i i  i i i i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x   x   x",
			  " a7  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 4;
	readsize	= 256;
    ;

    memory "flash"
        paged           = yes;
        size            = 4096;
        page_size       = 64;
        num_pages       = 64;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;

        read_lo         = "  0  0  1  0   0   0  0  0",
                          "  x  x  x  x   x a10 a9 a8",
                          " a7 a6 a5 a4  a3  a2 a1 a0",
                          "  o  o  o  o   o   o  o  o";

        read_hi         = "  0  0  1  0   1   0  0  0",
                          "  x  x  x  x   x a10 a9 a8",
                          " a7 a6 a5 a4  a3  a2 a1 a0",
                          "  o  o  o  o   o   o  o  o";

        loadpage_lo     = "  0  1  0  0   0  0  0  0",
                          "  x  x  x  x   x  x  x  x",
                          "  x  x  x a4  a3 a2 a1 a0",
                          "  i  i  i  i   i  i  i  i";

        loadpage_hi     = "  0  1  0  0   1  0  0  0",
                          "  x  x  x  x   x  x  x  x",
                          "  x  x  x a4  a3 a2 a1 a0",
                          "  i  i  i  i   i  i  i  i";

        writepage       = "  0  1  0  0   1   1  0  0",
                          "  x  x  x  x   x a10 a9 a8",
                          " a7 a6 a5  x   x   x  x  x",
                          "  x  x  x  x   x   x  x  x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 64;
	readsize	= 256;
    ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0    x x x x  x x x x",
                          "0  0  0  0   0  0 a1 a0    o o o o  o o o o";
    ;

    memory "lock"
        size            = 1;
        read            = "0  1  0  1   1  0  0  0    x x x x  x x x x",
                          "x  x  x  x   x  x  x  x    x x x x  x x o o";

        write           = "1  0  1  0   1  1  0  0    1 1 1 1  1 1 i i",
                          "x  x  x  x   x  x  x  x    x x x x  x x x x";
        min_write_delay = 4500;
        max_write_delay = 4500;
    ;

    memory "lfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 4500;
        max_write_delay = 4500;
      ;

    memory "hfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 4500;
        max_write_delay = 4500;
      ;

    memory "efuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 1 0 0",
                          "x x x x  x x x x   x x x x  x x x i";

        read            = "0 1 0 1  0 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   x x x x  x x x o";
        min_write_delay = 4500;
        max_write_delay = 4500;
      ;

    memory "calibration"
        size            = 1;
        read            = "0  0  1  1   1  0  0  0    x x x x  x x x x",
                          "0  0  0  0   0  0  0  0    o o o o  o o o o";
    ;

;


#------------------------------------------------------------
# ATtiny861
#------------------------------------------------------------
# Close to ATtiny461

part
    id                  = "t861";
    desc                = "ATTINY861";
     has_debugwire = yes;
     flash_instr   = 0xB4, 0x00, 0x10;
     eeprom_instr  = 0xBB, 0xFF, 0xBB, 0xEE, 0xBB, 0xCC, 0xB2, 0x0D,
	             0xBC, 0x00, 0xB4, 0x00, 0xBA, 0x0D, 0xBB, 0xBC,
	             0x99, 0xE1, 0xBB, 0xAC;
#    stk500_devcode      = 0x21;
#    avr910_devcode      = 0x5e;
    signature           = 0x1e 0x93 0x0d;
    pagel               = 0xb3;
    bs2                 = 0xb2;
    chip_erase_delay    = 4000;

    pgm_enable          = "1 0 1 0  1 1 0 0   0 1 0 1  0 0 1 1",
                          "x x x x  x x x x   x x x x  x x x x";

    chip_erase          = "1 0 1 0  1 1 0 0   1 0 0 x  x x x x",
                          "x x x x  x x x x   x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 0;

    pp_controlstack     =
        0xC4, 0xE4, 0xC4, 0xE4, 0xCC, 0xEC, 0xCC, 0xEC,
        0xD4, 0xF4, 0xD4, 0xF4, 0xDC, 0xFC, 0xDC, 0xFC,
        0xC8, 0xE8, 0xD8, 0xF8, 0x4C, 0x6C, 0x5C, 0x7C,
        0xEC, 0xBC, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 2;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    memory "eeprom"
        paged           = no;
        size            = 512;
        num_pages       = 128;
        page_size       = 4;
        min_write_delay = 4000;
        max_write_delay = 4000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;

        read            = " 1  0  1  0   0  0  0  0    x x x x  x x x a8",
                          "a7 a6 a5 a4  a3 a2 a1 a0    o o o o  o o o  o";

        write           = " 1  1  0  0   0  0  0  0    x x x x  x x x a8",
                          "a7 a6 a5 a4  a3 a2 a1 a0    i i i i  i i i  i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x   x  a8",
			  " a7  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 4;
	readsize	= 256;
    ;

    memory "flash"
        paged           = yes;
        size            = 8192;
        page_size       = 64;
        num_pages       = 128;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;

        read_lo         = "  0  0  1  0   0   0  0  0",
                          "  x  x  x  x a11 a10 a9 a8",
                          " a7 a6 a5 a4  a3  a2 a1 a0",
                          "  o  o  o  o   o   o  o  o";

        read_hi         = "  0  0  1  0   1   0  0  0",
                          "  x  x  x  x a11 a10 a9 a8",
                          " a7 a6 a5 a4  a3  a2 a1 a0",
                          "  o  o  o  o   o   o  o  o";

        loadpage_lo     = "  0  1  0  0   0  0  0  0",
                          "  x  x  x  x   x  x  x  x",
                          "  x  x  x a4  a3 a2 a1 a0",
                          "  i  i  i  i   i  i  i  i";

        loadpage_hi     = "  0  1  0  0   1  0  0  0",
                          "  x  x  x  x   x  x  x  x",
                          "  x  x  x a4  a3 a2 a1 a0",
                          "  i  i  i  i   i  i  i  i";

        writepage       = "  0  1  0  0   1   1  0  0",
                          "  x  x  x  x a11 a10 a9 a8",
                          " a7 a6 a5  x   x   x  x  x",
                          "  x  x  x  x   x   x  x  x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 64;
	readsize	= 256;
    ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0    x x x x  x x x x",
                          "0  0  0  0   0  0 a1 a0    o o o o  o o o o";
    ;

    memory "lock"
        size            = 1;
        read            = "0  1  0  1   1  0  0  0    x x x x  x x x x",
                          "x  x  x  x   x  x  x  x    x x x x  x x o o";

        write           = "1  0  1  0   1  1  0  0    1 1 1 1  1 1 i i",
                          "x  x  x  x   x  x  x  x    x x x x  x x x x";
        min_write_delay = 4500;
        max_write_delay = 4500;
    ;

    memory "lfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 4500;
        max_write_delay = 4500;
      ;

    memory "hfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 4500;
        max_write_delay = 4500;
      ;

    memory "efuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 1 0 0",
                          "x x x x  x x x x   x x x x  x x x i";

        read            = "0 1 0 1  0 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   x x x x  x x x o";
        min_write_delay = 4500;
        max_write_delay = 4500;
      ;

    memory "calibration"
        size            = 1;
        read            = "0  0  1  1   1  0  0  0    x x x x  x x x x",
                          "0  0  0  0   0  0  0  0    o o o o  o o o o";
    ;

;


#------------------------------------------------------------
# ATmega48
#------------------------------------------------------------

part
    id               = "m48";
    desc             = "ATMEGA48";
     has_debugwire = yes;
     flash_instr   = 0xB6, 0x01, 0x11;
     eeprom_instr  = 0xBD, 0xF2, 0xBD, 0xE1, 0xBB, 0xCF, 0xB4, 0x00,
	             0xBE, 0x01, 0xB6, 0x01, 0xBC, 0x00, 0xBB, 0xBF,
	             0x99, 0xF9, 0xBB, 0xAF;
    stk500_devcode   = 0x59;
#    avr910_devcode   = 0x;
    signature        = 0x1e 0x92 0x05;
    pagel            = 0xd7;
    bs2              = 0xc2;
    chip_erase_delay = 45000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
	0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
	0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
	0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
	0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    resetdelay          = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    memory "eeprom"
        paged           = no;
        page_size       = 4;
        size            = 256;
        min_write_delay = 3600;
        max_write_delay = 3600;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   0   x      x   x   x   x",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   0   x      x   x   x   x",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x   x   x",
			  " a7  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 5;
	blocksize	= 4;
	readsize	= 256;
      ;
    memory "flash"
        paged           = yes;
        size            = 4096;
        page_size       = 64;
        num_pages       = 64;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read_lo         = "  0   0   1   0    0   0   0   0",
                          "  0   0   0   0    0 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        read_hi         = "  0   0   1   0    1   0   0   0",
                          "  0   0   0   0    0 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  0   0   0   x      x   x   x   x",
                          "  x   x   x  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  0   0   0   x      x   x   x   x",
                          "  x   x   x  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  0   0   0   0      0 a10  a9  a8",
                          " a7  a6  a5   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 64;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "hfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "efuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   x x x x  x x x o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 1 0 0",
                          "x x x x  x x x x   x x x x  x x x i";
      ;

    memory "lock"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
      ;

    memory "calibration"
        size            = 1;
        read            = "0  0  1  1   1  0  0  0   0  0  0  x   x  x  x  x",
                          "0  0  0  0   0  0  0  0   o  o  o  o   o  o  o  o";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   0  0  0  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;


#------------------------------------------------------------
# ATmega88
#------------------------------------------------------------

part
    id               = "m88";
    desc             = "ATMEGA88";
     has_debugwire = yes;
     flash_instr   = 0xB6, 0x01, 0x11;
     eeprom_instr  = 0xBD, 0xF2, 0xBD, 0xE1, 0xBB, 0xCF, 0xB4, 0x00,
	             0xBE, 0x01, 0xB6, 0x01, 0xBC, 0x00, 0xBB, 0xBF,
	             0x99, 0xF9, 0xBB, 0xAF;
    stk500_devcode   = 0x73;
#    avr910_devcode   = 0x;
    signature        = 0x1e 0x93 0x0a;
    pagel            = 0xd7;
    bs2              = 0xc2;
    chip_erase_delay = 9000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
	0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
	0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
	0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
	0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    resetdelay          = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    memory "eeprom"
        paged           = no;
        page_size       = 4;
        size            = 512;
        min_write_delay = 3600;
        max_write_delay = 3600;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   0   x      x   x   x  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   0   x      x   x   x  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x   x  a8",
			  " a7  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 5;
	blocksize	= 4;
	readsize	= 256;
      ;
    memory "flash"
        paged           = yes;
        size            = 8192;
        page_size       = 64;
        num_pages       = 128;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0    0   0   0   0",
                          "  0   0   0   0  a11 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        read_hi         = "  0   0   1   0    1   0   0   0",
                          "  0   0   0   0  a11 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  0   0   0   x      x   x   x   x",
                          "  x   x   x  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  0   0   0   x      x   x   x   x",
                          "  x   x   x  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  0   0   0   0    a11 a10  a9  a8",
                          " a7  a6  a5   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 64;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "hfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "efuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   x x x x  x o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 1 0 0",
                          "x x x x  x x x x   x x x x  x i i i";
      ;

    memory "lock"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
      ;

    memory "calibration"
        size            = 1;
        read            = "0  0  1  1   1  0  0  0   0  0  0  x   x  x  x  x",
                          "0  0  0  0   0  0  0  0   o  o  o  o   o  o  o  o";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   0  0  0  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;

#------------------------------------------------------------
# ATmega168
#------------------------------------------------------------

part
    id              = "m168";
    desc            = "ATMEGA168";
     has_debugwire = yes;
     flash_instr   = 0xB6, 0x01, 0x11;
     eeprom_instr  = 0xBD, 0xF2, 0xBD, 0xE1, 0xBB, 0xCF, 0xB4, 0x00,
	             0xBE, 0x01, 0xB6, 0x01, 0xBC, 0x00, 0xBB, 0xBF,
	             0x99, 0xF9, 0xBB, 0xAF;
    stk500_devcode  = 0x86;
    # avr910_devcode = 0x;
    signature       = 0x1e 0x94 0x06;
    pagel           = 0xd7;
    bs2             = 0xc2;
    chip_erase_delay = 9000;
    pgm_enable       = "1 0 1 0 1 1 0 0 0 1 0 1 0 0 1 1",
                       "x x x x x x x x x x x x x x x x";

    chip_erase       = "1 0 1 0 1 1 0 0 1 0 0 x x x x x",
                       "x x x x x x x x x x x x x x x x";

    timeout         = 200;
    stabdelay       = 100;
    cmdexedelay     = 25;
    synchloops      = 32;
    bytedelay       = 0;
    pollindex       = 3;
    pollvalue       = 0x53;
    predelay        = 1;
    postdelay       = 1;
    pollmethod      = 1;

    pp_controlstack     =
	0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
	0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
	0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
	0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    resetdelay          = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    memory "eeprom"
        paged           = no;
        page_size       = 4;
        size            = 512;
        min_write_delay = 3600;
        max_write_delay = 3600;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read            = " 1 0 1 0 0 0 0 0",
                          " 0 0 0 x x x x a8",
                          " a7 a6 a5 a4 a3 a2 a1 a0",
                          " o o o o o o o o";
    
        write           = " 1 1 0 0 0 0 0 0",
                          " 0 0 0 x x x x a8",
                          " a7 a6 a5 a4 a3 a2 a1 a0",
                          " i i i i i i i i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x   x  a8",
			  " a7  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 5;
	blocksize	= 4;
	readsize	= 256;
        ;

    memory "flash"
        paged           = yes;
        size            = 16384;
        page_size       = 128;
        num_pages       = 128;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = " 0 0 1 0 0 0 0 0",
                          " 0 0 0 a12 a11 a10 a9 a8",
                          " a7 a6 a5 a4 a3 a2 a1 a0",
                          " o o o o o o o o";
        
        read_hi          = " 0 0 1 0 1 0 0 0",
                           " 0 0 0 a12 a11 a10 a9 a8",
                           " a7 a6 a5 a4 a3 a2 a1 a0",
                           " o o o o o o o o";
        
        loadpage_lo     = " 0 1 0 0 0 0 0 0",
                          " 0 0 0 x x x x x",
                          " x x a5 a4 a3 a2 a1 a0",
                          " i i i i i i i i";
        
        loadpage_hi     = " 0 1 0 0 1 0 0 0",
                          " 0 0 0 x x x x x",
                          " x x a5 a4 a3 a2 a1 a0",
                          " i i i i i i i i";
        
        writepage       = " 0 1 0 0 1 1 0 0",
                          " 0 0 0 a12 a11 a10 a9 a8",
                          " a7 a6 x x x x x x",
                          " x x x x x x x x";

        mode        = 0x41;
        delay       = 6;
        blocksize   = 128;
        readsize    = 256;

        ;
        
    memory "lfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0",
                          "x x x x x x x x o o o o o o o o";
        
        write           = "1 0 1 0 1 1 0 0 1 0 1 0 0 0 0 0",
                          "x x x x x x x x i i i i i i i i";
        ;
    
    memory "hfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1 1 0 0 0 0 0 0 0 1 0 0 0",
                          "x x x x x x x x o o o o o o o o";
        
        write           = "1 0 1 0 1 1 0 0 1 0 1 0 1 0 0 0",
                          "x x x x x x x x i i i i i i i i";
        ;
    
    memory "efuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1 0 0 0 0 0 0 0 0 1 0 0 0",
                          "x x x x x x x x x x x x x o o o";
        
        write           = "1 0 1 0 1 1 0 0 1 0 1 0 0 1 0 0",
                          "x x x x x x x x x x x x x i i i";
        ;
    
    memory "lock"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1 1 0 0 0 0 0 0 0 0 0 0 0",
                          "x x x x x x x x x x o o o o o o";
        
        write           = "1 0 1 0 1 1 0 0 1 1 1 x x x x x",
                          "x x x x x x x x 1 1 i i i i i i";
        ;
    
    memory "calibration"
        size            = 1;
        read            = "0 0 1 1 1 0 0 0 0 0 0 x x x x x",
                          "0 0 0 0 0 0 0 0 o o o o o o o o";
        ;
    
    memory "signature"
        size            = 3;
        read            = "0 0 1 1 0 0 0 0 0 0 0 x x x x x",
                          "x x x x x x a1 a0 o o o o o o o o";
        ;
;

#------------------------------------------------------------
# ATtiny88
#------------------------------------------------------------

part
    id               = "t88";
    desc             = "attiny88";
     has_debugwire = yes;
     flash_instr   = 0xB6, 0x01, 0x11;
     eeprom_instr  = 0xBD, 0xF2, 0xBD, 0xE1, 0xBB, 0xCF, 0xB4, 0x00,
	             0xBE, 0x01, 0xB6, 0x01, 0xBC, 0x00, 0xBB, 0xBF,
	             0x99, 0xF9, 0xBB, 0xAF;
    stk500_devcode   = 0x73;
#    avr910_devcode   = 0x;
    signature        = 0x1e 0x93 0x11;
    pagel            = 0xd7;
    bs2              = 0xc2;
    chip_erase_delay = 9000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
	0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
	0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
	0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
	0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    resetdelay          = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    memory "eeprom"
        paged           = no;
        page_size       = 4;
        size            = 64;
        min_write_delay = 3600;
        max_write_delay = 3600;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
	read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   0   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

	write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   0   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x   x   x",
			  "  x  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 5;
	blocksize	= 4;
	readsize	= 64;
      ;
    memory "flash"
        paged           = yes;
        size            = 8192;
        page_size       = 64;
        num_pages       = 128;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0    0   0   0   0",
                          "  0   0   0   0  a11 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        read_hi         = "  0   0   1   0    1   0   0   0",
                          "  0   0   0   0  a11 a10  a9  a8",
                          " a7  a6  a5  a4   a3  a2  a1  a0",
                          "  o   o   o   o    o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  0   0   0   x      x   x   x   x",
                          "  x   x   x  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  0   0   0   x      x   x   x   x",
                          "  x   x   x  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  0   0   0   0    a11 a10  a9  a8",
                          " a7  a6  a5   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 64;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "hfuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "x x x x  x x x x   i i i i  i i i i";
      ;

    memory "efuse"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  1 0 0 0",
                          "x x x x  x x x x   x x x x  x o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 1 0 0",
                          "x x x x  x x x x   x x x x  x x x i";
      ;

    memory "lock"
        size            = 1;
        min_write_delay = 4500;
        max_write_delay = 4500;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
      ;

    memory "calibration"
        size            = 1;
        read            = "0  0  1  1   1  0  0  0   0  0  0  x   x  x  x  x",
                          "0  0  0  0   0  0  0  0   o  o  o  o   o  o  o  o";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   0  0  0  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;

#------------------------------------------------------------
# ATmega328P
#------------------------------------------------------------

part
    id			= "m328p";
    desc		= "ATMEGA328P";
    has_debugwire	= yes;
    flash_instr		= 0xB6, 0x01, 0x11;
    eeprom_instr	= 0xBD, 0xF2, 0xBD, 0xE1, 0xBB, 0xCF, 0xB4, 0x00,
			  0xBE, 0x01, 0xB6, 0x01, 0xBC, 0x00, 0xBB, 0xBF,
			  0x99, 0xF9, 0xBB, 0xAF;
    stk500_devcode	= 0x86;
    # avr910_devcode	= 0x;
    signature		= 0x1e 0x95 0x0F;
    pagel		= 0xd7;
    bs2			= 0xc2;
    chip_erase_delay	= 9000;
    pgm_enable = "1 0 1 0 1 1 0 0 0 1 0 1 0 0 1 1",
		 "x x x x x x x x x x x x x x x x";

    chip_erase = "1 0 1 0 1 1 0 0 1 0 0 x x x x x",
		 "x x x x x x x x x x x x x x x x";

    timeout	= 200;
    stabdelay	= 100;
    cmdexedelay	= 25;
    synchloops	= 32;
    bytedelay	= 0;
    pollindex	= 3;
    pollvalue	= 0x53;
    predelay	= 1;
    postdelay	= 1;
    pollmethod	= 1;

    pp_controlstack =
	0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
	0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
	0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
	0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay	= 100;
    progmodedelay	= 0;
    latchcycles		= 5;
    togglevtg		= 1;
    poweroffdelay	= 15;
    resetdelayms	= 1;
    resetdelayus	= 0;
    hvleavestabdelay	= 15;
    resetdelay		= 15;
    chiperasepulsewidth	= 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    memory "eeprom"
	paged		= no;
	page_size	= 4;
	size		= 1024;
	min_write_delay = 3600;
	max_write_delay = 3600;
	readback_p1	= 0xff;
	readback_p2	= 0xff;
	read = " 1 0 1 0 0 0 0 0",
	       " 0 0 0 x x x a9 a8",
	       " a7 a6 a5 a4 a3 a2 a1 a0",
	       " o o o o o o o o";

	write = " 1 1 0 0 0 0 0 0",
	      	" 0 0 0 x x x a9 a8",
		" a7 a6 a5 a4 a3 a2 a1 a0",
		" i i i i i i i i";

	loadpage_lo = " 1 1 0 0 0 0 0 1",
		      " 0 0 0 0 0 0 0 0",
		      " 0 0 0 0 0 0 a1 a0",
		      " i i i i i i i i";

	writepage = " 1 1 0 0 0 0 1 0",
		    " 0 0 x x x x a9 a8",
		    " a7 a6 a5 a4 a3 a2 0 0",
		    " x x x x x x x x";

	mode		= 0x41;
	delay		= 5;
	blocksize	= 4;
	readsize	= 256;
    ;

    memory "flash"
	paged		= yes;
	size		= 32768;
	page_size	= 128;
	num_pages	= 256;
	min_write_delay = 4500;
	max_write_delay = 4500;
	readback_p1	= 0xff;
	readback_p2	= 0xff;
	read_lo = " 0 0 1 0 0 0 0 0",
		  " 0 0 a13 a12 a11 a10 a9 a8",
		  " a7 a6 a5 a4 a3 a2 a1 a0",
		  " o o o o o o o o";

	read_hi = " 0 0 1 0 1 0 0 0",
		  " 0 0 a13 a12 a11 a10 a9 a8",
		  " a7 a6 a5 a4 a3 a2 a1 a0",
		  " o o o o o o o o";

	loadpage_lo = " 0 1 0 0 0 0 0 0",
		      " 0 0 0 x x x x x",
		      " x x a5 a4 a3 a2 a1 a0",
		      " i i i i i i i i";

	loadpage_hi = " 0 1 0 0 1 0 0 0",
		      " 0 0 0 x x x x x",
		      " x x a5 a4 a3 a2 a1 a0",
		      " i i i i i i i i";

	writepage = " 0 1 0 0 1 1 0 0",
		    " 0 0 a13 a12 a11 a10 a9 a8",
		    " a7 a6 x x x x x x",
		    " x x x x x x x x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 128;
	readsize	= 256;

    ;

    memory "lfuse"
	size = 1;
	min_write_delay = 4500;
	max_write_delay = 4500;
	read = "0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0",
	       "x x x x x x x x o o o o o o o o";

	write = "1 0 1 0 1 1 0 0 1 0 1 0 0 0 0 0",
	      	"x x x x x x x x i i i i i i i i";
    ;

    memory "hfuse"
	size = 1;
	min_write_delay = 4500;
	max_write_delay = 4500;
	read = "0 1 0 1 1 0 0 0 0 0 0 0 1 0 0 0",
	       "x x x x x x x x o o o o o o o o";

	write = "1 0 1 0 1 1 0 0 1 0 1 0 1 0 0 0",
	      	"x x x x x x x x i i i i i i i i";
    ;

    memory "efuse"
	size = 1;
	min_write_delay = 4500;
	max_write_delay = 4500;
	read = "0 1 0 1 0 0 0 0 0 0 0 0 1 0 0 0",
	       "x x x x x x x x x x x x x o o o";

	write = "1 0 1 0 1 1 0 0 1 0 1 0 0 1 0 0",
	      	"x x x x x x x x x x x x x i i i";
    ;

    memory "lock"
	size = 1;
	min_write_delay = 4500;
	max_write_delay = 4500;
	read = "0 1 0 1 1 0 0 0 0 0 0 0 0 0 0 0",
	       "x x x x x x x x x x o o o o o o";

	write = "1 0 1 0 1 1 0 0 1 1 1 x x x x x",
	      	"x x x x x x x x 1 1 i i i i i i";
    ;

    memory "calibration"
	size = 1;
	read = "0 0 1 1 1 0 0 0 0 0 0 x x x x x",
	       "0 0 0 0 0 0 0 0 o o o o o o o o";
    ;

    memory "signature"
	size = 3;
	read = "0 0 1 1 0 0 0 0 0 0 0 x x x x x",
	       "x x x x x x a1 a0 o o o o o o o o";
    ;
;

#------------------------------------------------------------
# ATtiny2313
#------------------------------------------------------------

part
     id            = "t2313";
     desc          = "ATtiny2313";
     has_debugwire = yes;
     flash_instr   = 0xB2, 0x0F, 0x1F;
     eeprom_instr  = 0xBB, 0xFE, 0xBB, 0xEE, 0xBB, 0xCC, 0xB2, 0x0D,
	             0xBA, 0x0F, 0xB2, 0x0F, 0xBA, 0x0D, 0xBB, 0xBC,
	             0x99, 0xE1, 0xBB, 0xAC;
     stk500_devcode   = 0x23;
##   Use the ATtiny26 devcode:
     avr910_devcode   = 0x5e;
     signature        = 0x1e 0x91 0x0a;
     pagel            = 0xD4;
     bs2              = 0xD6;
     reset            = io;
     chip_erase_delay = 9000;

     pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                        "x x x x  x x x x    x x x x  x x x x";

     chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                        "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0E, 0x1E, 0x2E, 0x3E, 0x2E, 0x3E,
        0x4E, 0x5E, 0x4E, 0x5E, 0x6E, 0x7E, 0x6E, 0x7E,
        0x26, 0x36, 0x66, 0x76, 0x2A, 0x3A, 0x6A, 0x7A,
        0x2E, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

     memory "eeprom"
         size            = 128;
        paged           = no;
        page_size       = 4;
         min_write_delay = 4000;
         max_write_delay = 4500;
         readback_p1     = 0xff;
         readback_p2     = 0xff;
         read            = "1  0  1  0   0  0  0  0   0 0 0 x  x x x x",
                           "x a6 a5 a4  a3 a2 a1 a0   o o o o  o o o o";

         write           = "1  1  0  0   0  0  0  0   0 0 0 x  x x x x",
                           "x a6 a5 a4  a3 a2 a1 a0   i i i i  i i i i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x   x   x",
			  "  x  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 4;
	readsize	= 256;
       ;
     memory "flash"
         paged           = yes;
         size            = 2048;
         page_size       = 32;
         num_pages       = 64;
         min_write_delay = 4500;
         max_write_delay = 4500;
         readback_p1     = 0xff;
         readback_p2     = 0xff;
         read_lo         = "  0   0   1   0    0   0   0   0",
                           "  0   0   0   0    0   0  a9  a8",
                           " a7  a6  a5  a4   a3  a2  a1  a0",
                           "  o   o   o   o    o   o   o   o";

         read_hi         = "  0   0   1   0    1   0   0   0",
                           "  0   0   0   0    0   0  a9  a8",
                           " a7  a6  a5  a4   a3  a2  a1  a0",
                           "  o   o   o   o    o   o   o   o";

# The information in the data sheet of April/2004 is wrong, this works:
         loadpage_lo     = "  0   1   0   0    0   0   0   0",
                           "  0   0   0   x    x   x   x   x",
                           "  x   x   x   x   a3  a2  a1  a0",
                           "  i   i   i   i    i   i   i   i";

# The information in the data sheet of April/2004 is wrong, this works:
         loadpage_hi     = "  0   1   0   0    1   0   0   0",
                           "  0   0   0   x    x   x   x   x",
                           "  x   x   x   x   a3  a2  a1  a0",
                           "  i   i   i   i    i   i   i   i";

# The information in the data sheet of April/2004 is wrong, this works:
         writepage       = "  0  1  0  0   1  1  0  0",
                           "  0  0  0  0   0  0 a9 a8",
                           " a7 a6 a5 a4   x  x  x  x",
                           "  x  x  x  x   x  x  x  x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 32;
	readsize	= 256;
       ;
#   ATtiny2313 has Signature Bytes: 0x1E 0x91 0x0A.
     memory "signature"
         size            = 3;
         read            = "0  0  1  1   0  0  0  0   0  0  0  x   x  x  x  x",
                           "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
       ;
     memory "lock"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 1 1 x  x x x x",
                           "x x x x  x x x x  1 1 i i  i i i i";
         read           = "0 1 0 1  1 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  x x o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "lfuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                           "x x x x  x x x x  i i i i  i i i i";

         read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "hfuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                           "x x x x  x x x x  i i i i  i i i i";

         read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "efuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                           "x x x x  x x x x  x x x x  x x x i";

         read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
     ;
# The Tiny2313 has calibration data for both 4 MHz and 8 MHz.
# The information in the data sheet of April/2004 is wrong, this works:

     memory "calibration"
         size            = 2;
         read            = "0  0  1  1   1  0  0  0    0 0 0 x  x x x x",
                           "0  0  0  0   0  0  0  a0   o o o o  o o o o";
     ;
  ;

#------------------------------------------------------------
# AT90PWM2
#------------------------------------------------------------

part
     id            = "pwm2";
     desc          = "AT90PWM2";
     has_debugwire = yes;
     flash_instr   = 0xB6, 0x01, 0x11;
     eeprom_instr  = 0xBD, 0xF2, 0xBD, 0xE1, 0xBB, 0xCF, 0xB4, 0x00,
	             0xBE, 0x01, 0xB6, 0x01, 0xBC, 0x00, 0xBB, 0xBF,
	             0x99, 0xF9, 0xBB, 0xAF;
     stk500_devcode   = 0x65;
##  avr910_devcode   = ?;
     signature        = 0x1e 0x93 0x81;
     pagel            = 0xD8;
     bs2              = 0xE2;
     reset            = io;
     chip_erase_delay = 9000;

     pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                        "x x x x  x x x x    x x x x  x x x x";

     chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                        "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

     memory "eeprom"
         size            = 512;
        paged           = no;
        page_size       = 4;
         min_write_delay = 4000;
         max_write_delay = 4500;
         readback_p1     = 0xff;
         readback_p2     = 0xff;
         read            = "1  0  1  0   0  0  0  0   0 0 0 x  x x x a8",
                           "a7 a6 a5 a4  a3 a2 a1 a0  o o o o  o o o o";

         write           = "1  1  0  0   0  0  0  0   0 0 0 x  x x x a8",
                           "a7 a6 a5 a4  a3 a2 a1 a0  i i i i  i i i i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x   x   x",
			  " a7  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 4;
	readsize	= 256;
       ;
     memory "flash"
         paged           = yes;
         size            = 8192;
         page_size       = 64;
         num_pages       = 128;
         min_write_delay = 4500;
         max_write_delay = 4500;
         readback_p1     = 0xff;
         readback_p2     = 0xff;
         read_lo         = "  0   0   1   0    0   0   0   0",
                           "  0   0   0   0   a11 a10 a9  a8",
                           " a7  a6  a5  a4   a3  a2  a1  a0",
                           "  o   o   o   o    o   o   o   o";

         read_hi         = "  0   0   1   0    1   0   0   0",
                           "  0   0   0   0   a11 a10 a9  a8",
                           " a7  a6  a5  a4   a3  a2  a1  a0",
                           "  o   o   o   o    o   o   o   o";

         loadpage_lo     = "  0   1   0   0    0   0   0   0",
                           "  0   0   0   x    x   x   x   x",
                           "  x   x   x  a4   a3  a2  a1  a0",
                           "  i   i   i   i    i   i   i   i";

         loadpage_hi     = "  0   1   0   0    1   0   0   0",
                           "  0   0   0   x    x   x   x   x",
                           "  x   x   x  a4   a3  a2  a1  a0",
                           "  i   i   i   i    i   i   i   i";

         writepage       = "  0  1  0  0   1   1   0   0",
                           "  0  0  0  0   a11 a10 a9  a8",
                           " a7 a6 a5  x   x   x   x   x",
                           "  x  x  x  x   x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 64;
	readsize	= 256;
       ;
#   AT90PWM2 has Signature Bytes: 0x1E 0x93 0x81.
     memory "signature"
         size            = 3;
         read            = "0  0  1  1   0  0  0  0   0  0  x  x   x  x  x  x",
                           "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
       ;
     memory "lock"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 1 1 x  x x x x",
                           "x x x x  x x x x  1 1 i i  i i i i";

         read            = "0 1 0 1  1 0 0 0  0 0 0 0  0 0 0 0",
                           "x x x x  x x x x  x x o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "lfuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                           "x x x x  x x x x  i i i i  i i i i";

         read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "hfuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                           "x x x x  x x x x  i i i i  i i i i";

         read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "efuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                           "x x x x  x x x x  x x x x  x x x i";

         read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
     ;

     memory "calibration"
         size            = 1;
         read            = "0  0  1  1   1  0  0  0    0 0 0 x  x x x x",
                           "0  0  0  0   0  0  0  0    o o o o  o o o o";
     ;
  ;

#------------------------------------------------------------
# AT90PWM3
#------------------------------------------------------------

# Completely identical to AT90PWM2 (including the signature!)

part
     id            = "pwm3";
     desc          = "AT90PWM3";
     has_debugwire = yes;
     flash_instr   = 0xB6, 0x01, 0x11;
     eeprom_instr  = 0xBD, 0xF2, 0xBD, 0xE1, 0xBB, 0xCF, 0xB4, 0x00,
	             0xBE, 0x01, 0xB6, 0x01, 0xBC, 0x00, 0xBB, 0xBF,
	             0x99, 0xF9, 0xBB, 0xAF;
     stk500_devcode   = 0x65;
##  avr910_devcode   = ?;
     signature        = 0x1e 0x93 0x81;
     pagel            = 0xD8;
     bs2              = 0xE2;
     reset            = io;
     chip_erase_delay = 9000;

     pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                        "x x x x  x x x x    x x x x  x x x x";

     chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                        "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

     memory "eeprom"
         size            = 512;
        paged           = no;
        page_size       = 4;
         min_write_delay = 4000;
         max_write_delay = 4500;
         readback_p1     = 0xff;
         readback_p2     = 0xff;
         read            = "1  0  1  0   0  0  0  0   0 0 0 x  x x x a8",
                           "a7 a6 a5 a4  a3 a2 a1 a0  o o o o  o o o o";

         write           = "1  1  0  0   0  0  0  0   0 0 0 x  x x x a8",
                           "a7 a6 a5 a4  a3 a2 a1 a0  i i i i  i i i i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x   x   x",
			  " a7  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 4;
	readsize	= 256;
       ;
     memory "flash"
         paged           = yes;
         size            = 8192;
         page_size       = 64;
         num_pages       = 128;
         min_write_delay = 4500;
         max_write_delay = 4500;
         readback_p1     = 0xff;
         readback_p2     = 0xff;
         read_lo         = "  0   0   1   0    0   0   0   0",
                           "  0   0   0   0   a11 a10 a9  a8",
                           " a7  a6  a5  a4   a3  a2  a1  a0",
                           "  o   o   o   o    o   o   o   o";

         read_hi         = "  0   0   1   0    1   0   0   0",
                           "  0   0   0   0   a11 a10 a9  a8",
                           " a7  a6  a5  a4   a3  a2  a1  a0",
                           "  o   o   o   o    o   o   o   o";

         loadpage_lo     = "  0   1   0   0    0   0   0   0",
                           "  0   0   0   x    x   x   x   x",
                           "  x   x   x  a4   a3  a2  a1  a0",
                           "  i   i   i   i    i   i   i   i";

         loadpage_hi     = "  0   1   0   0    1   0   0   0",
                           "  0   0   0   x    x   x   x   x",
                           "  x   x   x  a4   a3  a2  a1  a0",
                           "  i   i   i   i    i   i   i   i";

         writepage       = "  0  1  0  0   1   1   0   0",
                           "  0  0  0  0   a11 a10 a9  a8",
                           " a7 a6 a5  x   x   x   x   x",
                           "  x  x  x  x   x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 64;
	readsize	= 256;
       ;
#   AT90PWM2 has Signature Bytes: 0x1E 0x93 0x81.
     memory "signature"
         size            = 3;
         read            = "0  0  1  1   0  0  0  0   0  0  x  x   x  x  x  x",
                           "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
       ;
     memory "lock"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 1 1 x  x x x x",
                           "x x x x  x x x x  1 1 i i  i i i i";

         read            = "0 1 0 1  1 0 0 0  0 0 0 0  0 0 0 0",
                           "x x x x  x x x x  x x o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "lfuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                           "x x x x  x x x x  i i i i  i i i i";

         read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "hfuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                           "x x x x  x x x x  i i i i  i i i i";

         read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "efuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                           "x x x x  x x x x  x x x x  x x x i";

         read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
     ;

     memory "calibration"
         size            = 1;
         read            = "0  0  1  1   1  0  0  0    0 0 0 x  x x x x",
                           "0  0  0  0   0  0  0  0    o o o o  o o o o";
     ;
  ;

#------------------------------------------------------------
# AT90PWM2B
#------------------------------------------------------------
# Same as AT90PWM2 but different signature.

part
     id            = "pwm2b";
     desc          = "AT90PWM2B";
     has_debugwire = yes;
     flash_instr   = 0xB6, 0x01, 0x11;
     eeprom_instr  = 0xBD, 0xF2, 0xBD, 0xE1, 0xBB, 0xCF, 0xB4, 0x00,
	             0xBE, 0x01, 0xB6, 0x01, 0xBC, 0x00, 0xBB, 0xBF,
	             0x99, 0xF9, 0xBB, 0xAF;
     stk500_devcode   = 0x65;
##  avr910_devcode   = ?;
     signature        = 0x1e 0x93 0x83;
     pagel            = 0xD8;
     bs2              = 0xE2;
     reset            = io;
     chip_erase_delay = 9000;

     pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                        "x x x x  x x x x    x x x x  x x x x";

     chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                        "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

     memory "eeprom"
         size            = 512;
        paged           = no;
        page_size       = 4;
         min_write_delay = 4000;
         max_write_delay = 4500;
         readback_p1     = 0xff;
         readback_p2     = 0xff;
         read            = "1  0  1  0   0  0  0  0   0 0 0 x  x x x a8",
                           "a7 a6 a5 a4  a3 a2 a1 a0  o o o o  o o o o";

         write           = "1  1  0  0   0  0  0  0   0 0 0 x  x x x a8",
                           "a7 a6 a5 a4  a3 a2 a1 a0  i i i i  i i i i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x   x   x",
			  " a7  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 4;
	readsize	= 256;
       ;
     memory "flash"
         paged           = yes;
         size            = 8192;
         page_size       = 64;
         num_pages       = 128;
         min_write_delay = 4500;
         max_write_delay = 4500;
         readback_p1     = 0xff;
         readback_p2     = 0xff;
         read_lo         = "  0   0   1   0    0   0   0   0",
                           "  0   0   0   0   a11 a10 a9  a8",
                           " a7  a6  a5  a4   a3  a2  a1  a0",
                           "  o   o   o   o    o   o   o   o";

         read_hi         = "  0   0   1   0    1   0   0   0",
                           "  0   0   0   0   a11 a10 a9  a8",
                           " a7  a6  a5  a4   a3  a2  a1  a0",
                           "  o   o   o   o    o   o   o   o";

         loadpage_lo     = "  0   1   0   0    0   0   0   0",
                           "  0   0   0   x    x   x   x   x",
                           "  x   x   x  a4   a3  a2  a1  a0",
                           "  i   i   i   i    i   i   i   i";

         loadpage_hi     = "  0   1   0   0    1   0   0   0",
                           "  0   0   0   x    x   x   x   x",
                           "  x   x   x  a4   a3  a2  a1  a0",
                           "  i   i   i   i    i   i   i   i";

         writepage       = "  0  1  0  0   1   1   0   0",
                           "  0  0  0  0   a11 a10 a9  a8",
                           " a7 a6 a5  x   x   x   x   x",
                           "  x  x  x  x   x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 64;
	readsize	= 256;
       ;
     memory "signature"
         size            = 3;
         read            = "0  0  1  1   0  0  0  0   0  0  x  x   x  x  x  x",
                           "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
       ;
     memory "lock"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 1 1 x  x x x x",
                           "x x x x  x x x x  1 1 i i  i i i i";

         read            = "0 1 0 1  1 0 0 0  0 0 0 0  0 0 0 0",
                           "x x x x  x x x x  x x o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "lfuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                           "x x x x  x x x x  i i i i  i i i i";

         read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "hfuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                           "x x x x  x x x x  i i i i  i i i i";

         read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "efuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                           "x x x x  x x x x  x x x x  x x x i";

         read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
     ;

     memory "calibration"
         size            = 1;
         read            = "0  0  1  1   1  0  0  0    0 0 0 x  x x x x",
                           "0  0  0  0   0  0  0  0    o o o o  o o o o";
     ;
  ;

#------------------------------------------------------------
# AT90PWM3B
#------------------------------------------------------------

# Completely identical to AT90PWM2B (including the signature!)

part
     id            = "pwm3b";
     desc          = "AT90PWM3B";
     has_debugwire = yes;
     flash_instr   = 0xB6, 0x01, 0x11;
     eeprom_instr  = 0xBD, 0xF2, 0xBD, 0xE1, 0xBB, 0xCF, 0xB4, 0x00,
	             0xBE, 0x01, 0xB6, 0x01, 0xBC, 0x00, 0xBB, 0xBF,
	             0x99, 0xF9, 0xBB, 0xAF;
     stk500_devcode   = 0x65;
##  avr910_devcode   = ?;
     signature        = 0x1e 0x93 0x83;
     pagel            = 0xD8;
     bs2              = 0xE2;
     reset            = io;
     chip_erase_delay = 9000;

     pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                        "x x x x  x x x x    x x x x  x x x x";

     chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                        "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

     memory "eeprom"
         size            = 512;
        paged           = no;
        page_size       = 4;
         min_write_delay = 4000;
         max_write_delay = 4500;
         readback_p1     = 0xff;
         readback_p2     = 0xff;
         read            = "1  0  1  0   0  0  0  0   0 0 0 x  x x x a8",
                           "a7 a6 a5 a4  a3 a2 a1 a0  o o o o  o o o o";

         write           = "1  1  0  0   0  0  0  0   0 0 0 x  x x x a8",
                           "a7 a6 a5 a4  a3 a2 a1 a0  i i i i  i i i i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x   x   x",
			  " a7  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 4;
	readsize	= 256;
       ;
     memory "flash"
         paged           = yes;
         size            = 8192;
         page_size       = 64;
         num_pages       = 128;
         min_write_delay = 4500;
         max_write_delay = 4500;
         readback_p1     = 0xff;
         readback_p2     = 0xff;
         read_lo         = "  0   0   1   0    0   0   0   0",
                           "  0   0   0   0   a11 a10 a9  a8",
                           " a7  a6  a5  a4   a3  a2  a1  a0",
                           "  o   o   o   o    o   o   o   o";

         read_hi         = "  0   0   1   0    1   0   0   0",
                           "  0   0   0   0   a11 a10 a9  a8",
                           " a7  a6  a5  a4   a3  a2  a1  a0",
                           "  o   o   o   o    o   o   o   o";

         loadpage_lo     = "  0   1   0   0    0   0   0   0",
                           "  0   0   0   x    x   x   x   x",
                           "  x   x   x  a4   a3  a2  a1  a0",
                           "  i   i   i   i    i   i   i   i";

         loadpage_hi     = "  0   1   0   0    1   0   0   0",
                           "  0   0   0   x    x   x   x   x",
                           "  x   x   x  a4   a3  a2  a1  a0",
                           "  i   i   i   i    i   i   i   i";

         writepage       = "  0  1  0  0   1   1   0   0",
                           "  0  0  0  0   a11 a10 a9  a8",
                           " a7 a6 a5  x   x   x   x   x",
                           "  x  x  x  x   x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 64;
	readsize	= 256;
       ;
     memory "signature"
         size            = 3;
         read            = "0  0  1  1   0  0  0  0   0  0  x  x   x  x  x  x",
                           "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
       ;
     memory "lock"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 1 1 x  x x x x",
                           "x x x x  x x x x  1 1 i i  i i i i";

         read            = "0 1 0 1  1 0 0 0  0 0 0 0  0 0 0 0",
                           "x x x x  x x x x  x x o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "lfuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                           "x x x x  x x x x  i i i i  i i i i";

         read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "hfuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                           "x x x x  x x x x  i i i i  i i i i";

         read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "efuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                           "x x x x  x x x x  x x x x  x x x i";

         read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
     ;

     memory "calibration"
         size            = 1;
         read            = "0  0  1  1   1  0  0  0    0 0 0 x  x x x x",
                           "0  0  0  0   0  0  0  0    o o o o  o o o o";
     ;
  ;

#------------------------------------------------------------
# ATtiny25
#------------------------------------------------------------

part
     id            = "t25";
     desc          = "ATtiny25";
     has_debugwire = yes;
     flash_instr   = 0xB4, 0x02, 0x12;
     eeprom_instr  = 0xBB, 0xFF, 0xBB, 0xEE, 0xBB, 0xCC, 0xB2, 0x0D,
	             0xBC, 0x02, 0xB4, 0x02, 0xBA, 0x0D, 0xBB, 0xBC,
	             0x99, 0xE1, 0xBB, 0xAC;
## no STK500 devcode in XML file, use the ATtiny45 one
     stk500_devcode   = 0x14;
##  avr910_devcode   = ?;
##  Try the AT90S2313 devcode:
     avr910_devcode   = 0x20;
     signature        = 0x1e 0x91 0x08;
     reset            = io;
     chip_erase_delay = 4500;

     pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                        "x x x x  x x x x    x x x x  x x x x";

     chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                        "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    hvsp_controlstack   =
        0x4C, 0x0C, 0x1C, 0x2C, 0x3C, 0x64, 0x74, 0x66,
        0x68, 0x78, 0x68, 0x68, 0x7A, 0x6A, 0x68, 0x78,
        0x78, 0x7D, 0x6D, 0x0C, 0x80, 0x40, 0x20, 0x10,
        0x11, 0x08, 0x04, 0x02, 0x03, 0x08, 0x04, 0x00;
    hventerstabdelay    = 100;
    hvspcmdexedelay     = 0;
    synchcycles         = 6;
    latchcycles         = 1;
    togglevtg           = 1;
    poweroffdelay       = 25;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 100;
    resetdelay          = 25;
    chiperasepolltimeout = 40;
    chiperasetime       = 0;
    programfusepolltimeout = 25;
    programlockpolltimeout = 25;

     memory "eeprom"
         size            = 128;
        paged           = no;
        page_size       = 4;
         min_write_delay = 4000;
         max_write_delay = 4500;
         readback_p1     = 0xff;
         readback_p2     = 0xff;
         read            = "1  0  1  0   0  0  0  0   0 0 0 x  x x x x",
                           "x a6 a5 a4  a3 a2 a1 a0   o o o o  o o o o";

         write           = "1  1  0  0   0  0  0  0   0 0 0 x  x x x x",
                           "x a6 a5 a4  a3 a2 a1 a0   i i i i  i i i i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x   x   x",
			  "  x  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 4;
	readsize	= 256;
       ;
     memory "flash"
         paged           = yes;
         size            = 2048;
         page_size       = 32;
         num_pages       = 64;
         min_write_delay = 4500;
         max_write_delay = 4500;
         readback_p1     = 0xff;
         readback_p2     = 0xff;
         read_lo         = "  0   0   1   0    0   0   0   0",
                           "  0   0   0   0    0   0  a9  a8",
                           " a7  a6  a5  a4   a3  a2  a1  a0",
                           "  o   o   o   o    o   o   o   o";

         read_hi         = "  0   0   1   0    1   0   0   0",
                           "  0   0   0   0    0   0  a9  a8",
                           " a7  a6  a5  a4   a3  a2  a1  a0",
                           "  o   o   o   o    o   o   o   o";

         loadpage_lo     = "  0   1   0   0    0   0   0   0",
                           "  0   0   0   x    x   x   x   x",
                           "  x   x   x   x   a3  a2  a1  a0",
                           "  i   i   i   i    i   i   i   i";

         loadpage_hi     = "  0   1   0   0    1   0   0   0",
                           "  0   0   0   x    x   x   x   x",
                           "  x   x   x   x   a3  a2  a1  a0",
                           "  i   i   i   i    i   i   i   i";

         writepage       = "  0  1  0  0   1  1  0  0",
                           "  0  0  0  0   0  0 a9 a8",
                           " a7 a6 a5 a4   x  x  x  x",
                           "  x  x  x  x   x  x  x  x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 32;
	readsize	= 256;
       ;
#   ATtiny25 has Signature Bytes: 0x1E 0x91 0x08.
     memory "signature"
         size            = 3;
         read            = "0  0  1  1   0  0  0  0   0  0  0  x   x  x  x  x",
                           "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
       ;
     memory "lock"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 1 1 x  x x x x",
                           "x x x x  x x x x  1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "lfuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                           "x x x x  x x x x  i i i i  i i i i";

         read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "hfuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                           "x x x x  x x x x  i i i i  i i i i";

         read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "efuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                           "x x x x  x x x x  x x x x  x x x i";

         read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
     ;

     memory "calibration"
         size            = 2;
         read            = "0  0  1  1   1  0  0  0    0 0 0 x  x x x x",
                           "0  0  0  0   0  0  0  a0   o o o o  o o o o";
     ;
  ;

#------------------------------------------------------------
# ATtiny45
#------------------------------------------------------------

part
     id            = "t45";
     desc          = "ATtiny45";
     has_debugwire = yes;
     flash_instr   = 0xB4, 0x02, 0x12;
     eeprom_instr  = 0xBB, 0xFF, 0xBB, 0xEE, 0xBB, 0xCC, 0xB2, 0x0D,
	             0xBC, 0x02, 0xB4, 0x02, 0xBA, 0x0D, 0xBB, 0xBC,
	             0x99, 0xE1, 0xBB, 0xAC;
     stk500_devcode   = 0x14;
##  avr910_devcode   = ?;
##  Try the AT90S2313 devcode:
     avr910_devcode   = 0x20;
     signature        = 0x1e 0x92 0x06;
     reset            = io;
     chip_erase_delay = 4500;

     pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                        "x x x x  x x x x    x x x x  x x x x";

     chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                        "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    hvsp_controlstack     =
	0x4C, 0x0C, 0x1C, 0x2C, 0x3C, 0x64, 0x74, 0x66,
        0x68, 0x78, 0x68, 0x68, 0x7A, 0x6A, 0x68, 0x78,
        0x78, 0x7D, 0x6D, 0x0C, 0x80, 0x40, 0x20, 0x10,
        0x11, 0x08, 0x04, 0x02, 0x03, 0x08, 0x04, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    hvspcmdexedelay     = 0;
    synchcycles         = 6;
    latchcycles         = 1;
    togglevtg           = 1;
    poweroffdelay       = 25;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 100;
    resetdelay          = 25;
    chiperasepolltimeout = 40;
    chiperasetime       = 0;
    programfusepolltimeout = 25;
    programlockpolltimeout = 25;

     memory "eeprom"
         size            = 256;
         page_size       = 4;
         min_write_delay = 4000;
         max_write_delay = 4500;
         readback_p1     = 0xff;
         readback_p2     = 0xff;
         read            = "1  0  1  0   0  0  0  0    0 0 0 x  x x x x",
                           "a7 a6 a5 a4  a3 a2 a1 a0   o o o o  o o o o";

         write           = "1  1  0  0   0  0  0  0    0 0 0 x  x x x x",
                           "a7 a6 a5 a4  a3 a2 a1 a0   i i i i  i i i i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x   x   x",
			  " a7  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 4;
	readsize	= 256;
       ;
     memory "flash"
         paged           = yes;
         size            = 4096;
         page_size       = 64;
         num_pages       = 64;
         min_write_delay = 4500;
         max_write_delay = 4500;
         readback_p1     = 0xff;
         readback_p2     = 0xff;
         read_lo         = "  0   0   1   0    0   0   0   0",
                           "  0   0   0   0    0  a10 a9  a8",
                           " a7  a6  a5  a4   a3  a2  a1  a0",
                           "  o   o   o   o    o   o   o   o";

         read_hi         = "  0   0   1   0    1   0   0   0",
                           "  0   0   0   0    0  a10 a9  a8",
                           " a7  a6  a5  a4   a3  a2  a1  a0",
                           "  o   o   o   o    o   o   o   o";

         loadpage_lo     = "  0   1   0   0    0   0   0   0",
                           "  0   0   0   x    x   x   x   x",
                           "  x   x   x  a4   a3  a2  a1  a0",
                           "  i   i   i   i    i   i   i   i";

         loadpage_hi     = "  0   1   0   0    1   0   0   0",
                           "  0   0   0   x    x   x   x   x",
                           "  x   x   x  a4   a3  a2  a1  a0",
                           "  i   i   i   i    i   i   i   i";

         writepage       = "  0  1  0  0   1  1  0  0",
                           "  0  0  0  0   0 a10 a9 a8",
                           " a7 a6 a5  x   x  x  x  x",
                           "  x  x  x  x   x  x  x  x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 32;
	readsize	= 256;
       ;
#   ATtiny45 has Signature Bytes: 0x1E 0x92 0x08. (Data sheet 2586C-AVR-06/05 (doc2586.pdf) indicates otherwise!)
     memory "signature"
         size            = 3;
         read            = "0  0  1  1   0  0  0  0   0  0  0  x   x  x  x  x",
                           "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
       ;
     memory "lock"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 1 1 x  x x x x",
                           "x x x x  x x x x  1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "lfuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                           "x x x x  x x x x  i i i i  i i i i";

         read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "hfuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                           "x x x x  x x x x  i i i i  i i i i";

         read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "efuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                           "x x x x  x x x x  x x x x  x x x i";

         read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
     ;

     memory "calibration"
         size            = 2;
         read            = "0  0  1  1   1  0  0  0    0 0 0 x  x x x x",
                           "0  0  0  0   0  0  0  a0   o o o o  o o o o";
     ;
  ;

#------------------------------------------------------------
# ATtiny85
#------------------------------------------------------------

part
     id            = "t85";
     desc          = "ATtiny85";
     has_debugwire = yes;
     flash_instr   = 0xB4, 0x02, 0x12;
     eeprom_instr  = 0xBB, 0xFF, 0xBB, 0xEE, 0xBB, 0xCC, 0xB2, 0x0D,
	             0xBC, 0x02, 0xB4, 0x02, 0xBA, 0x0D, 0xBB, 0xBC,
	             0x99, 0xE1, 0xBB, 0xAC;
## no STK500 devcode in XML file, use the ATtiny45 one
     stk500_devcode   = 0x14;
##  avr910_devcode   = ?;
##  Try the AT90S2313 devcode:
     avr910_devcode   = 0x20;
     signature        = 0x1e 0x93 0x0b;
     reset            = io;
     chip_erase_delay = 4500;

     pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                        "x x x x  x x x x    x x x x  x x x x";

     chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                        "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    hvsp_controlstack   =
        0x4C, 0x0C, 0x1C, 0x2C, 0x3C, 0x64, 0x74, 0x66,
        0x68, 0x78, 0x68, 0x68, 0x7A, 0x6A, 0x68, 0x78,
        0x78, 0x7D, 0x6D, 0x0C, 0x80, 0x40, 0x20, 0x10,
        0x11, 0x08, 0x04, 0x02, 0x03, 0x08, 0x04, 0x00;
    hventerstabdelay    = 100;
    hvspcmdexedelay     = 0;
    synchcycles         = 6;
    latchcycles         = 1;
    togglevtg           = 1;
    poweroffdelay       = 25;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 100;
    resetdelay          = 25;
    chiperasepolltimeout = 40;
    chiperasetime       = 0;
    programfusepolltimeout = 25;
    programlockpolltimeout = 25;

     memory "eeprom"
         size            = 512;
        paged           = no;
        page_size       = 4;
         min_write_delay = 4000;
         max_write_delay = 4500;
         readback_p1     = 0xff;
         readback_p2     = 0xff;
         read            = "1  0  1  0   0  0  0  0    0 0 0 x  x x x a8",
                           "a7 a6 a5 a4  a3 a2 a1 a0   o o o o  o o o o";

         write           = "1  1  0  0   0  0  0  0    0 0 0 x  x x x a8",
                           "a8 a6 a5 a4  a3 a2 a1 a0   i i i i  i i i i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x   x  a8",
			  " a7  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 4;
	readsize	= 256;
       ;
     memory "flash"
         paged           = yes;
         size            = 8192;
         page_size       = 64;
         num_pages       = 128;
         min_write_delay = 4500;
         max_write_delay = 4500;
         readback_p1     = 0xff;
         readback_p2     = 0xff;
         read_lo         = "  0   0   1   0    0   0   0   0",
                           "  0   0   0   0  a11 a10  a9  a8",
                           " a7  a6  a5  a4   a3  a2  a1  a0",
                           "  o   o   o   o    o   o   o   o";

         read_hi         = "  0   0   1   0    1   0   0   0",
                           "  0   0   0   0  a11 a10  a9  a8",
                           " a7  a6  a5  a4   a3  a2  a1  a0",
                           "  o   o   o   o    o   o   o   o";

         loadpage_lo     = "  0   1   0   0    0   0   0   0",
                           "  0   0   0   x    x   x   x   x",
                           "  x   x   x  a4   a3  a2  a1  a0",
                           "  i   i   i   i    i   i   i   i";

         loadpage_hi     = "  0   1   0   0    1   0   0   0",
                           "  0   0   0   x    x   x   x   x",
                           "  x   x   x  a4   a3  a2  a1  a0",
                           "  i   i   i   i    i   i   i   i";

         writepage       = "  0  1  0  0   1   1   0  0",
                           "  0  0  0  0  a11 a10 a9 a8",
                           " a7 a6 a5  x   x  x  x  x",
                           "  x  x  x  x   x  x  x  x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 32;
	readsize	= 256;
       ;
#   ATtiny85 has Signature Bytes: 0x1E 0x93 0x08.
     memory "signature"
         size            = 3;
         read            = "0  0  1  1   0  0  0  0   0  0  0  x   x  x  x  x",
                           "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
       ;
     memory "lock"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 1 1 x  x x x x",
                           "x x x x  x x x x  1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "lfuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                           "x x x x  x x x x  i i i i  i i i i";

         read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "hfuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                           "x x x x  x x x x  i i i i  i i i i";

         read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "efuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                           "x x x x  x x x x  x x x x  x x x i";

         read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
     ;

     memory "calibration"
         size            = 2;
         read            = "0  0  1  1   1  0  0  0    0 0 0 x  x x x x",
                           "0  0  0  0   0  0  0  a0   o o o o  o o o o";
     ;
  ;

#------------------------------------------------------------
# ATmega640
#------------------------------------------------------------
# Almost same as ATmega1280, except for different memory sizes

part
    id               = "m640";
    desc             = "ATMEGA640";
    signature        = 0x1e 0x96 0x08;
    has_jtag         = yes;
#    stk500_devcode   = 0xB2;
#    avr910_devcode   = 0x43;
    chip_erase_delay = 9000;
    pagel            = 0xD7;
    bs2              = 0xA0;
    reset            = dedicated;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    rampz               = 0x3b;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 4096;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0  a2  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x    a11 a10  a9  a8",
			  " a7  a6  a5  a4     a3   0   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 8;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 65536;
        page_size       = 256;
        num_pages       = 256;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "  0 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "  0 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  0 a14 a13 a12    a11 a10  a9  a8",
                          " a7   x   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  x x x x  x i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0    x x x x  x x x x",
                          "0 0 0 0  0 0 0 0    o o o o  o o o o";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;

#------------------------------------------------------------
# ATmega1280
#------------------------------------------------------------

part
    id               = "m1280";
    desc             = "ATMEGA1280";
    signature        = 0x1e 0x97 0x03;
    has_jtag         = yes;
#    stk500_devcode   = 0xB2;
#    avr910_devcode   = 0x43;
    chip_erase_delay = 9000;
    pagel            = 0xD7;
    bs2              = 0xA0;
    reset            = dedicated;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    rampz               = 0x3b;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 4096;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0  a2  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x    a11 a10  a9  a8",
			  " a7  a6  a5  a4     a3   0   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 8;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 131072;
        page_size       = 256;
        num_pages       = 512;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7   x   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  x x x x  x i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0    x x x x  x x x x",
                          "0 0 0 0  0 0 0 0    o o o o  o o o o";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;

#------------------------------------------------------------
# ATmega1281
#------------------------------------------------------------
# Identical to ATmega1280

part
    id               = "m1281";
    desc             = "ATMEGA1281";
    signature        = 0x1e 0x97 0x04;
    has_jtag         = yes;
#    stk500_devcode   = 0xB2;
#    avr910_devcode   = 0x43;
    chip_erase_delay = 9000;
    pagel            = 0xD7;
    bs2              = 0xA0;
    reset            = dedicated;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    rampz               = 0x3b;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 4096;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0  a2  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x    a11 a10  a9  a8",
			  " a7  a6  a5  a4     a3   0   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 8;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 131072;
        page_size       = 256;
        num_pages       = 512;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7   x   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  x x x x  x i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0    x x x x  x x x x",
                          "0 0 0 0  0 0 0 0    o o o o  o o o o";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;

#------------------------------------------------------------
# ATmega2560
#------------------------------------------------------------

part
    id               = "m2560";
    desc             = "ATMEGA2560";
    signature        = 0x1e 0x98 0x01;
    has_jtag         = yes;
#    stk500_devcode   = 0xB2;
#    avr910_devcode   = 0x43;
    chip_erase_delay = 9000;
    pagel            = 0xD7;
    bs2              = 0xA0;
    reset            = dedicated;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x02;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    rampz               = 0x3b;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 4096;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0  a2  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x    a11 a10  a9  a8",
			  " a7  a6  a5  a4     a3   0   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 8;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 262144;
        page_size       = 256;
        num_pages       = 1024;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7   x   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

        load_ext_addr   = "  0   1   0   0      1   1   0   1",
                          "  0   0   0   0      0   0   0   0",
                          "  0   0   0   0      0   0   0 a16",
                          "  0   0   0   0      0   0   0   0";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  x x x x  x i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0    x x x x  x x x x",
                          "0 0 0 0  0 0 0 0    o o o o  o o o o";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;

#------------------------------------------------------------
# ATmega2561
#------------------------------------------------------------

part
    id               = "m2561";
    desc             = "ATMEGA2561";
    signature        = 0x1e 0x98 0x02;
    has_jtag         = yes;
#    stk500_devcode   = 0xB2;
#    avr910_devcode   = 0x43;
    chip_erase_delay = 9000;
    pagel            = 0xD7;
    bs2              = 0xA0;
    reset            = dedicated;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x02;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    rampz               = 0x3b;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 4096;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0  a2  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x    a11 a10  a9  a8",
			  " a7  a6  a5  a4     a3   0   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 8;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 262144;
        page_size       = 256;
        num_pages       = 1024;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7   x   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

        load_ext_addr   = "  0   1   0   0      1   1   0   1",
                          "  0   0   0   0      0   0   0   0",
                          "  0   0   0   0      0   0   0 a16",
                          "  0   0   0   0      0   0   0   0";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  x x x x  x i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0    x x x x  x x x x",
                          "0 0 0 0  0 0 0 0    o o o o  o o o o";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;

#------------------------------------------------------------
# ATmega128RFA1
#------------------------------------------------------------
# Identical to ATmega2561 but half the ROM

part
    id               = "m128rfa1";
    desc             = "ATMEGA128RFA1";
    signature        = 0x1e 0xa7 0x01;
    has_jtag         = yes;
#    stk500_devcode   = 0xB2;
#    avr910_devcode   = 0x43;
    chip_erase_delay = 9000;
    pagel            = 0xD7;
    bs2              = 0xE2;
    reset            = dedicated;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x02;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    rampz               = 0x3b;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 4096;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0  a2  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x    a11 a10  a9  a8",
			  " a7  a6  a5  a4     a3   0   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 8;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 131072;
        page_size       = 256;
        num_pages       = 512;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7   x   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  x x x x  x i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0    x x x x  x x x x",
                          "0 0 0 0  0 0 0 0    o o o o  o o o o";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;

#------------------------------------------------------------
# ATtiny24
#------------------------------------------------------------

part
     id            = "t24";
     desc          = "ATtiny24";
     has_debugwire = yes;
     flash_instr   = 0xB4, 0x07, 0x17;
     eeprom_instr  = 0xBB, 0xFF, 0xBB, 0xEE, 0xBB, 0xCC, 0xB2, 0x0D,
	             0xBC, 0x07, 0xB4, 0x07, 0xBA, 0x0D, 0xBB, 0xBC,
	             0x99, 0xE1, 0xBB, 0xAC;
## no STK500 devcode in XML file, use the ATtiny45 one
     stk500_devcode   = 0x14;
##  avr910_devcode   = ?;
##  Try the AT90S2313 devcode:
     avr910_devcode   = 0x20;
     signature        = 0x1e 0x91 0x0b;
     reset            = io;
     chip_erase_delay = 4500;

     pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                        "x x x x  x x x x    x x x x  x x x x";

     chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                        "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    hvsp_controlstack   =
        0x4C, 0x0C, 0x1C, 0x2C, 0x3C, 0x64, 0x74, 0x66,
        0x68, 0x78, 0x68, 0x68, 0x7A, 0x6A, 0x68, 0x78,
        0x78, 0x7D, 0x6D, 0x0C, 0x80, 0x40, 0x20, 0x10,
        0x11, 0x08, 0x04, 0x02, 0x03, 0x08, 0x04, 0x0F;
    hventerstabdelay    = 100;
    hvspcmdexedelay     = 0;
    synchcycles         = 6;
    latchcycles         = 1;
    togglevtg           = 1;
    poweroffdelay       = 25;
    resetdelayms        = 0;
    resetdelayus        = 70;
    hvleavestabdelay    = 100;
    resetdelay          = 25;
    chiperasepolltimeout = 40;
    chiperasetime       = 0;
    programfusepolltimeout = 25;
    programlockpolltimeout = 25;

     memory "eeprom"
         size            = 128;
        paged           = no;
        page_size       = 4;
         min_write_delay = 4000;
         max_write_delay = 4500;
         readback_p1     = 0xff;
         readback_p2     = 0xff;
         read            = "1  0  1  0   0  0  0  0   0 0 0 x  x x x x",
                           "x a6 a5 a4  a3 a2 a1 a0   o o o o  o o o o";

         write           = "1  1  0  0   0  0  0  0   0 0 0 x  x x x x",
                           "x a6 a5 a4  a3 a2 a1 a0   i i i i  i i i i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x   x   x",
			  "  x  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 4;
	readsize	= 256;
       ;
     memory "flash"
         paged           = yes;
         size            = 2048;
         page_size       = 32;
         num_pages       = 64;
         min_write_delay = 4500;
         max_write_delay = 4500;
         readback_p1     = 0xff;
         readback_p2     = 0xff;
         read_lo         = "  0   0   1   0    0   0   0   0",
                           "  0   0   0   0    0   0  a9  a8",
                           " a7  a6  a5  a4   a3  a2  a1  a0",
                           "  o   o   o   o    o   o   o   o";

         read_hi         = "  0   0   1   0    1   0   0   0",
                           "  0   0   0   0    0   0  a9  a8",
                           " a7  a6  a5  a4   a3  a2  a1  a0",
                           "  o   o   o   o    o   o   o   o";

         loadpage_lo     = "  0   1   0   0    0   0   0   0",
                           "  0   0   0   x    x   x   x   x",
                           "  x   x   x   x   a3  a2  a1  a0",
                           "  i   i   i   i    i   i   i   i";

         loadpage_hi     = "  0   1   0   0    1   0   0   0",
                           "  0   0   0   x    x   x   x   x",
                           "  x   x   x   x   a3  a2  a1  a0",
                           "  i   i   i   i    i   i   i   i";

         writepage       = "  0  1  0  0   1  1  0  0",
                           "  0  0  0  0   0  0 a9 a8",
                           " a7 a6 a5 a4   x  x  x  x",
                           "  x  x  x  x   x  x  x  x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 32;
	readsize	= 256;
       ;
#   ATtiny24 has Signature Bytes: 0x1E 0x91 0x0B.
     memory "signature"
         size            = 3;
         read            = "0  0  1  1   0  0  0  0   0  0  0  x   x  x  x  x",
                           "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
       ;
     memory "lock"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 1 1 x  x x x x",
                           "x x x x  x x x x  x x x x  x x i i";
         read            = "0 1 0 1  1 0 0 0  0 0 0 0  0 0 0 0",
                           "0 0 0 0  0 0 0 0  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "lfuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                           "x x x x  x x x x  i i i i  i i i i";

         read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "hfuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                           "x x x x  x x x x  i i i i  i i i i";

         read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "efuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                           "x x x x  x x x x  x x x x  x x x i";

         read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
     ;

     memory "calibration"
         size            = 1;
         read            = "0  0  1  1   1  0  0  0    0 0 0 x  x x x x",
                           "0  0  0  0   0  0  0  a0   o o o o  o o o o";
     ;
  ;

#------------------------------------------------------------
# ATtiny44
#------------------------------------------------------------

part
     id            = "t44";
     desc          = "ATtiny44";
     has_debugwire = yes;
     flash_instr   = 0xB4, 0x07, 0x17;
     eeprom_instr  = 0xBB, 0xFF, 0xBB, 0xEE, 0xBB, 0xCC, 0xB2, 0x0D,
                     0xBC, 0x07, 0xB4, 0x07, 0xBA, 0x0D, 0xBB, 0xBC,
                     0x99, 0xE1, 0xBB, 0xAC;
## no STK500 devcode in XML file, use the ATtiny45 one
     stk500_devcode   = 0x14;
##  avr910_devcode   = ?;
##  Try the AT90S2313 devcode:
     avr910_devcode   = 0x20;
     signature        = 0x1e 0x92 0x07;
     reset            = io;
     chip_erase_delay = 4500;

     pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                        "x x x x  x x x x    x x x x  x x x x";

     chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                        "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    hvsp_controlstack   =
        0x4C, 0x0C, 0x1C, 0x2C, 0x3C, 0x64, 0x74, 0x66,
        0x68, 0x78, 0x68, 0x68, 0x7A, 0x6A, 0x68, 0x78,
        0x78, 0x7D, 0x6D, 0x0C, 0x80, 0x40, 0x20, 0x10,
        0x11, 0x08, 0x04, 0x02, 0x03, 0x08, 0x04, 0x0F;
    hventerstabdelay    = 100;
    hvspcmdexedelay     = 0;
    synchcycles         = 6;
    latchcycles         = 1;
    togglevtg           = 1;
    poweroffdelay       = 25;
    resetdelayms        = 0;
    resetdelayus        = 70;
    hvleavestabdelay    = 100;
    resetdelay          = 25;
    chiperasepolltimeout = 40;
    chiperasetime       = 0;
    programfusepolltimeout = 25;
    programlockpolltimeout = 25;

     memory "eeprom"
         size            = 256;
        paged           = no;
        page_size       = 4;
         min_write_delay = 4000;
         max_write_delay = 4500;
         readback_p1     = 0xff;
         readback_p2     = 0xff;
         read            = "1  0  1  0   0  0  0  0    0 0 0 x  x x x x",
                           "a7 a6 a5 a4  a3 a2 a1 a0   o o o o  o o o o";

         write           = "1  1  0  0   0  0  0  0    0 0 0 x  x x x x",
                           "a7 a6 a5 a4  a3 a2 a1 a0   i i i i  i i i i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x   x   x",
			  "  x  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 4;
	readsize	= 256;
       ;
     memory "flash"
         paged           = yes;
         size            = 4096;
         page_size       = 64;
         num_pages       = 64;
         min_write_delay = 4500;
         max_write_delay = 4500;
         readback_p1     = 0xff;
         readback_p2     = 0xff;
         read_lo         = "  0   0   1   0    0   0   0   0",
                           "  0   0   0   0    0  a10 a9  a8",
                           " a7  a6  a5  a4   a3  a2  a1  a0",
                           "  o   o   o   o    o   o   o   o";

         read_hi         = "  0   0   1   0    1   0   0   0",
                           "  0   0   0   0    0  a10 a9  a8",
                           " a7  a6  a5  a4   a3  a2  a1  a0",
                           "  o   o   o   o    o   o   o   o";

         loadpage_lo     = "  0   1   0   0    0   0   0   0",
                           "  0   0   0   x    x   x   x   x",
                           "  x   x   x  a4   a3  a2  a1  a0",
                           "  i   i   i   i    i   i   i   i";

         loadpage_hi     = "  0   1   0   0    1   0   0   0",
                           "  0   0   0   x    x   x   x   x",
                           "  x   x   x  a4   a3  a2  a1  a0",
                           "  i   i   i   i    i   i   i   i";

         writepage       = "  0  1  0  0   1  1  0  0",
                           "  0  0  0  0   0 a10 a9 a8",
                           " a7 a6 a5  x   x  x  x  x",
                           "  x  x  x  x   x  x  x  x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 32;
	readsize	= 256;
       ;
#   ATtiny44 has Signature Bytes: 0x1E 0x92 0x07.
     memory "signature"
         size            = 3;
         read            = "0  0  1  1   0  0  0  0   0  0  0  x   x  x  x  x",
                           "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
       ;
     memory "lock"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 1 1 x  x x x x",
                           "x x x x  x x x x  x x x x  x x i i";
         read            = "0 1 0 1  1 0 0 0  0 0 0 0  0 0 0 0",
                           "0 0 0 0  0 0 0 0  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "lfuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                           "x x x x  x x x x  i i i i  i i i i";

         read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "hfuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                           "x x x x  x x x x  i i i i  i i i i";

         read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "efuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                           "x x x x  x x x x  x x x x  x x x i";

         read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
     ;

     memory "calibration"
         size            = 1;
         read            = "0  0  1  1   1  0  0  0    0 0 0 x  x x x x",
                           "0  0  0  0   0  0  0  a0   o o o o  o o o o";
     ;
  ;

#------------------------------------------------------------
# ATtiny84
#------------------------------------------------------------

part
     id            = "t84";
     desc          = "ATtiny84";
     has_debugwire = yes;
     flash_instr   = 0xB4, 0x07, 0x17;
     eeprom_instr  = 0xBB, 0xFF, 0xBB, 0xEE, 0xBB, 0xCC, 0xB2, 0x0D,
	             0xBC, 0x07, 0xB4, 0x07, 0xBA, 0x0D, 0xBB, 0xBC,
	             0x99, 0xE1, 0xBB, 0xAC;
## no STK500 devcode in XML file, use the ATtiny45 one
     stk500_devcode   = 0x14;
##  avr910_devcode   = ?;
##  Try the AT90S2313 devcode:
     avr910_devcode   = 0x20;
     signature        = 0x1e 0x93 0x0c;
     reset            = io;
     chip_erase_delay = 4500;

     pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                        "x x x x  x x x x    x x x x  x x x x";

     chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                        "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    hvsp_controlstack   =
        0x4C, 0x0C, 0x1C, 0x2C, 0x3C, 0x64, 0x74, 0x66,
        0x68, 0x78, 0x68, 0x68, 0x7A, 0x6A, 0x68, 0x78,
        0x78, 0x7D, 0x6D, 0x0C, 0x80, 0x40, 0x20, 0x10,
        0x11, 0x08, 0x04, 0x02, 0x03, 0x08, 0x04, 0x0F;
    hventerstabdelay    = 100;
    hvspcmdexedelay     = 0;
    synchcycles         = 6;
    latchcycles         = 1;
    togglevtg           = 1;
    poweroffdelay       = 25;
    resetdelayms        = 0;
    resetdelayus        = 70;
    hvleavestabdelay    = 100;
    resetdelay          = 25;
    chiperasepolltimeout = 40;
    chiperasetime       = 0;
    programfusepolltimeout = 25;
    programlockpolltimeout = 25;

     memory "eeprom"
         size            = 512;
        paged           = no;
        page_size       = 4;
         min_write_delay = 4000;
         max_write_delay = 4500;
         readback_p1     = 0xff;
         readback_p2     = 0xff;
         read            = "1  0  1  0   0  0  0  0    0 0 0 x  x x x a8",
                           "a7 a6 a5 a4  a3 a2 a1 a0   o o o o  o o o o";

         write           = "1  1  0  0   0  0  0  0    0 0 0 x  x x x a8",
                           "a8 a6 a5 a4  a3 a2 a1 a0   i i i i  i i i i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x   x   x   x",
			  "  x  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 4;
	readsize	= 256;
       ;
     memory "flash"
         paged           = yes;
         size            = 8192;
         page_size       = 64;
         num_pages       = 128;
         min_write_delay = 4500;
         max_write_delay = 4500;
         readback_p1     = 0xff;
         readback_p2     = 0xff;
         read_lo         = "  0   0   1   0    0   0   0   0",
                           "  0   0   0   0  a11 a10  a9  a8",
                           " a7  a6  a5  a4   a3  a2  a1  a0",
                           "  o   o   o   o    o   o   o   o";

         read_hi         = "  0   0   1   0    1   0   0   0",
                           "  0   0   0   0  a11 a10  a9  a8",
                           " a7  a6  a5  a4   a3  a2  a1  a0",
                           "  o   o   o   o    o   o   o   o";

         loadpage_lo     = "  0   1   0   0    0   0   0   0",
                           "  0   0   0   x    x   x   x   x",
                           "  x   x   x  a4   a3  a2  a1  a0",
                           "  i   i   i   i    i   i   i   i";

         loadpage_hi     = "  0   1   0   0    1   0   0   0",
                           "  0   0   0   x    x   x   x   x",
                           "  x   x   x  a4   a3  a2  a1  a0",
                           "  i   i   i   i    i   i   i   i";

         writepage       = "  0  1  0  0   1   1   0  0",
                           "  0  0  0  0  a11 a10 a9 a8",
                           " a7 a6 a5  x   x  x  x  x",
                           "  x  x  x  x   x  x  x  x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 32;
	readsize	= 256;
       ;
#   ATtiny84 has Signature Bytes: 0x1E 0x93 0x0C.
     memory "signature"
         size            = 3;
         read            = "0  0  1  1   0  0  0  0   0  0  0  x   x  x  x  x",
                           "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
       ;

     memory "lock"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 1 1 x  x x x x",
                           "x x x x  x x x x  x x x x  x x i i";
         read            = "0 1 0 1  1 0 0 0  0 0 0 0  0 0 0 0",
                           "0 0 0 0  0 0 0 0  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "lfuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                           "x x x x  x x x x  i i i i  i i i i";

         read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "hfuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                           "x x x x  x x x x  i i i i  i i i i";

         read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
       ;

     memory "efuse"
         size            = 1;
         write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                           "x x x x  x x x x  x x x x  x x x i";

         read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                           "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
     ;

     memory "calibration"
         size            = 1;
         read            = "0  0  1  1   1  0  0  0    0 0 0 x  x x x x",
                           "0  0  0  0   0  0  0  a0   o o o o  o o o o";
     ;
  ;

#------------------------------------------------------------
# ATmega32u4
#------------------------------------------------------------

part
    id               = "m32u4";
    desc             = "ATmega32U4";
    signature        = 0x1e 0x95 0x87;
    has_jtag         = yes;
#    stk500_devcode   = 0xB2;
#    avr910_devcode   = 0x43;
    chip_erase_delay = 9000;
    pagel            = 0xD7;
    bs2              = 0xA0;
    reset            = dedicated;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    rampz               = 0x3b;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 1024;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x      x a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x      x a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0  a2  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x a10  a9  a8",
			  " a7  a6  a5  a4     a3   0   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 8;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 32768;
        page_size       = 128;
        num_pages       = 256;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "  0 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "  0 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          " a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 128;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  x x x x  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0    x x x x  x x x x",
                          "0 0 0 0  0 0 0 0    o o o o  o o o o";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;

#------------------------------------------------------------
# AT90USB646
#------------------------------------------------------------

part
    id               = "usb646";
    desc             = "AT90USB646";
    signature        = 0x1e 0x96 0x82;
    has_jtag         = yes;
#    stk500_devcode   = 0xB2;
#    avr910_devcode   = 0x43;
    chip_erase_delay = 9000;
    pagel            = 0xD7;
    bs2              = 0xA0;
    reset            = dedicated;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    rampz               = 0x3b;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 2048;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x      x a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x      x a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0  a2  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x a10  a9  a8",
			  " a7  a6  a5  a4     a3   0   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 8;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 65536;
        page_size       = 256;
        num_pages       = 256;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "  0 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "  0 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  0 a14 a13 a12    a11 a10  a9  a8",
                          " a7   x   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  x x x x  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0    x x x x  x x x x",
                          "0 0 0 0  0 0 0 0    o o o o  o o o o";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;

#------------------------------------------------------------
# AT90USB647
#------------------------------------------------------------
# identical to AT90USB646

part
    id               = "usb647";
    desc             = "AT90USB647";
    signature        = 0x1e 0x96 0x82;
    has_jtag         = yes;
#    stk500_devcode   = 0xB2;
#    avr910_devcode   = 0x43;
    chip_erase_delay = 9000;
    pagel            = 0xD7;
    bs2              = 0xA0;
    reset            = dedicated;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    rampz               = 0x3b;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 2048;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x      x a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x      x a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0  a2  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x a10  a9  a8",
			  " a7  a6  a5  a4     a3   0   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 8;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 65536;
        page_size       = 256;
        num_pages       = 256;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "  0 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "  0 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  0 a14 a13 a12    a11 a10  a9  a8",
                          " a7   x   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  x x x x  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0    x x x x  x x x x",
                          "0 0 0 0  0 0 0 0    o o o o  o o o o";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;

#------------------------------------------------------------
# AT90USB1286
#------------------------------------------------------------

part
    id               = "usb1286";
    desc             = "AT90USB1286";
    signature        = 0x1e 0x97 0x82;
    has_jtag         = yes;
#    stk500_devcode   = 0xB2;
#    avr910_devcode   = 0x43;
    chip_erase_delay = 9000;
    pagel            = 0xD7;
    bs2              = 0xA0;
    reset            = dedicated;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    rampz               = 0x3b;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 4096;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0  a2  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x a10  a9  a8",
			  " a7  a6  a5  a4     a3   0   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 8;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 131072;
        page_size       = 256;
        num_pages       = 512;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7   x   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  x x x x  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0    x x x x  x x x x",
                          "0 0 0 0  0 0 0 0    o o o o  o o o o";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;

#------------------------------------------------------------
# AT90USB1287
#------------------------------------------------------------
# identical to AT90USB1286

part
    id               = "usb1287";
    desc             = "AT90USB1287";
    signature        = 0x1e 0x97 0x82;
    has_jtag         = yes;
#    stk500_devcode   = 0xB2;
#    avr910_devcode   = 0x43;
    chip_erase_delay = 9000;
    pagel            = 0xD7;
    bs2              = 0xA0;
    reset            = dedicated;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "x x x x  x x x x    x x x x  x x x x";

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    rampz               = 0x3b;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 4096;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read            = "  1   0   1   0      0   0   0   0",
                          "  x   x   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        write           = "  1   1   0   0      0   0   0   0",
                          "  x   x   x   x    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0", 
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0  a2  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
			  "  0   0   x   x      x a10  a9  a8",
			  " a7  a6  a5  a4     a3   0   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 10;
	blocksize	= 8;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 131072;
        page_size       = 256;
        num_pages       = 512;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7   x   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 256;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  x x x x  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0    x x x x  x x x x",
                          "0 0 0 0  0 0 0 0    o o o o  o o o o";
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   x  x  x  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;


#------------------------------------------------------------
# AT90USB162
#------------------------------------------------------------

part
    id               = "usb162";
    desc             = "AT90USB162";
    has_jtag         = no;
    has_debugwire    = yes;
    signature        = 0x1e 0x94 0x82;
    chip_erase_delay = 9000;
    reset            = io;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";
    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                       "x x x x  x x x x    x x x x  x x x x";
    pagel            = 0xD7;
    bs2              = 0xC6;

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;
    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 4;  /* for parallel programming */
        size            = 512;
        num_pages       = 128;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   0   0    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   0   0    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
                          "  0   0   0   0    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 20;
	blocksize	= 4;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 16384;
        page_size       = 128;
        num_pages       = 128;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 128;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0    0 0 0 x  x x x x",
                          "0 0 0 0  0 0 0 0    o o o o  o o o o";
      ;
    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   0  0  0  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;

#------------------------------------------------------------
# AT90USB82
#------------------------------------------------------------
# Changes against AT90USB162 (beside IDs)
#    memory "flash"
#        size            = 8192;
#        num_pages       = 64;

part
    id               = "usb82";
    desc             = "AT90USB82";
    has_jtag         = no;
    has_debugwire    = yes;
    signature        = 0x1e 0x93 0x82;
    chip_erase_delay = 9000;
    reset            = io;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "x x x x  x x x x    x x x x  x x x x";
    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 x  x x x x",
                       "x x x x  x x x x    x x x x  x x x x";
    pagel            = 0xD7;
    bs2              = 0xC6;

    timeout		= 200;
    stabdelay		= 100;
    cmdexedelay		= 25;
    synchloops		= 32;
    bytedelay		= 0;
    pollindex		= 3;
    pollvalue		= 0x53;
    predelay		= 1;
    postdelay		= 1;
    pollmethod		= 1;
    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 4;  /* for parallel programming */
        size            = 512;
        num_pages       = 128;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   0   0    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   0   0    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

	loadpage_lo	= "  1   1   0   0      0   0   0   1",
			  "  0   0   0   0      0   0   0   0",
			  "  0   0   0   0      0   0  a1  a0",
			  "  i   i   i   i      i   i   i   i";

	writepage	= "  1   1   0   0      0   0   1   0",
                          "  0   0   0   0    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2   0   0",
			  "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 20;
	blocksize	= 4;
	readsize	= 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 8192;
        page_size       = 128;
        num_pages       = 64;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0x00;
        readback_p2     = 0x00;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  x   x   x   x      x   x   x   x",
                          "  x   x  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "a15 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6   x   x      x   x   x   x",
                          "  x   x   x   x      x   x   x   x";

	mode		= 0x41;
	delay		= 6;
	blocksize	= 128;
	readsize	= 256;
      ;

    memory "lfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  0 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  1 0 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  1 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;
        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "x x x x  x x x x  i i i i  i i i i";

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "x x x x  x x x x  o o o o  o o o o";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 x  x x x x",
                          "x x x x  x x x x   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "calibration"
        size            = 1;
        read            = "0 0 1 1  1 0 0 0    0 0 0 x  x x x x",
                          "0 0 0 0  0 0 0 0    o o o o  o o o o";
      ;
    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   0  0  0  x   x  x  x  x",
                          "x  x  x  x   x  x a1 a0   o  o  o  o   o  o  o  o";
      ;
  ;

#------------------------------------------------------------
# ATmega325
#------------------------------------------------------------

part
    id               = "m325";
    desc             = "ATMEGA325";
    signature        = 0x1e 0x95 0x05;
    has_jtag         = yes;
#   stk500_devcode   = 0x??; # No STK500v1 support?
#   avr910_devcode   = 0x??; # Try the ATmega16 one
    avr910_devcode   = 0x74;
    pagel            = 0xd7;
    bs2              = 0xa0;
    chip_erase_delay = 9000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "0 0 0 0  0 0 0 0    0 0 0 0  0 0 0 0";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "0 0 0 0  0 0 0 0    0 0 0 0  0 0 0 0";

    timeout             = 200;
    stabdelay           = 100;
    cmdexedelay         = 25;
    synchloops          = 32;
    bytedelay           = 0;
    pollindex           = 3;
    pollvalue           = 0x53;
    predelay            = 1;
    postdelay           = 1;
    pollmethod          = 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 4;  /* for parallel programming */
        size            = 1024;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   0   0      0   0  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   0   0      0   0  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_lo     = "  1   1   0   0      0   0   0   1",
                          "  0   0   0   0      0   0   0   0",
                          "  0   0   0   0      0   0  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  1   1   0   0      0   0   1   0",
                          "  0   0   0   0      0   0  a9  a8",
                          " a7  a6  a5  a4     a3  a2   0   0",
                          "  x   x   x   x      x   x   x   x";

        mode            = 0x41;
        delay           = 10;
        blocksize       = 4;
        readsize        = 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 32768;
        page_size       = 128;
        num_pages       = 256;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "  0 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "  0 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  0   0   0   0      0   0   0   0",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  0   0   0   0      0   0   0   0",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  0 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  x   x   x   x      x   x   x   x";

        mode            = 0x41;
        delay           = 10;
        blocksize       = 128;
        readsize        = 256;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 0  0 0 0 0",
                          "0 0 0 0  0 0 0 0   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lfuse"
        size            = 1;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "0 0 0 0  0 0 0 0   i i i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "0 0 0 0  0 0 0 0   i i i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "0 0 0 0  0 0 0 0  o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "0 0 0 0  0 0 0 0  1 1 1 1  1 i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   0  0  0  0   0  0  0  0",
                          "0  0  0  0   0  0 a1 a0   o  o  o  o   o  o  o  o";
      ;

    memory "calibration"
        size            = 1;

        read            = "0 0 1 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";
        ;
  ;

#------------------------------------------------------------
# ATmega645
#------------------------------------------------------------

part
    id               = "m645";
    desc             = "ATMEGA645";
    signature        = 0x1E 0x96 0x05;
    has_jtag         = yes;
#   stk500_devcode   = 0x??; # No STK500v1 support?
#   avr910_devcode   = 0x??; # Try the ATmega16 one
    avr910_devcode   = 0x74;
    pagel            = 0xd7;
    bs2              = 0xa0;
    chip_erase_delay = 9000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "0 0 0 0  0 0 0 0    0 0 0 0  0 0 0 0";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "0 0 0 0  0 0 0 0    0 0 0 0  0 0 0 0";

    timeout             = 200;
    stabdelay           = 100;
    cmdexedelay         = 25;
    synchloops          = 32;
    bytedelay           = 0;
    pollindex           = 3;
    pollvalue           = 0x53;
    predelay            = 1;
    postdelay           = 1;
    pollmethod          = 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 2048;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   0   0      0 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   0   0      0 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_lo     = "  1   1   0   0      0   0   0   1",
                          "  0   0   0   0      0   0   0   0",
                          "  0   0   0   0      0  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  1   1   0   0      0   0   1   0",
                          "  0   0   0   0      0 a10  a9  a8",
                          " a7  a6  a5  a4     a3   0   0   0",
                          "  x   x   x   x      x   x   x   x";

        mode            = 0x41;
        delay           = 10;
        blocksize       = 8;
        readsize        = 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 65536;
        page_size       = 256;
        num_pages       = 256;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "   0   0   1   0      0   0   0   0",
                          " a15 a14 a13 a12    a11 a10  a9  a8",
                          "  a7  a6  a5  a4     a3  a2  a1  a0",
                          "   o   o   o   o      o   o   o   o";

        read_hi         = "   0   0   1   0      1   0   0   0",
                          " a15 a14 a13 a12    a11 a10  a9  a8",
                          "  a7  a6  a5  a4     a3  a2  a1  a0",
                          "   o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  0   0   0   0      0   0   0   0",
                          "  a7 a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  0   0   0   0      0   0   0   0",
                          "  a7 a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "   0   1   0   0      1   1   0   0",
                          " a15 a14 a13 a12    a11 a10  a9  a8",
                          "  a7  a6  a5  a4     a3  a2  a1  a0",
                          "   0   0   0   0      0   0   0   0";

        mode            = 0x41;
        delay           = 10;
        blocksize       = 128;
        readsize        = 256;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 0  0 0 0 0",
                          "0 0 0 0  0 0 0 0   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lfuse"
        size            = 1;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "0 0 0 0  0 0 0 0   i i i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "0 0 0 0  0 0 0 0   i i i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "0 0 0 0  0 0 0 0  o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "0 0 0 0  0 0 0 0  1 1 1 1  1 i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   0  0  0  0   0  0  0  0",
                          "0  0  0  0   0  0 a1 a0   o  o  o  o   o  o  o  o";
      ;

    memory "calibration"
        size            = 1;

        read            = "0 0 1 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";
        ;
  ;

#------------------------------------------------------------
# ATmega3250
#------------------------------------------------------------

part
    id               = "m3250";
    desc             = "ATMEGA3250";
    signature        = 0x1E 0x95 0x06;
    has_jtag         = yes;
#   stk500_devcode   = 0x??; # No STK500v1 support?
#   avr910_devcode   = 0x??; # Try the ATmega16 one
    avr910_devcode   = 0x74;
    pagel            = 0xd7;
    bs2              = 0xa0;
    chip_erase_delay = 9000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "0 0 0 0  0 0 0 0    0 0 0 0  0 0 0 0";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "0 0 0 0  0 0 0 0    0 0 0 0  0 0 0 0";

    timeout             = 200;
    stabdelay           = 100;
    cmdexedelay         = 25;
    synchloops          = 32;
    bytedelay           = 0;
    pollindex           = 3;
    pollvalue           = 0x53;
    predelay            = 1;
    postdelay           = 1;
    pollmethod          = 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 4;  /* for parallel programming */
        size            = 1024;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   0   0      0   0  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   0   0      0   0  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_lo     = "  1   1   0   0      0   0   0   1",
                          "  0   0   0   0      0   0   0   0",
                          "  0   0   0   0      0   0  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  1   1   0   0      0   0   1   0",
                          "  0   0   0   0      0   0  a9  a8",
                          " a7  a6  a5  a4     a3  a2   0   0",
                          "  x   x   x   x      x   x   x   x";

        mode            = 0x41;
        delay           = 10;
        blocksize       = 4;
        readsize        = 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 32768;
        page_size       = 128;
        num_pages       = 256;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "  0   0   1   0      0   0   0   0",
                          "  0 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        read_hi         = "  0   0   1   0      1   0   0   0",
                          "  0 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  0   0   0   0      0   0   0   0",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  0   0   0   0      0   0   0   0",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  0   1   0   0      1   1   0   0",
                          "  0 a14 a13 a12    a11 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  x   x   x   x      x   x   x   x";

        mode            = 0x41;
        delay           = 10;
        blocksize       = 128;
        readsize        = 256;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 0  0 0 0 0",
                          "0 0 0 0  0 0 0 0   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lfuse"
        size            = 1;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "0 0 0 0  0 0 0 0   i i i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "0 0 0 0  0 0 0 0   i i i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "0 0 0 0  0 0 0 0  o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "0 0 0 0  0 0 0 0  1 1 1 1  1 i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   0  0  0  0   0  0  0  0",
                          "0  0  0  0   0  0 a1 a0   o  o  o  o   o  o  o  o";
      ;

    memory "calibration"
        size            = 1;

        read            = "0 0 1 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";
        ;
  ;

#------------------------------------------------------------
# ATmega6450
#------------------------------------------------------------

part
    id               = "m6450";
    desc             = "ATMEGA6450";
    signature        = 0x1E 0x96 0x06;
    has_jtag         = yes;
#   stk500_devcode   = 0x??; # No STK500v1 support?
#   avr910_devcode   = 0x??; # Try the ATmega16 one
    avr910_devcode   = 0x74;
    pagel            = 0xd7;
    bs2              = 0xa0;
    chip_erase_delay = 9000;
    pgm_enable       = "1 0 1 0  1 1 0 0    0 1 0 1  0 0 1 1",
                       "0 0 0 0  0 0 0 0    0 0 0 0  0 0 0 0";

    chip_erase       = "1 0 1 0  1 1 0 0    1 0 0 0  0 0 0 0",
                       "0 0 0 0  0 0 0 0    0 0 0 0  0 0 0 0";

    timeout             = 200;
    stabdelay           = 100;
    cmdexedelay         = 25;
    synchloops          = 32;
    bytedelay           = 0;
    pollindex           = 3;
    pollvalue           = 0x53;
    predelay            = 1;
    postdelay           = 1;
    pollmethod          = 1;

    pp_controlstack     =
        0x0E, 0x1E, 0x0F, 0x1F, 0x2E, 0x3E, 0x2F, 0x3F,
        0x4E, 0x5E, 0x4F, 0x5F, 0x6E, 0x7E, 0x6F, 0x7F,
        0x66, 0x76, 0x67, 0x77, 0x6A, 0x7A, 0x6B, 0x7B,
        0xBE, 0xFD, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00;
    hventerstabdelay    = 100;
    progmodedelay       = 0;
    latchcycles         = 5;
    togglevtg           = 1;
    poweroffdelay       = 15;
    resetdelayms        = 1;
    resetdelayus        = 0;
    hvleavestabdelay    = 15;
    chiperasepulsewidth = 0;
    chiperasepolltimeout = 10;
    programfusepulsewidth = 0;
    programfusepolltimeout = 5;
    programlockpulsewidth = 0;
    programlockpolltimeout = 5;

    idr                 = 0x31;
    spmcr               = 0x57;
    allowfullpagebitstream = no;

    memory "eeprom"
        paged           = no; /* leave this "no" */
        page_size       = 8;  /* for parallel programming */
        size            = 2048;
        min_write_delay = 9000;
        max_write_delay = 9000;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read            = "  1   0   1   0      0   0   0   0",
                          "  0   0   0   0      0 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  o   o   o   o      o   o   o   o";

        write           = "  1   1   0   0      0   0   0   0",
                          "  0   0   0   0      0 a10  a9  a8",
                          " a7  a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_lo     = "  1   1   0   0      0   0   0   1",
                          "  0   0   0   0      0   0   0   0",
                          "  0   0   0   0      0  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "  1   1   0   0      0   0   1   0",
                          "  0   0   0   0      0 a10  a9  a8",
                          " a7  a6  a5  a4     a3   0   0   0",
                          "  x   x   x   x      x   x   x   x";

        mode            = 0x41;
        delay           = 10;
        blocksize       = 4;
        readsize        = 256;
      ;

    memory "flash"
        paged           = yes;
        size            = 65536;
        page_size       = 256;
        num_pages       = 256;
        min_write_delay = 4500;
        max_write_delay = 4500;
        readback_p1     = 0xff;
        readback_p2     = 0xff;
        read_lo         = "   0   0   1   0      0   0   0   0",
                          " a15 a14 a13 a12    a11 a10  a9  a8",
                          "  a7  a6  a5  a4     a3  a2  a1  a0",
                          "   o   o   o   o      o   o   o   o";

        read_hi         = "   0   0   1   0      1   0   0   0",
                          " a15 a14 a13 a12    a11 a10  a9  a8",
                          "  a7  a6  a5  a4     a3  a2  a1  a0",
                          "   o   o   o   o      o   o   o   o";

        loadpage_lo     = "  0   1   0   0      0   0   0   0",
                          "  0   0   0   0      0   0   0   0",
                          "  a7 a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        loadpage_hi     = "  0   1   0   0      1   0   0   0",
                          "  0   0   0   0      0   0   0   0",
                          "  a7 a6  a5  a4     a3  a2  a1  a0",
                          "  i   i   i   i      i   i   i   i";

        writepage       = "   0   1   0   0      1   1   0   0",
                          " a15 a14 a13 a12    a11 a10  a9  a8",
                          "  a7  a6  a5  a4     a3  a2  a1  a0",
                          "   0   0   0   0      0   0   0   0";

        mode            = 0x41;
        delay           = 10;
        blocksize       = 128;
        readsize        = 256;
      ;

    memory "lock"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "x x x x  x x x x   x x o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 1 1 0  0 0 0 0",
                          "0 0 0 0  0 0 0 0   1 1 i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "lfuse"
        size            = 1;
        read            = "0 1 0 1  0 0 0 0   0 0 0 0  0 0 0 0",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  0 0 0 0",
                          "0 0 0 0  0 0 0 0   i i i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "hfuse"
        size            = 1;
        read            = "0 1 0 1  1 0 0 0   0 0 0 0  1 0 0 0",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0   1 0 1 0  1 0 0 0",
                          "0 0 0 0  0 0 0 0   i i i i  i i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "efuse"
        size            = 1;

        read            = "0 1 0 1  0 0 0 0  0 0 0 0  1 0 0 0",
                          "0 0 0 0  0 0 0 0  o o o o  o o o o";

        write           = "1 0 1 0  1 1 0 0  1 0 1 0  0 1 0 0",
                          "0 0 0 0  0 0 0 0  1 1 1 1  1 i i i";
        min_write_delay = 9000;
        max_write_delay = 9000;
      ;

    memory "signature"
        size            = 3;
        read            = "0  0  1  1   0  0  0  0   0  0  0  0   0  0  0  0",
                          "0  0  0  0   0  0 a1 a0   o  o  o  o   o  o  o  o";
      ;

    memory "calibration"
        size            = 1;

        read            = "0 0 1 1  1 0 0 0   0 0 0 0  0 0 0 0",
                          "0 0 0 0  0 0 0 0   o o o o  o o o o";
        ;
  ;

#------------------------------------------------------------
# ATXMEGA64A1
#------------------------------------------------------------

part
    id		= "x64a1";
    desc	= "ATXMEGA64A1";
    signature	= 0x1e 0x96 0x4e;
    has_jtag	= yes;
    has_pdi	= yes;
    nvm_base	= 0x01c0;

    memory "eeprom"
        size		= 0x0800;
        offset		= 0x08c0000;
        page_size	= 0x20;
        readsize	= 0x100;
    ;

    memory "application"
        size		= 0x00010000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "apptable"
        size		= 0x00001000;
        offset		= 0x0080f000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "boot"
        size		= 0x00001000;
        offset		= 0x00810000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "flash"
        size		= 0x00011000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "prodsig"
        size		= 0x200;
        offset		= 0x8e0200;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "usersig"
        size		= 0x200;
        offset		= 0x8e0400;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "signature"
        size		= 3;
        offset		= 0x1000090;
    ;

    memory "fuse0"
        size		= 1;
        offset		= 0x8f0020;
    ;

    memory "fuse1"
        size		= 1;
        offset		= 0x8f0021;
    ;

    memory "fuse2"
        size		= 1;
        offset		= 0x8f0022;
    ;

    memory "fuse4"
        size		= 1;
        offset		= 0x8f0024;
    ;

    memory "fuse5"
        size		= 1;
        offset		= 0x8f0025;
    ;

    memory "lock"
        size		= 1;
        offset		= 0x8f0027;
    ;
;

#------------------------------------------------------------
# ATXMEGA128A1
#------------------------------------------------------------

part
    id		= "x128a1";
    desc	= "ATXMEGA128A1";
    signature	= 0x1e 0x97 0x4c;
    has_jtag	= yes;
    has_pdi	= yes;
    nvm_base	= 0x01c0;

    memory "eeprom"
        size		= 0x0800;
        offset		= 0x08c0000;
        page_size	= 0x20;
        readsize	= 0x100;
    ;

    memory "application"
        size		= 0x00020000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "apptable"
        size		= 0x00002000;
        offset		= 0x0081e000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "boot"
        size		= 0x00002000;
        offset		= 0x00820000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "flash"
        size		= 0x00022000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "prodsig"
        size		= 0x200;
        offset		= 0x8e0200;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "usersig"
        size		= 0x200;
        offset		= 0x8e0400;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "signature"
        size		= 3;
        offset		= 0x1000090;
    ;

    memory "fuse0"
        size		= 1;
        offset		= 0x8f0020;
    ;

    memory "fuse1"
        size		= 1;
        offset		= 0x8f0021;
    ;

    memory "fuse2"
        size		= 1;
        offset		= 0x8f0022;
    ;

    memory "fuse4"
        size		= 1;
        offset		= 0x8f0024;
    ;

    memory "fuse5"
        size		= 1;
        offset		= 0x8f0025;
    ;

    memory "lock"
        size		= 1;
        offset		= 0x8f0027;
    ;
;

#------------------------------------------------------------
# ATXMEGA128A1REVD
#------------------------------------------------------------

part
    id		= "x128a1d";
    desc	= "ATXMEGA128A1REVD";
    signature	= 0x1e 0x97 0x41;
    has_jtag	= yes;
    has_pdi	= yes;
    nvm_base	= 0x01c0;

    memory "eeprom"
        size		= 0x0800;
        offset		= 0x08c0000;
        page_size	= 0x20;
        readsize	= 0x100;
    ;

    memory "application"
        size		= 0x00020000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "apptable"
        size		= 0x00002000;
        offset		= 0x0081e000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "boot"
        size		= 0x00002000;
        offset		= 0x00820000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "flash"
        size		= 0x00022000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "prodsig"
        size		= 0x200;
        offset		= 0x8e0200;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "usersig"
        size		= 0x200;
        offset		= 0x8e0400;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "signature"
        size		= 3;
        offset		= 0x1000090;
    ;

    memory "fuse0"
        size		= 1;
        offset		= 0x8f0020;
    ;

    memory "fuse1"
        size		= 1;
        offset		= 0x8f0021;
    ;

    memory "fuse2"
        size		= 1;
        offset		= 0x8f0022;
    ;

    memory "fuse4"
        size		= 1;
        offset		= 0x8f0024;
    ;

    memory "fuse5"
        size		= 1;
        offset		= 0x8f0025;
    ;

    memory "lock"
        size		= 1;
        offset		= 0x8f0027;
    ;
;

#------------------------------------------------------------
# ATXMEGA192A1
#------------------------------------------------------------

part
    id		= "x192a1";
    desc	= "ATXMEGA192A1";
    signature	= 0x1e 0x97 0x4e;
    has_jtag	= yes;
    has_pdi	= yes;
    nvm_base	= 0x01c0;

    memory "eeprom"
        size		= 0x0800;
        offset		= 0x08c0000;
        page_size	= 0x20;
        readsize	= 0x100;
    ;

    memory "application"
        size		= 0x00030000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "apptable"
        size		= 0x00002000;
        offset		= 0x0082e000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "boot"
        size		= 0x00002000;
        offset		= 0x00830000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "flash"
        size		= 0x00032000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "prodsig"
        size		= 0x200;
        offset		= 0x8e0200;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "usersig"
        size		= 0x200;
        offset		= 0x8e0400;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "signature"
        size		= 3;
        offset		= 0x1000090;
    ;

    memory "fuse0"
        size		= 1;
        offset		= 0x8f0020;
    ;

    memory "fuse1"
        size		= 1;
        offset		= 0x8f0021;
    ;

    memory "fuse2"
        size		= 1;
        offset		= 0x8f0022;
    ;

    memory "fuse4"
        size		= 1;
        offset		= 0x8f0024;
    ;

    memory "fuse5"
        size		= 1;
        offset		= 0x8f0025;
    ;

    memory "lock"
        size		= 1;
        offset		= 0x8f0027;
    ;
;

#------------------------------------------------------------
# ATXMEGA256A1
#------------------------------------------------------------

part
    id		= "x256a1";
    desc	= "ATXMEGA256A1";
    signature	= 0x1e 0x98 0x46;
    has_jtag	= yes;
    has_pdi	= yes;
    nvm_base	= 0x01c0;

    memory "eeprom"
        size		= 0x1000;
        offset		= 0x08c0000;
        page_size	= 0x20;
        readsize	= 0x100;
    ;

    memory "application"
        size		= 0x00040000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "apptable"
        size		= 0x00002000;
        offset		= 0x0083e000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "boot"
        size		= 0x00002000;
        offset		= 0x00840000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "flash"
        size		= 0x00042000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "prodsig"
        size		= 0x200;
        offset		= 0x8e0200;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "usersig"
        size		= 0x200;
        offset		= 0x8e0400;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "signature"
        size		= 3;
        offset		= 0x1000090;
    ;

    memory "fuse0"
        size		= 1;
        offset		= 0x8f0020;
    ;

    memory "fuse1"
        size		= 1;
        offset		= 0x8f0021;
    ;

    memory "fuse2"
        size		= 1;
        offset		= 0x8f0022;
    ;

    memory "fuse4"
        size		= 1;
        offset		= 0x8f0024;
    ;

    memory "fuse5"
        size		= 1;
        offset		= 0x8f0025;
    ;

    memory "lock"
        size		= 1;
        offset		= 0x8f0027;
    ;
;

#------------------------------------------------------------
# ATXMEGA64A3
#------------------------------------------------------------

part
    id		= "x64a3";
    desc	= "ATXMEGA64A3";
    signature	= 0x1e 0x96 0x42;
    has_jtag	= yes;
    has_pdi	= yes;
    nvm_base	= 0x01c0;

    memory "eeprom"
        size		= 0x0800;
        offset		= 0x08c0000;
        page_size	= 0x20;
        readsize	= 0x100;
    ;

    memory "application"
        size		= 0x00010000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "apptable"
        size		= 0x00001000;
        offset		= 0x0080f000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "boot"
        size		= 0x00001000;
        offset		= 0x00810000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "flash"
        size		= 0x00011000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "prodsig"
        size		= 0x200;
        offset		= 0x8e0200;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "usersig"
        size		= 0x200;
        offset		= 0x8e0400;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "signature"
        size		= 3;
        offset		= 0x1000090;
    ;

    memory "fuse0"
        size		= 1;
        offset		= 0x8f0020;
    ;

    memory "fuse1"
        size		= 1;
        offset		= 0x8f0021;
    ;

    memory "fuse2"
        size		= 1;
        offset		= 0x8f0022;
    ;

    memory "fuse4"
        size		= 1;
        offset		= 0x8f0024;
    ;

    memory "fuse5"
        size		= 1;
        offset		= 0x8f0025;
    ;

    memory "lock"
        size		= 1;
        offset		= 0x8f0027;
    ;
;

#------------------------------------------------------------
# ATXMEGA128A3
#------------------------------------------------------------

part
    id		= "x128a3";
    desc	= "ATXMEGA128A3";
    signature	= 0x1e 0x97 0x42;
    has_jtag	= yes;
    has_pdi	= yes;
    nvm_base	= 0x01c0;

    memory "eeprom"
        size		= 0x0800;
        offset		= 0x08c0000;
        page_size	= 0x20;
        readsize	= 0x100;
    ;

    memory "application"
        size		= 0x00020000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "apptable"
        size		= 0x00002000;
        offset		= 0x0081e000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "boot"
        size		= 0x00002000;
        offset		= 0x00820000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "flash"
        size		= 0x00022000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "prodsig"
        size		= 0x200;
        offset		= 0x8e0200;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "usersig"
        size		= 0x200;
        offset		= 0x8e0400;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "signature"
        size		= 3;
        offset		= 0x1000090;
    ;

    memory "fuse0"
        size		= 1;
        offset		= 0x8f0020;
    ;

    memory "fuse1"
        size		= 1;
        offset		= 0x8f0021;
    ;

    memory "fuse2"
        size		= 1;
        offset		= 0x8f0022;
    ;

    memory "fuse4"
        size		= 1;
        offset		= 0x8f0024;
    ;

    memory "fuse5"
        size		= 1;
        offset		= 0x8f0025;
    ;

    memory "lock"
        size		= 1;
        offset		= 0x8f0027;
    ;
;

#------------------------------------------------------------
# ATXMEGA192A3
#------------------------------------------------------------

part
    id		= "x192a3";
    desc	= "ATXMEGA192A3";
    signature	= 0x1e 0x97 0x44;
    has_jtag	= yes;
    has_pdi	= yes;
    nvm_base	= 0x01c0;

    memory "eeprom"
        size		= 0x0800;
        offset		= 0x08c0000;
        page_size	= 0x20;
        readsize	= 0x100;
    ;

    memory "application"
        size		= 0x00030000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "apptable"
        size		= 0x00002000;
        offset		= 0x0082e000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "boot"
        size		= 0x00002000;
        offset		= 0x00830000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "flash"
        size		= 0x00032000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "prodsig"
        size		= 0x200;
        offset		= 0x8e0200;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "usersig"
        size		= 0x200;
        offset		= 0x8e0400;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "signature"
        size		= 3;
        offset		= 0x1000090;
    ;

    memory "fuse0"
        size		= 1;
        offset		= 0x8f0020;
    ;

    memory "fuse1"
        size		= 1;
        offset		= 0x8f0021;
    ;

    memory "fuse2"
        size		= 1;
        offset		= 0x8f0022;
    ;

    memory "fuse4"
        size		= 1;
        offset		= 0x8f0024;
    ;

    memory "fuse5"
        size		= 1;
        offset		= 0x8f0025;
    ;

    memory "lock"
        size		= 1;
        offset		= 0x8f0027;
    ;
;

#------------------------------------------------------------
# ATXMEGA256A3
#------------------------------------------------------------

part
    id		= "x256a3";
    desc	= "ATXMEGA256A3";
    signature	= 0x1e 0x98 0x42;
    has_jtag	= yes;
    has_pdi	= yes;
    nvm_base	= 0x01c0;

    memory "eeprom"
        size		= 0x1000;
        offset		= 0x08c0000;
        page_size	= 0x20;
        readsize	= 0x100;
    ;

    memory "application"
        size		= 0x00040000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "apptable"
        size		= 0x00002000;
        offset		= 0x0083e000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "boot"
        size		= 0x00002000;
        offset		= 0x00840000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "flash"
        size		= 0x00042000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "prodsig"
        size		= 0x200;
        offset		= 0x8e0200;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "usersig"
        size		= 0x200;
        offset		= 0x8e0400;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "signature"
        size		= 3;
        offset		= 0x1000090;
    ;

    memory "fuse0"
        size		= 1;
        offset		= 0x8f0020;
    ;

    memory "fuse1"
        size		= 1;
        offset		= 0x8f0021;
    ;

    memory "fuse2"
        size		= 1;
        offset		= 0x8f0022;
    ;

    memory "fuse4"
        size		= 1;
        offset		= 0x8f0024;
    ;

    memory "fuse5"
        size		= 1;
        offset		= 0x8f0025;
    ;

    memory "lock"
        size		= 1;
        offset		= 0x8f0027;
    ;
;

#------------------------------------------------------------
# ATXMEGA256A3B
#------------------------------------------------------------

part
    id		= "x256a3b";
    desc	= "ATXMEGA256A3B";
    signature	= 0x1e 0x98 0x43;
    has_jtag	= yes;
    has_pdi	= yes;
    nvm_base	= 0x01c0;

    memory "eeprom"
        size		= 0x1000;
        offset		= 0x08c0000;
        page_size	= 0x20;
        readsize	= 0x100;
    ;

    memory "application"
        size		= 0x00040000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "apptable"
        size		= 0x00002000;
        offset		= 0x0083e000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "boot"
        size		= 0x00002000;
        offset		= 0x00840000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "flash"
        size		= 0x00042000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "prodsig"
        size		= 0x200;
        offset		= 0x8e0200;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "usersig"
        size		= 0x200;
        offset		= 0x8e0400;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "signature"
        size		= 3;
        offset		= 0x1000090;
    ;

    memory "fuse0"
        size		= 1;
        offset		= 0x8f0020;
    ;

    memory "fuse1"
        size		= 1;
        offset		= 0x8f0021;
    ;

    memory "fuse2"
        size		= 1;
        offset		= 0x8f0022;
    ;

    memory "fuse4"
        size		= 1;
        offset		= 0x8f0024;
    ;

    memory "fuse5"
        size		= 1;
        offset		= 0x8f0025;
    ;

    memory "lock"
        size		= 1;
        offset		= 0x8f0027;
    ;
;

#------------------------------------------------------------
# ATXMEGA16A4
#------------------------------------------------------------

part
    id		= "x16a4";
    desc	= "ATXMEGA16A4";
    signature	= 0x1e 0x94 0x41;
    has_jtag	= yes;
    has_pdi	= yes;
    nvm_base	= 0x01c0;

    memory "eeprom"
        size		= 0x0400;
        offset		= 0x08c0000;
        page_size	= 0x20;
        readsize	= 0x100;
    ;

    memory "application"
        size		= 0x00004000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "apptable"
        size		= 0x00001000;
        offset		= 0x00803000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "boot"
        size		= 0x00001000;
        offset		= 0x00804000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "flash"
        size		= 0x00005000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "prodsig"
        size		= 0x200;
        offset		= 0x8e0200;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "usersig"
        size		= 0x200;
        offset		= 0x8e0400;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "signature"
        size		= 3;
        offset		= 0x1000090;
    ;

    memory "fuse0"
        size		= 1;
        offset		= 0x8f0020;
    ;

    memory "fuse1"
        size		= 1;
        offset		= 0x8f0021;
    ;

    memory "fuse2"
        size		= 1;
        offset		= 0x8f0022;
    ;

    memory "fuse4"
        size		= 1;
        offset		= 0x8f0024;
    ;

    memory "fuse5"
        size		= 1;
        offset		= 0x8f0025;
    ;

    memory "lock"
        size		= 1;
        offset		= 0x8f0027;
    ;
;

#------------------------------------------------------------
# ATXMEGA32A4
#------------------------------------------------------------

part
    id		= "x32a4";
    desc	= "ATXMEGA32A4";
    signature	= 0x1e 0x95 0x41;
    has_jtag	= yes;
    has_pdi	= yes;
    nvm_base	= 0x01c0;

    memory "eeprom"
        size		= 0x0400;
        offset		= 0x08c0000;
        page_size	= 0x20;
        readsize	= 0x100;
    ;

    memory "application"
        size		= 0x00008000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "apptable"
        size		= 0x00001000;
        offset		= 0x00807000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "boot"
        size		= 0x00001000;
        offset		= 0x00808000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "flash"
        size		= 0x00009000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "prodsig"
        size		= 0x200;
        offset		= 0x8e0200;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "usersig"
        size		= 0x200;
        offset		= 0x8e0400;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "signature"
        size		= 3;
        offset		= 0x1000090;
    ;

    memory "fuse0"
        size		= 1;
        offset		= 0x8f0020;
    ;

    memory "fuse1"
        size		= 1;
        offset		= 0x8f0021;
    ;

    memory "fuse2"
        size		= 1;
        offset		= 0x8f0022;
    ;

    memory "fuse4"
        size		= 1;
        offset		= 0x8f0024;
    ;

    memory "fuse5"
        size		= 1;
        offset		= 0x8f0025;
    ;

    memory "lock"
        size		= 1;
        offset		= 0x8f0027;
    ;
;

#------------------------------------------------------------
# ATXMEGA64A4
#------------------------------------------------------------

part
    id		= "x64a4";
    desc	= "ATXMEGA64A4";
    signature	= 0x1e 0x96 0x46;
    has_jtag	= yes;
    has_pdi	= yes;
    nvm_base	= 0x01c0;

    memory "eeprom"
        size		= 0x0800;
        offset		= 0x08c0000;
        page_size	= 0x20;
        readsize	= 0x100;
    ;

    memory "application"
        size		= 0x00010000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "apptable"
        size		= 0x00001000;
        offset		= 0x0080f000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "boot"
        size		= 0x00001000;
        offset		= 0x00810000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "flash"
        size		= 0x00011000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "prodsig"
        size		= 0x200;
        offset		= 0x8e0200;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "usersig"
        size		= 0x200;
        offset		= 0x8e0400;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "signature"
        size		= 3;
        offset		= 0x1000090;
    ;

    memory "fuse0"
        size		= 1;
        offset		= 0x8f0020;
    ;

    memory "fuse1"
        size		= 1;
        offset		= 0x8f0021;
    ;

    memory "fuse2"
        size		= 1;
        offset		= 0x8f0022;
    ;

    memory "fuse4"
        size		= 1;
        offset		= 0x8f0024;
    ;

    memory "fuse5"
        size		= 1;
        offset		= 0x8f0025;
    ;

    memory "lock"
        size		= 1;
        offset		= 0x8f0027;
    ;
;

#------------------------------------------------------------
# ATXMEGA128A4
#------------------------------------------------------------

part
    id		= "x128a4";
    desc	= "ATXMEGA128A4";
    signature	= 0x1e 0x97 0x46;
    has_jtag	= yes;
    has_pdi	= yes;
    nvm_base	= 0x01c0;

    memory "eeprom"
        size		= 0x0800;
        offset		= 0x08c0000;
        page_size	= 0x20;
        readsize	= 0x100;
    ;

    memory "application"
        size		= 0x00020000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "apptable"
        size		= 0x00002000;
        offset		= 0x0081e000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "boot"
        size		= 0x00002000;
        offset		= 0x00820000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "flash"
        size		= 0x00022000;
        offset		= 0x0800000;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "prodsig"
        size		= 0x200;
        offset		= 0x8e0200;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "usersig"
        size		= 0x200;
        offset		= 0x8e0400;
        page_size	= 0x100;
        readsize	= 0x100;
    ;

    memory "signature"
        size		= 3;
        offset		= 0x1000090;
    ;

    memory "fuse0"
        size		= 1;
        offset		= 0x8f0020;
    ;

    memory "fuse1"
        size		= 1;
        offset		= 0x8f0021;
    ;

    memory "fuse2"
        size		= 1;
        offset		= 0x8f0022;
    ;

    memory "fuse4"
        size		= 1;
        offset		= 0x8f0024;
    ;

    memory "fuse5"
        size		= 1;
        offset		= 0x8f0025;
    ;

    memory "lock"
        size		= 1;
        offset		= 0x8f0027;
    ;
;


#------------------------------------------------------------
# AVR32UC3A0512
#------------------------------------------------------------

part
    id		= "ucr2";
    desc	= "32UC3A0512";
    signature	= 0xED 0xC0 0x3F;
    has_jtag	= yes;
    is_avr32    = yes;

    memory "flash"
        paged           = yes;
        page_size		= 512;               # bytes
        readsize		= 512;				 # bytes
        num_pages       = 1024;              # could be set dynamicly
        size			= 0x00080000;		 # could be set dynamicly
        offset			= 0x80000000;
    ;
;

#------------------------------------------------------------
# ATtiny4
#------------------------------------------------------------

part
    id		= "t4";
    desc	= "ATtiny4";
    signature	= 0x1e 0x8f 0x0a;
    has_tpi	= yes;

    memory "flash"
        size		= 512;
        offset		= 0x4000;
        page_size	= 16;
        blocksize	= 128;
    ;

    memory "signature"
        size		= 3;
        offset		= 0x3fc0;
    ;

    memory "fuse"
        size		= 1;
        offset		= 0x3f40;
	blocksize	= 4;
    ;

    memory "calibration"
        size		= 1;
        offset		= 0x3f80;
    ;

    memory "lockbits"
        size		= 1;
        offset		= 0x3f00;
    ;
;


#------------------------------------------------------------
# ATtiny5
#------------------------------------------------------------

part
    id		= "t5";
    desc	= "ATtiny5";
    signature	= 0x1e 0x8f 0x09;
    has_tpi	= yes;

    memory "flash"
        size		= 512;
        offset		= 0x4000;
        page_size	= 16;
        blocksize	= 128;
    ;

    memory "signature"
        size		= 3;
        offset		= 0x3fc0;
    ;

    memory "fuse"
        size		= 1;
        offset		= 0x3f40;
	blocksize	= 4;
    ;

    memory "calibration"
        size		= 1;
        offset		= 0x3f80;
    ;

    memory "lockbits"
        size		= 1;
        offset		= 0x3f00;
    ;
;


#------------------------------------------------------------
# ATtiny9
#------------------------------------------------------------

part
    id		= "t8";
    desc	= "ATtiny9";
    signature	= 0x1e 0x90 0x08;
    has_tpi	= yes;

    memory "flash"
        size		= 1024;
        offset		= 0x4000;
        page_size	= 16;
        blocksize	= 128;
    ;

    memory "signature"
        size		= 3;
        offset		= 0x3fc0;
    ;

    memory "fuse"
        size		= 1;
        offset		= 0x3f40;
	blocksize	= 4;
    ;

    memory "calibration"
        size		= 1;
        offset		= 0x3f80;
    ;

    memory "lockbits"
        size		= 1;
        offset		= 0x3f00;
    ;
;


#------------------------------------------------------------
# ATtiny10
#------------------------------------------------------------

part
    id		= "t10";
    desc	= "ATtiny10";
    signature	= 0x1e 0x90 0x03;
    has_tpi	= yes;

    memory "flash"
        size		= 1024;
        offset		= 0x4000;
        page_size	= 16;
        blocksize	= 128;
    ;

    memory "signature"
        size		= 3;
        offset		= 0x3fc0;
    ;

    memory "fuse"
        size		= 1;
        offset		= 0x3f40;
	blocksize	= 4;
    ;

    memory "calibration"
        size		= 1;
        offset		= 0x3f80;
    ;

    memory "lockbits"
        size		= 1;
        offset		= 0x3f00;
    ;
;


