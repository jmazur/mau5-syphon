import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.io.IOException;
import java.io.BufferedWriter;

int[][][] map;

void load_pixel_map() {
  XML xml = loadXML("map.xml");
  XML[] strips = xml.getChildren("strip");
  map = new int[strips.length][][];
  
  for (int i = 0; i < strips.length; i++) {
    XML strip = strips[i];
    XML[] leds = strip.getChildren("led");
    int[][] stripMap = new int[leds.length][];
    
    for (int ii = 0; ii < leds.length; ii++) {
      XML led = leds[ii];
      int x = led.getInt("x") + videoOffsetX + mapOffsetX;
      int y = led.getInt("y") + videoOffsetY + mapOffsetY;
      
      int[] ledMap = { x, y };
      stripMap[ii] = ledMap;
    }
    
    map[i] = stripMap;
  }
}