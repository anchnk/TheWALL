import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

int NUM_PARTICLES = 458;

VerletPhysics2D physics;
Vec2D mousePos;

void setup() {
  size(2048,768,P3D);
  // setup physics with 10% drag
  physics = new VerletPhysics2D();
  physics.setDrag(0.05f);
  physics.setWorldBounds(new Rect(0, 0, width, height));
  // the NEW way to add gravity to the simulation, using behaviors
  physics.addBehavior(new GravityBehavior(new Vec2D(0, 0.15f)));
}

void addParticle() {
  //VerletParticle2D p = new VerletParticle2D(Vec2D.randomVector().scale(5).addSelf(width / 2, height / 2));
  Particle p = new Particle(random(5)+5);
  physics.addParticle(p.getVp());
  // add a negative attraction force field around the new particle
  physics.addBehavior(new AttractionBehavior(p.getVp(), 20, -1.2f, 0.01f));
}

void draw() {
  background(0,0,0);
  smooth();
  noStroke();
  fill(255);
  if (physics.particles.size() < NUM_PARTICLES) {
    addParticle();
  }
  physics.update();
  for (VerletParticle2D p : physics.particles) {
    ellipse(p.x, p.y, 5, 5);
  }
}

