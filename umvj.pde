import point2line.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer input;
BeatDetect beat;

ColourWaves colourWaves;
Quads quads;

PImage sum;

int width = 512;
int height = 350;

void setup() {
  size(width, height, P3D);
  int bufferSize = width;
  
  minim = new Minim(this);
  input = minim.loadFile("../breakdown.wav", bufferSize);
  // input = minim.getLineIn(Minim.MONO, bufferSize);
  
  beat = new BeatDetect();
  
  colourWaves = new ColourWaves();
  colourWaves.setup(input);
  
  quads = new Quads();
  
  // TODO: factor out into an effects module
  background(0);
  sum = get(0, 0, width, height);
  
  input.play();
}

void draw() {
  
  beat.detect(input.mix);
  
  background(0);
  stroke(255);
  
  // TODO: factor out into an effects module
  tint(255, 245);
  image(sum, 0, 0);
  noTint();
  
  colourWaves.draw(input.mix);
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
