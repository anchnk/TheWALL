import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;

import processing.opengl.*;

int NUM_PARTICLES = 450;
float BORDER_RADIUS = 5;

Vec2D mousePos;

Magma wudu;

void setup() {
  size(2048,768,OPENGL);
  frameRate(999);
  //smooth();
  noStroke();

  wudu = new Magma(NUM_PARTICLES);
  for(int i=0; i<NUM_PARTICLES; i++) {
    wudu.addParticle(i,33,1);
  }
}

void draw() {
  background(0,0,0);
  wudu.update();
  println(frameRate);
}

void keyPressed() {
  switch(key) {

  case 'a' :
    wudu.addGravityBehavior(NUM_PARTICLES / 2);
    break;

  case 'z' :
    wudu.removeGravityBehavior(NUM_PARTICLES / 2);
    break;

  default :
    break;
  }
}

