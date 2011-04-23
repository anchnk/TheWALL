class Magma extends VerletPhysics2D {

  GravityBehavior gravity;
  ArrayList<Particle> particles;
  
  Magma() {
    super();
    particles = new ArrayList<Particle>();
    initPhysics();
  }
  
  Magma addParticle(Particle p) {
    particles.add(p);
    return this;
  }
  
  
  
  //public void addBehavior(ParticleBehavior2D behavior) {
  //      behavior.configure(timeStep);
  //      behaviors.add(behavior);
  //  }


  void initPhysics() {
    final int BORDER_RADIUS = 5;
    setDrag(0.01f);
    setWorldBounds((new Rect(0+BORDER_RADIUS, 0+BORDER_RADIUS, width-2*BORDER_RADIUS, height-2*BORDER_RADIUS)));
    gravity = new GravityBehavior(new Vec2D(0,0.3f));
  }
  
  Particle getParticle(int i) {
    return particles.get(i);
  }
  
  //void addParticle(Particle p) {
  //}

    //Magma(Vec2D gravity, int numIterations, float drag, float timeStep)
}

