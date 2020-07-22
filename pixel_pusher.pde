import com.heroicrobot.dropbit.registry.*;
import com.heroicrobot.dropbit.devices.pixelpusher.Pixel;
import com.heroicrobot.dropbit.devices.pixelpusher.Strip;
import com.heroicrobot.dropbit.devices.pixelpusher.PixelPusher;
import com.heroicrobot.dropbit.devices.pixelpusher.PusherCommand;
import java.util.*;

DeviceRegistry registry;
PusherObserver observer;
boolean firstPush = true;
int currentStrip = 0;
int currentLed = 0;

void initPusher() {
  registry = new DeviceRegistry();
  observer = new PusherObserver();
  registry.addObserver(observer);
  registry.setAntiLog(true);
}

void pushPixels() {
  if (observer.hasStrips) {
    registry.startPushing();
    List<Strip> strips = registry.getStrips();

    int stripIndex = 0;
     
    for(Strip strip : strips) {
      if (enableStrip[stripIndex]) {
        int[][] stripMap = map[stripIndex];
        
        for(int ii = 0; ii < stripMap.length; ii++) {
          int[] led = stripMap[ii];
          int x = led[0];
          int y = led[1];
          
          color c = get(x, y);  
          strip.setPixel(c, ii);
        }
      }
      
      stripIndex++;
    }
  }
  
  updatePixels();
}

class PusherObserver implements Observer {
  public boolean hasStrips = false;
  public void update(Observable registry, Object updatedDevice) {
   // println("Registry changed!");
    if (updatedDevice != null) {
     // println("Device change: " + updatedDevice);
    }
    this.hasStrips = true;
  }
};

void spamCommand(PixelPusher p, PusherCommand pc) {
   for (int i=0; i<3; i++) {
    p.sendCommand(pc);
  }
}


void mousePressed() {
  if (enablePixelPusher) {
    List<PixelPusher> pushers = registry.getPushers();
    println(mouseY);
    for (PixelPusher p: pushers) {
       PusherCommand pc = new PusherCommand(PusherCommand.GLOBALBRIGHTNESS_SET, (short)(8500));
       spamCommand(p,  pc);
    }
  }
}