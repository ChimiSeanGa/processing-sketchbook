import processing.svg.*;

float spacing = 10.0;
float vscale = 10.0;

float bound = 4.0;

// Vector field function
PVector vectorField(PVector p) {
  PVector v = new PVector(0,0);
  v.x = sin(p.y);
  v.y = sin(p.x);
  return v;
}

// Setup function
void setup() {
  size(400, 400, SVG, "output.svg");
  //size(400, 400);
}

// Draw function
void draw() {
  background(255);
  translate(width*0.5, height*0.5);
  scale(1,-1);
  
  fill(0);
  
  for (float x = -width*0.5; x < width*0.5; x += spacing) {
    for (float y = -height*0.5; y < height*0.5; y += spacing) {
      PVector p = new PVector(x*2/width*bound, y*2/height*bound);
      PVector v = vectorField(p);
      line(x, y, x+v.x*vscale, y+v.y*vscale);
    }
  }
}
