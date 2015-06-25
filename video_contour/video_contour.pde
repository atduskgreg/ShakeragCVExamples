import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

ArrayList<Contour> contours;

void setup() {
  size(640, 480);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);

  video.start();
}

void draw() {
  scale(2);
  opencv.loadImage(video);

  opencv.blur(3);
  
  opencv.threshold((int)map(mouseX, 0, width, 0, 255));

  image(opencv.getOutput(), 0, 0 );

  contours = opencv.findContours();
  
  fill(255, 0, 0);
  text(contours.size(), 25, 25);
  
  noFill();
 
  for(Contour contour : contours){
    if(contour.area() > 10000){
      stroke(0,255,0);
      contour.draw();
      stroke(0, 0, 255);
      Rectangle box = contour.getBoundingBox();
      rect(box.x, box.y, box.width, box.height);
      stroke(255,0,0);
      contour.getPolygonApproximation().draw();
    }
  }


}

void captureEvent(Capture c) {
  c.read();
}
