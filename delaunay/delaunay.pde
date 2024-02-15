import processing.svg.*;
import megamu.mesh.*;

int numPoints = 60;
float drawRad = 100;
float[][] points = new float[numPoints][2];
float[][] edges;
Delaunay del;

void setup() {
  size(400, 400, SVG, "output.svg");
  
  for (int i = 0; i < numPoints; i++) {
    points[i][0] = random(drawRad, width - drawRad);
    points[i][1] = random(drawRad, height - drawRad);
  }
  
  del = new Delaunay(points);
  edges = del.getEdges();
}

void draw() {
  for (int i = 0; i < edges.length; i++) {
    float startX = edges[i][0];
    float startY = edges[i][1];
    float endX = edges[i][2];
    float endY = edges[i][3];
    line(startX, startY, endX, endY);
  }
  
  exit();
}
