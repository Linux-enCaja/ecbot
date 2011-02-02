#include "tracking.h"

extern unsigned int imgWidth, imgHeight;

unsigned int rmax[MAX_COLORS], rmin[MAX_COLORS], gmax[MAX_COLORS], gmin[MAX_COLORS], bmax[MAX_COLORS], bmin[MAX_COLORS];
unsigned int blobx1[MAX_BLOBS], blobx2[MAX_BLOBS], bloby1[MAX_BLOBS], bloby2[MAX_BLOBS], blobcnt[MAX_BLOBS], blobix[MAX_BLOBS];unsigned int imgWidth, imgHeight;

void init_colors() {
    unsigned int ii;
    
    for(ii = 0; ii<MAX_COLORS; ii++) {
        rmax[ii] = 0;
        rmin[ii] = 0;
        gmax[ii] = 0;
        gmin[ii] = 0;
        bmax[ii] = 0;
        bmin[ii] = 0;
    }
}

// merge blobs, changing any pixel in blob_buf[] in old_blob to new_blob
void blob_merge(unsigned char *blob_buf, unsigned char old_blob, unsigned char new_blob) {
    int ix;
    for (ix=0; ix<(imgWidth*imgHeight); ix+=2)
        if (blob_buf[ix] == old_blob)
            blob_buf[ix] = new_blob;
}

