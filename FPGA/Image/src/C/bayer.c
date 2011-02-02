

void bayefilter(unsigned char* p,unsigned char* rgb int w, int h)
{
  static unsigned char g,r, b;
  static unsigned short  g0,g1;

  for( int i=0; i<h; i++ )
    for( int j=0; j<w; j++ )
    {
      g0 = p[(i*w+j)<<1];
      g1 = p[(i+1*w+j+1)<<1];
      r  = p[(i*w+j+1)<<1];
      b  = p[(i+1*w+j)<<1];
      g  = (g0+g1)>>1;
      rgb[i*w+j]   = r;
      rgb[i*w+j+1] = g;
      rgb[i*w+j+2] = b;
    }
}