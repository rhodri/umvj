class Polyhedra {

  ArrayList<PVector> positions = new ArrayList<PVector>();
  
  float xRate = radians(1);
  float yRate = radians(0.75);
  float zRate = radians(0.66);
  
  float xRot = 0, yRot = 0, zRot = 0;
  
  int complexity = 1;
  
  void draw() {
    
    translate(width/2, height/2, -50);
    increment();
    doRotate();
    
    fill(#FFFFFF);
    sphereDetail(complexity);
    sphere(200);
    
    resetRotation();
    translate(-width/2, -height/2);
  }
  
  public void incrementComplexity() {
    complexity++;
  }
  
  void increment() {
    xRot += xRate;
    yRot += yRate;
    zRot += zRate;
  }
  
  void doRotate() {
    
    rotateX(xRot);
    rotateY(yRot);
    rotateZ(zRot);
  }
  
  void resetRotation() {
    rotateX(-xRot);
    rotateY(-yRot);
    rotateZ(-zRot);
  }
}
