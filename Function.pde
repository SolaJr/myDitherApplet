
void dilate() {
  //UiBooster booster = new UiBooster();
  //File myFile = booster.showFileSelection();
  //File myFile = booster.showDirectorySelection();

  boolean condition = true; 
  
  //PImage img = loadImage(myFile.getAbsolutePath());
  surface.setSize(img.width, img.height);
      
  color[][] filteredColors = morphFilterCircle(img, delta, false);
  //Set Colors
  for (int x = 0; x < widthMax; x++) {
    for (int y = 0; y < heightMax; y++) {
      
      
      set(x,y,filteredColors[y][x]); 
    }
  }
  save("output.jpg");
}

void delta(){
  delta  = new UiBooster().showSlider("Chose the radius here", "Your order", 
                0, 10, 2, 5, 1);
}

color[][] morphFilterCircle(PImage img, int filterRadius, boolean isErosion) {
  int N = filterRadius*2 + 1;
  
  //Calculate Weights
  float[][] weights = new float[N][N];
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      float u = i - 0.5*(N-1);
      float v = j - 0.5*(N-1);
      float value = u*u + v*v - filterRadius*filterRadius;
      weights[i][j] = value < 0 ? 1 : 0;
    }
  }
      
  return isErosion ? erosion(img, filterRadius, weights) : dilation(img, filterRadius, weights);
}


color[][] erosion(PImage img, int filterRadius, float[][] weights) {
  int N = filterRadius*2 + 1;
  color[][] filteredColors = new color[height][width];
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float red = 1;
      float green = 1;
      float blue = 1;
      
      float minAvg = 1;
     
      //Filter color happens here 
      for (int i = 0 ; i < N; i++) {
        for (int j = 0; j < N; j++) {
           float weight = weights[i][j];
           float u = x + i - 0.5*(N-1);
           float v = y + j - 0.5*(N-1);
           if (u < 0) {
             u = abs(u); 
           } else if (u >= width) {
             u = width - 1;
           }
           if (v < 0) {
             v = abs(v); 
           } else if (v >= height) {
             v = height - 1;
           }
           
           if (weight > 0) {
             float r = weight*red(img.get((int)u,(int)v));
             float g = weight*green(img.get((int)u,(int)v));
             float b = weight*blue(img.get((int)u,(int)v));
             float currentAvg = (r + g + b)/3.0;
             float newMinAvg = min(currentAvg, minAvg);
             if (newMinAvg < minAvg) {
                minAvg = newMinAvg;
                red = r;
                green = g;
                blue = b;
             }
           }
         }
      }
      filteredColors[y][x] = color(red,green,blue);
    }
  }
  return filteredColors;
}

color[][] dilation(PImage img, int filterRadius, float[][] weights) {
  int N = filterRadius*2 + 1;
  color[][] filteredColors = new color[height][width];
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float red = 0;
      float green = 0;
      float blue = 0;
      
      float maxAvg = 0;
     
      //Calculate Filterd Colors
      for (int i = 0 ; i < N; i++) {
        for (int j = 0; j < N; j++) {
           float weight = weights[i][j];
           float u = x + i - 0.5*(N-1);
           float v = y + j - 0.5*(N-1);
           if (u < 0) {
             u = abs(u); 
           } else if (u >= width) {
             u = width - (u - width); 
           }
           if (v < 0) {
             v = abs(v); 
           } else if (v >= height) {
             v = height - (u - height); 
           }
           
           float r = weight*red(img.get((int)u,(int)v));
           float g = weight*green(img.get((int)u,(int)v));
           float b = weight*blue(img.get((int)u,(int)v));
           float currentAvg = (r + g + b)/3.0;
           float newMaxAvg = max(currentAvg, maxAvg);
           if (newMaxAvg > maxAvg) {
              maxAvg = newMaxAvg;
              red = r;
              green = g;
              blue = b;
           } 
         }
      }
      filteredColors[y][x] = color(red,green,blue);
    }
  }
  return filteredColors;
}
