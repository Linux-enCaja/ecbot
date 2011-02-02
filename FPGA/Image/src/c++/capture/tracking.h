#ifndef TRACKING_H
#define TRACKING_H

#define LINE_WIDTH	128
#define IMAGE_HEIGHT	95

#define MAX_TRACKED_OBJECTS	            8
#define MIN_WIDTH       15
#define MIN_HEIGHT      10
#define RUN_OBJECT_FILTER_MASK       0x07

#define TRUE                            1
#define FALSE                           0



/* 	Local Structures and Typedefs */
enum
{
	ST_FrameMgr_idle,
	ST_FrameMgr_TrackingFrame,
	ST_FrameMgr_DumpingFrame
};

typedef unsigned char bool_t;
typedef unsigned char FrameMgr_State_t;


typedef struct {
  unsigned char channel[3];          /**< Components of a single pixel */
} pixel_t;

typedef struct {
    unsigned short width, height;
    unsigned char channels;
    unsigned char depth;  // This can be used for binary images etc in the future
    void* pix;
} image_t;




enum
{
	notTracked,
	color1,		/* bit 1 color */
	color2,		/* bit 2 color */
	color3,		/* bit 3 color */
	color4,		/* bit 4 color */
	color5,		/* bit 5 color */
	color6,		/* bit 6 color */
	color7,		/* bit 7 color */
	color8		/* bit 8 color */
};

typedef unsigned char trackedColor_t;
/* This structure defines the info that needs to be
maintained for each trackedObject in the trackingTable */
typedef struct
{
	unsigned short lastLineXStart;
	unsigned short lastLineXFinish;
	unsigned short x0;
	unsigned short y0;
	unsigned short x1;
	unsigned short y1;
	unsigned char objectValid;
  pixel_t upper_bound;
  pixel_t lower_bound;
} trackedObject_t;

typedef struct
{
  pixel_t upper_bound;
  pixel_t lower_bound;
} trackedColors_t;



#define LAST_LINE_X_START_OFFSET    0
#define LAST_LINE_X_FINISH_OFFSET   2
#define X_UPPER_LEFT_OFFSET         4
#define Y_UPPER_LEFT_OFFSET         6
#define X_LOWER_RIGHT_OFFSET        8
#define Y_LOWER_RIGHT_OFFSET       10
#define VALID_OBJECT_OFFSET        12


void get_pixel (image_t * img, unsigned short x, unsigned short y, pixel_t * out_pix);

void tracking_findConnectedness(image_t image, trackedObject_t * objects);
void tracking_processLine(image_t image, trackedObject_t * objects);
void tracking_init(void);
#endif
