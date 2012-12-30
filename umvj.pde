import point2line.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer input;
BeatDetect beat;

Waves waves;
Quads quads;
PerspectiveGrid grid;

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
    case 's':
      input.skip(1000);
  }
}

void setup() {
  size(width, height, P3D);
  int bufferSize = width;
  
  minim = new Minim(this);
  input = minim.loadFile("../breakdown.wav", bufferSize);
  // input = minim.getLineIn(Minim.MONO, bufferSize);
  
  beat = new BeatDetect();
  beat.setSensitivity(1);

  color[] colours = new color[] { #FF0000, #00FF00, #0000FF };
  float[] freqs = new float[] { 60f, 800f, 2000f };
  
  WaveParams[] params = new WaveParams[] {
    new WaveParams(#FF0000, 60f),
    new WaveParams(#00FF00, 800f),
    new WaveParams(#0000FF, 2000f)
  };
  
  waves = new Waves();
  waves.setup(input);

  quads = new Quads();
  
  grid = new PerspectiveGrid();
  
  // TODO: factor out into an effects module
  background(0);
  sum = get(0, 0, width, height);
}

void draw() {
  
  beat.detect(input.mix);
  
  background(0);
  stroke(255);
  
  // TODO: factor out into an effects module
  tint(255, 240);
  image(sum, 0, 0);
  noTint();
  
  //grid.draw(input.mix);
  // waves.draw(input.mix);
  if (beat.isOnset()) {
     quads.event(input.mix);
  }
  
  sum = get(0, 0, width, height);
}

void stop() {
  input.close();
  minim.stop();
  
  super.stop();
}
