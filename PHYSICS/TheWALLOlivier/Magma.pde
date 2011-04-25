class Magma extends VerletPhysics2D {

  int BORDER_RADIUS;

  /********************************************************************************************************************
   *                                                 CONSTRUCTORS                                                     *
   ********************************************************************************************************************/
  Magma() {
    super();
  }

  /********************************************************************************************************************
   *                                                   METHODS                                                        *
   ********************************************************************************************************************/
  void initPhysics() {
    BORDER_RADIUS = 5;
    setDrag(0.01f);
    Rect worldBounds = new Rect(0+BORDER_RADIUS, 0+BORDER_RADIUS, width-2*BORDER_RADIUS, height-2*BORDER_RADIUS);  
    setWorldBounds(worldBounds);
  }

  void display() {
    for (int i = wudu.particles.size()-1; i>=0; i--) {
      Particle p = (Particle)wudu.particles.get(i);
      if(p.getDep() == 33 && selectParticle) {
        p.addBehavior(new GravityBehavior(new Vec2D(0, 0.15f)));
      }
      if(p.getDep() == 33 && selectParticle && p.y > height-p.getSize()) {
        wudu.removeParticle(wudu.particles.get(i));
      }
      p.display();
    }
  }

  void addParticles(int n) {
    for (int i=0; i<n; i++) {
      if(db.isConnected()) {
        Particle p = new Particle(i+1, db.returnDept(i+1), int(random(17)));
        println("i: " + (i+1) + "dept :" + p.getDep()); 
        //Particle p = new Particle(i+1, int(random(5)), int(random(17)));
        wudu.addParticle(p);
        wudu.addBehavior(new AttractionBehavior(p, 60, -0.2f, 0.55f));
      }
      else {
        println("Connexion a la base de donnée non établie");
      }
    }
  }
}

