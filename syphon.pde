import codeanticode.syphon.*;

SyphonClient client;
PGraphics canvas;

void initSyphon() {
  background(0);
  client = new SyphonClient(this);
}

void getSyphon() {
  if (client.newFrame()) {
    canvas = client.getGraphics(canvas);
    image(canvas, 0, 0, width, height);
  }  
}