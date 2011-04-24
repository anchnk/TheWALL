import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;
import de.bezier.data.sql.*;

/**************  VARIABLES **************/
int NUM_PARTICLES = 458;

Magma wudu;
Database db; 


boolean selectParticle = false;

void setup() {
  size(1024, 768);
  db = new Database(this);
  db.start();
  wudu = new Magma();
  wudu.initPhysics();
  addParticles(NUM_PARTICLES);
}


void addParticles(int n) {
  for (int i=0; i<n; i++) {
    Particle p = new Particle(i+1, int(random(5)), int(random(17)));
    wudu.addParticle(p);
    wudu.addBehavior(new AttractionBehavior(p, 60, -0.8f, 0.55f));
  }
}

void draw() {
  background(0);

  wudu.update();
  for (int i = wudu.particles.size()-1; i>=0; i--) {
    Particle p = (Particle)wudu.particles.get(i);
    if(p.getDep() == 3 && selectParticle) {
      p.addBehavior(new GravityBehavior(new Vec2D(0, 0.15f)));
    }
    p.display();
  }
}

void keyPressed() {
  selectParticle = true;
}

