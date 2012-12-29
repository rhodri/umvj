class WaveParams {
  public color colour;
  public float freq;
  
  public WaveParams(color colour, float freq) {
    this.colour = colour;
    this.freq = freq;
  }
}

class Waves {
  
  WaveParams[] params;
  
  BandPass[] filters;
  float bandwidth = 100f;
  
  public Waves() {
    // No params or filters!
  }
  
  public Waves(WaveParams[] params) {
    this.params = params;
    this.filters = new BandPass[params.length];
  }
  
  void setup(AudioSource input) {
    if (params != null) {
      for (int i = 0; i < params.length; i++) {
        filters[i] = new BandPass(params[i].freq, bandwidth, input.sampleRate());
      }
    }
  }
  
  void draw(AudioBuffer ab) {
    strokeWeight(3);
    float[] buffer = ab.toArray();
    if (params != null) {
      drawFilters(buffer);
    } else {
      stroke(255);
      drawWaveform(buffer);
    }
    strokeWeight(1);
  }
  
  void drawFilters(float[] buffer) {
    for (int f = 0; f < filters.length; f++) {
      filters[f].process(buffer);
      stroke(params[f].colour);
      drawWaveform(buffer);
    }
  }
  
  void drawWaveform(float[] buffer) {
    for (int i = 0; i < buffer.length - 1; i++) {
      line(i, yForSample(buffer[i]), i+1, yForSample(buffer[i+1]));
    }
  }

  float yForSample(float f) {
    return (height / 2) - f * (height / 2);
  }
}
