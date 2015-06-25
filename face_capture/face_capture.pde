import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;

Capture video;
OpenCV opencv;
Rectangle[] faces;

boolean keyWasPressed = false;

void setup() {
  size(320, 240);
  video = new Capture(this, 320, 240);  
  video.start();
  
  opencv = new OpenCV(this, 320, 240);
  

// HAAR CASCADE
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
}

void draw() {
  image(video, 0, 0);
  opencv.loadImage(video);
  faces = opencv.detect();
  
  noFill();
  stroke(0,255,0);
  for (int i = 0; i < faces.length; i++) {
    if(faces[i].width > 80){
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
      if(keyWasPressed){
        opencv.setROI(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
        opencv.getSnapshot().save("face.png");
        opencv.releaseROI();
        keyWasPressed = false;
      }    
    }
  }
}

void keyPressed(){
  println("key was pressed!");
  keyWasPressed = true;
}

void captureEvent(Capture c) {
  c.read();
}

