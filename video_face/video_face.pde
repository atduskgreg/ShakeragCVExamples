import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;

Capture video;
OpenCV opencv;
Rectangle[] faces;

PImage bill;

void setup() {
  size(320, 240);
  video = new Capture(this, 320, 240);  
  video.start();
  
  opencv = new OpenCV(this, 320, 240);
  
  bill = loadImage("bill.png");

// HAAR CASCADE
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
}

void draw() {
  image(video, 0, 0);
  opencv.loadImage(video);
  faces = opencv.detect();
  
  for (int i = 0; i < faces.length; i++) {
    if(faces[i].width > 80){
      float proportion = faces[i].width/115.0;
    
      image(bill, faces[i].x, faces[i].y - bill.height/4, bill.width*proportion, bill.height*proportion);
    }
  }
}

void captureEvent(Capture c) {
  c.read();
}

