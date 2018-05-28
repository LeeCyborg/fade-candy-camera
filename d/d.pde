import processing.video.*;
int cellSize = 1;
int cols, rows;
Capture video;
OPC opc;
float dx, dy;
void setup() {
  size(240, 240);
  background(0);
  opc = new OPC(this, "127.0.0.1", 7890);
  float spacing = height / 10.0;
  opc.ledGrid8x8(0, width/2, height/2, spacing, 0, true);
  opc.setStatusLed(false);
  colorMode(HSB, 100);
  frameRate(30);
  cols = width / cellSize;
  rows = height / cellSize;
  colorMode(RGB, 255, 255, 255, 100);
  video = new Capture(this, width, height);
  video.start();  
  background(0);
}
void draw() {
  video();
}
void video() {
  if (video.available()) {
    video.read();
    video.loadPixels();
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        int x = i*cellSize;
        int y = j*cellSize;
        int loc = (video.width - x - 1) + y*video.width; // Reversing x to mirror the image
        float r = red(video.pixels[loc]);
        float g = green(video.pixels[loc]);
        float b = blue(video.pixels[loc]);
        color c = color(r, g, b, 75);
        pushMatrix();
        translate(x+cellSize/2, y+cellSize/2);
        rotate((2 * PI * brightness(c) / 255.0));
        rectMode(CENTER);
        fill(c);
        noStroke();
        rect(0, 0, cellSize+6, cellSize+6);
        popMatrix();
      }
    }
  }
}

