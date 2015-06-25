import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;
import org.opencv.core.Core;

Capture video;
OpenCV opencv;
PFont font;

void setup() {
  size(320, 240);
  
  font = loadFont("AmericanTypewriter-CondensedBold-48.vlw");
  textFont(font, 48);

  video = new Capture(this, 320, 240);  
  
  opencv = new OpenCV(this, 320, 240);
  opencv.startBackgroundSubtraction(5, 3, 0.5);

  video.start();
}

void draw() {
  background(0);
//  image(video, 0, 0);
  opencv.loadImage(video);
  opencv.updateBackground();
  opencv.dilate();
  opencv.erode();
  
  opencv.flip(OpenCV.HORIZONTAL);
  
  
  image(opencv.getOutput(), 0, 0);
  
  int numWhitePixels = Core.countNonZero(opencv.getGray());
  float percentMoving = numWhitePixels / (float)(opencv.width*opencv.height);
  
  println(percentMoving);
  if(percentMoving > 0.05){
    fill(0,255,0);
    text("hi", width/2,height/2);
  }

}

void captureEvent(Capture c) {
  c.read();
}

