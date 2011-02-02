#define MAX_BLOBS  255
#define MAX_COLORS 17  // reserve color #16 for internal use
#define MIN_BLOB_SIZE 5

#define index(xx, yy)  ((yy * imgWidth + xx) * 2) & 0xFFFFFFFC  // always a multiple of 4

extern unsigned int imgWidth, imgHeight;
extern unsigned int vblob(unsigned char *, unsigned char *, unsigned int);
extern void init_colors();
extern unsigned int rmax[], rmin[], gmax[], gmin[], bmax[], bmin[];
extern unsigned int blobx1[], blobx2[], bloby1[], bloby2[], blobcnt[], blobix[];
