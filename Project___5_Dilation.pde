import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.utils.*;

PImage img;
int delta = 5;
int widthMax = 460;
int heightMax = 268;
void setup(){

  img = loadImage("ringhistory.jpg");
  System.out.println("Width is... " + img.width);
  System.out.println("Height is... " + img.height);
  size(460,268);
}

void draw(){
  delta();
  dilate();
  

}
