class Particle extends VerletParticle2D {
  
  //VerletParticle2D vp;
  float psize;

  Particle(float s) {
    psize = s;
    super(Vec2D.randomVector().scale(psize).addSelf(width / 2, height / 2));
  }
  
  VerletParticle2D getVp() {
    return vp;
  }
  
  float getSize() {
    return psize;
  }
}
