import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;

import processing.opengl.*;

Magma wudu;
GravityBehavior gravity;
int NUM_PARTICLES = 2;
int cnt = 0;

void setup() {
  size(1024, 768, OPENGL);
  //smooth();
  noStroke();
  frameRate(120);
  wudu = new Magma();
  addParticles();
  println(wudu.getParticle(0));
}


void addParticles() {
  for (int i=0; i<NUM_PARTICLES; i++) {
    Particle p = new Particle(i+1, int(random(5)), int(random(17))); 
    wudu.addParticle(p);
    wudu.addBehavior(new AttractionBehavior(p, 60, -0.8f, 0.55f));
    wudu.addBehavior(new GravityBehavior(new Vec2D(0, 0.5)));
  }
}

void draw() {
  background(0);
  wudu.update();
  for (Particle p : wudu.particles) {
    p.display();
  }
}


void keyPressed() {
  //wudu.
}

