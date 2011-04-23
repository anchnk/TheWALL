class Magma { // extends VerletPhysics2D ?

  VerletPhysics2D vp;
  GravityBehavior gb;
  
  Particle[] parts;
  int nparts;
  
  Magma(int nparts) {
    
    
    this.nparts = nparts;
    parts = new Particle[nparts];
    
    vp = new VerletPhysics2D();
    vp.setDrag(0.01f);
    vp.setWorldBounds(new Rect(0+BORDER_RADIUS, 0+BORDER_RADIUS, width-2*BORDER_RADIUS, height-2*BORDER_RADIUS));
    
    gb = new GravityBehavior(new Vec2D(0,0.15f));
  }
  
  void addParticle(int id, int dep, int dis) {
    parts[id] = new Particle(id, dep, dis);
    vp.addParticle(parts[id]);
    parts[id].addParticleBehavior(vp);
  }
  
  void update() {
    vp.update();
    
    for(int i=0; i<nparts; i++) {
      if(parts[i]!=null) {
        parts[i].display();
        //println(i);
      }
    }    
  }
  
  void selectParticles(int dep, int dis) {
    for(int i=0; i<nparts; i++) {
      if(parts[i]!=null) {
         if(parts[i].getDep() != dep && parts[i].getDis() != dis) {
           
         }
      }
    }
  }    
  
  //*
  void addGravityBehavior(int n) {
    for(int i=0; i<n; i++) {
      if(parts[i]!=null) {
        parts[i].addGravityBehavior(gb);
        //println(i);
      }
    }
  }
    
  void removeGravityBehavior(int n) {
    for(int i=0; i<n; i++) {
      if(parts[i]!=null) {
        parts[i].removeGravityBehavior(gb);
        //println(i);
      }
    }
  }
 
}
