import point2line.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer input;
BeatDetect beat;

Waves waves;
Triangles tris;
PerspectiveGrid grid;
Polyhedra hedra;

PImage sum;

int width = 1024;
int height = 768;

boolean sketchFullScreen() {
  return true;
}

void keyPressed() {
  
  switch (key) {
    case ' ':
      if (input.isPlaying()) {
        input.pause();
      } else {
        input.play();
      }
      break;
    case 'R':
    case 'r':
      input.rewind();
      break;
    case 'S':
      input.skip(10000);
      break;
    case 's':
      input.skip(1000);
      break;
    case 'A':
      input.skip(-10000);
      break;
    case 'a':
      input.skip(-1000);
      break;
    case 'X':
    case 'x':
      hedra.incrementComplexity();
      break;
  }
}

void setup() {
  size(width, height, OPENGL);
  smooth();
  
  int bufferSize = width;
  
  minim = new Minim(this);
  input = minim.loadFile("../breakdown.wav", bufferSize);
  // input = minim.getLineIn(Minim.MONO, bufferSize);
  
  beat = new BeatDetect();
  beat.setSensitivity(0);
  
  WaveParams[] params = new WaveParams[] {
    new WaveParams(#FF0000, 60f),
    new WaveParams(#00FF00, 600f),
    new WaveParams(#0000FF, 1200f)
  };
  
  waves = new Waves();
  waves.setup(input);

  tris = new Triangles();
  
  grid = new PerspectiveGrid();
  
  hedra = new Polyhedra();
  
  // TODO: factor out into an effects module
  background(0);
  sum = get(0, 0, width, height);
}

void draw() {
  
  delay(5);
  
  beat.detect(input.mix);
  
  background(0);
  stroke(255);
  
  // TODO: factor out into an effects module
  tint(255, 220);
  image(sum, 0, 0);
  noTint();
  
  //grid.draw(input.mix);
  waves.draw(input.mix);
  if (beat.isOnset()) {
     //tris.event(input.mix);
  }
  //hedra.draw();
  
  sum = get(0, 0, width, height);
}

void stop() {
  input.close();
  minim.stop();
  
  super.stop();
}
