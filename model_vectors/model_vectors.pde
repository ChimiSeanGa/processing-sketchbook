PShape model;
PShape modelTess;

PVector lightSource;

float minX = 0;
float maxX = 0;
float minY = 0;
float maxY = 0;
float minZ = 0;
float maxZ = 0;

float minDist = 1000000;
float maxDist = 0;

PVector[] samples;

void getSamples() {
  int numSamples = 0;
  while (numSamples < samples.length) {
    int index = int(random(modelTess.getVertexCount()));
    PVector v = modelTess.getVertex(index);
    //samples[numSamples] = new PVector(v.x, v.y, v.z);
    //numSamples++;
    float d = lightSource.dist(v);
    float m = (d-minDist)/(maxDist-minDist);
    
    float n = random(1) / random(1,3);
    if (m < n) {
      samples[numSamples] = new PVector(v.x, v.y, v.z);
      numSamples++;
    }
  }
}

void setup() {
  size(400, 400, P3D);
  model = loadShape("models/hermes.obj");
  model.rotateY(-PI/4);
  modelTess = model.getTessellation();
  
  // Random sample of 5000 points
  samples = new PVector[5000];
  
  for (int i = 0; i < modelTess.getVertexCount(); i++) {
    PVector v = modelTess.getVertex(i);
    if (v.x < minX) {
      minX = v.x;
    } else if (v.x > maxX) {
      maxX = v.x;
    }
    
    if (v.y < minY) {
      minY = v.y;
    } else if (v.y > maxY) {
      maxY = v.y;
    }
    
    if (v.z < minZ) {
      minZ = v.z;
    } else if (v.z > maxZ) {
      maxZ = v.z;
    }
  }
  
  lightSource = new PVector(maxX+50, minY-50, maxZ+50);
  
  for (int i = 0; i < modelTess.getVertexCount(); i++) {
    PVector v = modelTess.getVertex(i);
    float d = lightSource.dist(v);
    if (d < minDist) {
      minDist = d;
    }
    if (d > maxDist) {
      maxDist = d;
    }
  }
  
  getSamples();
}

void draw() {
  background(0);
  //lightFalloff(1, 0, 0);
  lightSpecular(64, 64, 64);
  
  //spotLight(100, 100, 100, 400, 0, 0, -1, 0, 0, PI/2, 1);
  
  //ambientLight(128, 128, 128);
  directionalLight(255, 255, 255, -1, 1, -1);
  
  camera(0, 0, height * .5,
    0, 0, 0,
    0, 1, 0);
  shape(modelTess);
  //model.rotateY(PI/4);
  //model.rotateY(.01);
  
  for (int i = 0; i < samples.length; i++) {
    PVector v = samples[i];
    pushMatrix();
    translate(v.x, v.y, v.z);
    noStroke();
    sphere(1);
    popMatrix();
  }
}
