class PerspectiveGrid {
  
  float horizonPercent = 50;
  float basePercent = 100;
  
  float horizonSpreadPixels = 20;
  float baseSpreadPixels = 100;
  
  float minYSpacingPixels = 2; 
  float ySpacingFactor = 1.5;
  
  color gridColor = #00FF00;
  
  void setup(AudioSource input) {
    // Do nothing.
  }
  
  void draw(AudioBuffer buffer) {
    
    stroke(gridColor);
    strokeWeight(1);
    
    float horizonY = height * (horizonPercent / 100);
    float baseY = height * (basePercent / 100);
    
    // Draw horizontal lines:
    
    line(0, horizonY, width, horizonY);
    
    float yOffset = minYSpacingPixels;
    float drawY = horizonY + yOffset;
    
    while (drawY <= baseY) {
      line(0, drawY, width, drawY);
      yOffset *= ySpacingFactor; 
      drawY = horizonY + yOffset;
    }
    
    // Draw perspective lines:
    
    int numLines = floor(width / horizonSpreadPixels);
    float[] horizonXs = getXs(numLines, horizonSpreadPixels);
    float[] baseXs = getXs(numLines, baseSpreadPixels);
    
    for (int i = 0; i < numLines; i++) {
      line(horizonXs[i], horizonY, baseXs[i], baseY);
    }
  }
  
  float[] getXs(int numPoints, float spreadPixels) {
     
    float firstX = round((width - (spreadPixels * numPoints)) / 2);
        
    float[] xs = new float[numPoints];
    xs[0] = firstX;
    for (int i = 1; i < numPoints; i++) {
      xs[i] = xs[i-1] + spreadPixels;
    }
    
    return xs;
  }
}
