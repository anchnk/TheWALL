//import toxi.geom.*;

class Particle extends VerletParticle2D {
  
  //VerletParticle2D vp;
  float psize;
  color pcolor;

  Particle(float s, color c) {
    super(Vec2D.randomVector().scale(s).addSelf(width / 2, height / 2));
    psize = s;
    pcolor = c;
  }
  /*
  VerletParticle2D getVp() {
    return vp;
  }
  */
  float getSize() {
    return psize;
  }
  
  color getColor() {
    return pcolor;
  }
}
