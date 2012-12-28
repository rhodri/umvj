class ColourWaves {

  color[] colours = new color[] { #FF0000, #00FF00, #0000FF };
  float[] freqs = new float[] { 60f, 800f, 2000f };
  BandPass[] filters = new BandPass[freqs.length];
  float bandwidth = 100f;
  
  void setup(AudioSource input) {
    for (int i = 0; i < freqs.length; i++) {
      filters[i] = new BandPass(freqs[i], bandwidth, input.sampleRate());
    }
  }
  
  void draw(AudioBuffer ab) {
    strokeWeight(2);
    float[] buffer = ab.toArray();
    for (int f = 0; f < filters.length; f++) {
      filters[f].process(buffer);
      stroke(colours[f]);
      for (int i = 0; i < buffer.length - 1; i++) {
        line(i, yForSample(buffer[i]), i+1, yForSample(buffer[i+1]));
      }
    }
    strokeWeight(1);
  }

  float yForSample(float f) {
    return (height / 2) - f * (height / 2);
  }
}
