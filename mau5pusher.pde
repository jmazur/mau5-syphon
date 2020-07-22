boolean enablePixelPusher = true;
int videoOffsetX = 0;
int videoOffsetY = 0;
int mapOffsetX = 0;
int mapOffsetY = 0;

boolean[] enableStrip = { 
  true, 
  true, 
  true, 
  true, 
  true, 
  true, 
  false, 
  true 
};

void setup() {
  size(62, 62, P3D); //0.3
  //fullScreen();
  frameRate(30);
  
  load_pixel_map();
  
  if (enablePixelPusher) {
    initPusher();
  }
  
  initSyphon();
}

void draw() {  
  if (enablePixelPusher) {
    pushPixels();
  }
  
  getSyphon();
}

void stop()
{
  super.stop();
}
