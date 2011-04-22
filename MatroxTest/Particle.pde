Class Particle {
  
  VerletParticle2D verlet;
  float size;

  Particle(float s) {
    size = s;
    vp = new VerletParticle2D(Vec2D.randomVector().scale(size).addSelf(width / 2, height / 2));
  }
  
  VerletParticle2D getVp() {
    return vp;
  }
}
