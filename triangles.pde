class Triangles {
  
  int minSideLen = 20;
  int maxSideLen = 180;
  int padding = 50;
  
  int multiplier= 5;
  
  ArrayList<Poly> quads = new ArrayList<Poly>();
    
  void setup(AudioSource input) {
    // No need
  }
  
  void event(AudioBuffer buffer) {
    
    stroke(#0000FF);
    
    for (int i = 0; i < multiplier; i++) {
      generateAndDraw(buffer);
    }
  }
  
  void generateAndDraw(AudioBuffer buffer) {
    
    Vect2 a = new Vect2(paddedRandom(), paddedRandom());
    Vect2 b = nextRandomPoint(a);
    Vect2 c = nextRandomPoint(b);
    
    drawTriangle(buffer, new Vect2[] { a, b, c });
  }
  
  void drawTriangle(AudioBuffer buffer, Vect2[] points) {
    Vect2 a = points[0], b = points[1], c = points[2];
    triangle(a.x, a.y, b.x, b.y, c.x, c.y);
  }

  float paddedRandom() {
    return random(padding, width - padding);
  }
  
  float limitedRandom(float current, float side) {
                 
    float minimum = (current - minSideLen < padding) ? (current + minSideLen) :
                    (current - maxSideLen < padding) ? padding :
                    (current - maxSideLen);
                 
    float maximum = (current + minSideLen > (side - padding)) ? (current - minSideLen) :
                    (current + maxSideLen > (side - padding)) ? (side - padding) :
                    (current + maxSideLen);
                 
    return random(minimum, maximum);
  }
  
  Vect2 nextRandomPoint(Vect2 p) {                 
    return new Vect2(limitedRandom(p.x, width), limitedRandom(p.y, height));
  }
}

class Poly {
  
  Vect2[] points;
  
  public Poly(Vect2[] points) {
    this.points = points;
  }
  
  void draw() {
    beginShape();
    for (Vect2 p : points) {
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
  } 
}
