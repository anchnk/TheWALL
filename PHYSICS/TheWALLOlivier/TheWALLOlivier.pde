import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;
import de.bezier.data.sql.*;

/**************  VARIABLES **************/
int NUM_PARTICLES = 450;

Magma wudu;
DatabaseNoThread db; 

int MODE;
final int MAGMA = 0;
final int AFFICHER_PROJET = 1;

boolean selectParticle = false;

void setup() {
  size(1024, 768);
  noStroke();
  db = new DatabaseNoThread(this);
  db.connect();
  wudu = new Magma();
  wudu.initPhysics();
  wudu.addParticles(NUM_PARTICLES);
}

void draw() {
  switch(MODE) 
  {
    case MAGMA:
      background(0);
      wudu.update();
      wudu.display();
      break;

    case AFFICHER_PROJET:
      background(255);
      break;
  }
  println(wudu.particles.size());
}

void keyPressed() {
  switch(key)
  {
    case 's':
      selectParticle = true;
      break;

    case 'm':
      MODE++;
      MODE%=2;
      break;
  }
}

