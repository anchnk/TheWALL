import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

import processing.opengl.*;

int NUM_PARTICLES = 458;
float BORDER_RADIUS = 5;

VerletPhysics2D physics;
Vec2D mousePos;
Particle[] parts = new Particle[NUM_PARTICLES];

void setup() {
  size(2048,768,OPENGL);
  frameRate(30);
  // setup physics with 10% drag
  physics = new VerletPhysics2D();
  physics.setDrag(0.01f);
  physics.setWorldBounds(new Rect(0+BORDER_RADIUS, 0+BORDER_RADIUS, width-2*BORDER_RADIUS, height-2*BORDER_RADIUS));
  // the NEW way to add gravity to the simulation, using behaviors
  //physics.addBehavior(new GravityBehavior(new Vec2D(0, 0.15f)));
}

void addParticle(int s) {
  //VerletParticle2D p = new VerletParticle2D(Vec2D.randomVector().scale(5).addSelf(width / 2, height / 2));
  parts[s] = new Particle(random(7)+5, color((int)random(255), (int)random(255), (int)random(255)));
  physics.addParticle(parts[s]);
  // add a negative attraction force field around the new particle
  physics.addBehavior(new AttractionBehavior(parts[s], 60, -0.2f, 2.55f));
}

void draw() {
  background(0,0,0);
  //println(frameRate);
  smooth();
  noStroke();
  fill(255);
  if (physics.particles.size() < NUM_PARTICLES) {
    addParticle(physics.particles.size());
  }
  physics.update();
  for (int i=0; i<physics.particles.size(); i++) {
    fill(parts[i].getColor());
    //println(parts[i].getColor());
    //noStroke();
    ellipse(parts[i].x, parts[i].y, parts[i].getSize(), parts[i].getSize());
  }
}