// return number of blobs found that match the search color
// algorithm derived from "Using a Particle Filter for Gesture Recognition", Alexander Gruenstein
//    http://www.mit.edu/~alexgru/vision/
unsigned int vblob(unsigned char *frame_buf, unsigned char *blob_buf, unsigned int ii) {
    unsigned int ix, iy, xx, yy, r, g, b, tmp;
    unsigned char *bbp, curBlob, vL, vTL, vT, vTR, vME;

    register int r1, r2, g1, g2, b1, b2;
    r1 = rmin[ii];
    r2 = rmax[ii];
    g1 = gmin[ii];
    g2 = gmax[ii];
    b1 = bmin[ii];
    b2 = bmax[ii];

    for (curBlob=0; curBlob<MAX_BLOBS; curBlob++) {
        blobcnt[curBlob] = 0;
        blobx1[curBlob] = imgWidth;
        blobx2[curBlob] = 0;
        bloby1[curBlob] = imgHeight;
        bloby2[curBlob] = 0;
        blobix[curBlob] = 0;
    }

    bbp = blob_buf;
    for (ix=0; ix<imgWidth*imgHeight*2; ix++)
        *bbp++ = 0;

    // tag all pixels in blob_buf[]    
    //     matching = 1  
    //     no color match = 0
    // thus all matching pixels will belong to blob #1
    bbp = blob_buf;
    for (ix=0; ix<(imgWidth*imgHeight*3); ix+=3){
        r = (unsigned int)frame_buf[ix];
        g = (unsigned int)frame_buf[ix + 1];
        b = (unsigned int)frame_buf[ix + 2];
        if ((r > r1) && (r < r2) && (g > g1) && (g < g2) && (b > b1) && (b < b2)){
            *bbp = 1;
        }
        bbp += 2;
    }

    for (yy=0; yy<imgHeight; yy++) {
        for (xx=0; xx<imgWidth*2; xx+=2) {
          ix = xx + (yy * imgWidth);
          if(blob_buf[ix] != 0) 
          printf("%d: %x \t", ix, blob_buf[ix]);
        }
    }

    curBlob = 2;
    for (yy=1; yy<imgHeight-1; yy++) {   // don't go all the way to the image edge
        for (xx=2; xx<(imgWidth-2); xx+=2) {
            ix = xx + (yy * imgWidth);
            vL = 0; vTL = 0; vT = 0; vTR = 0;
            vME = 0;
            if (blob_buf[ix] == 1) {
                vL =  blob_buf[ix-2];    // left
                vTL = blob_buf[(ix - imgWidth) - 2];   // top left
                vT =  blob_buf[ix - imgWidth];  // top
                vTR = blob_buf[(ix - imgWidth) + 2];   // top right
                
                if (vL)
                    vME = vL;
                if (vTL)
                    vME = vTL;  // guaranteed same as vL by previous iteration
                if (vT) {
                    if ((vL != 0) && (vL != vT))      // we have a U connection
                        blob_merge(blob_buf, vT, vL); // change all vT's to vL's
                    else
                        vME = vT;
                }
                if (vTR) {
                    if ((vTL != 0) && (vTL != vTR))
                        blob_merge(blob_buf, vTR, vTL); // change all vTR's to vTL's
                    else
                        vME = vTR;
                }
                if (vME == 0) {
                    vME = curBlob;
                    curBlob++;
                    printf("  vblob #%d: \n\r", curBlob);
                    if (curBlob >= MAX_BLOBS) { // max blob limit exceeded
                        printf("  vblob #%d: max blob limit exceeded\n\r", ii);
                        return 0;
                    }
                }
                blob_buf[ix] = vME;
            }
        }
    }



    for (yy=0; yy<imgHeight; yy++) {
        for (xx=0; xx<imgWidth*2; xx+=2) {
          ix = xx + (yy * imgWidth);
          if(blob_buf[ix] != 0) 
          printf("%d: %x \t", ix, blob_buf[ix]);
        }
    }
    // measure the blobs
    for (yy=0; yy<imgHeight; yy++) {
        for (xx=0; xx<imgWidth*2; xx+=2) {
            ix = xx + (yy * imgWidth);
            iy = blob_buf[ix];
            if (iy) {
                blobcnt[iy]++;
                if (xx < blobx1[iy])
                    blobx1[iy] = xx;
                if (xx > blobx2[iy])
                    blobx2[iy] = xx;
                if (yy < bloby1[iy])
                    bloby1[iy] = yy;
                if (yy > bloby2[iy])
                    bloby2[iy] = yy;
            }
        }
    }

    // compress the blob array
    for (xx=0; xx<=curBlob; xx++)
        if (blobcnt[xx] < MIN_BLOB_SIZE)
            blobcnt[xx] = 0;
            
    for (xx=0; xx<(curBlob-1); xx++) {
        if (blobcnt[xx] == 0) {
            for (yy=xx+1; yy<=curBlob; yy++) {
                if (blobcnt[yy]) {
                    blobcnt[xx] = blobcnt[yy];
                    blobx1[xx] = blobx1[yy];
                    blobx2[xx] = blobx2[yy];
                    bloby1[xx] = bloby1[yy];
                    bloby2[xx] = bloby2[yy];
                    blobix[xx] = yy;   // this tells us the index of this blob in blob_buf[]
                    blobcnt[yy] = 0;
                    break;
                }
            }
        }
    }
    
    iy = 0;
    for (xx=0; xx<=curBlob; xx++) {
        if (blobcnt[xx])
            iy++;
        else
            break;
    }
    curBlob = iy;

    // sort blobs by size, largest to smallest pixel count
    for (xx=0; xx<=curBlob; xx++) {
        if (blobcnt[xx] == 0)  // no more blobs
            break;
        for (yy=xx+1; yy<=curBlob; yy++) {
            if (blobcnt[yy] == 0)
                break;
            if (blobcnt[xx] < blobcnt[yy]) {
                tmp = blobcnt[xx];
                blobcnt[xx] = blobcnt[yy];
                blobcnt[yy] = tmp;
                tmp = blobx1[xx];
                blobx1[xx] = blobx1[yy];
                blobx1[yy] = tmp;
                tmp = blobx2[xx];
                blobx2[xx] = blobx2[yy];
                blobx2[yy] = tmp;
                tmp = bloby1[xx];
                bloby1[xx] = bloby1[yy];
                bloby1[yy] = tmp;
                tmp = bloby2[xx];
                bloby2[xx] = bloby2[yy];
                bloby2[yy] = tmp;
                tmp = blobix[xx];
                blobix[xx] = blobix[yy];
                blobix[yy] = tmp;
            }
        }
    }
    return curBlob;
}


