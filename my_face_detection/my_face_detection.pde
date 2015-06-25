import gab.opencv.*;
import java.awt.Rectangle;

OpenCV opencv;
Rectangle[] faces;
PImage img;

void setup() {
  img = loadImage("bill.png");
  img.resize(800, 0);

  opencv = new OpenCV(this, img);
  size(opencv.width, opencv.height);

  //HAAR CASCADE
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  faces = opencv.detect();
}

void draw() {
  image(opencv.getInput(), 0, 0);

  //  noFill();
  fill(random(255), random(255), random(255), random(125));
  stroke(random(255), random(255), random(255));
  strokeWeight(3);

  for (int i = 0; i < faces.length; i++) {
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
}

