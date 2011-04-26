 class Particle extends VerletParticle2D {
  
  private AttractionBehavior ab; // inter-particules
  private VerletParticle2D attach;
  private VerletSpring2D spring;
  //private AttractionBehavior cb; // centre
  //private GravityBehavior2D gb;
  
  //private boolean state; // active / inactive
  
  private ParticleInfo pInfo;
  
  float pSize;
  color pColor;
  float pColorFactor;
  private PImage im;
  
  boolean attracted = false;
  boolean gravited = false;
  boolean enabled = true;
  
  Particle(ParticleInfo pInfo) {
    
    super(Vec2D.randomVector().scale(1).addSelf(width / 2, height / 2));
    //super(Vec2D.randomVector().scale(1).addSelf(random(width), random(height)));
    
    this.pInfo = pInfo;
    
    pSize = random(7)+5;
    pColor = dis_colors[pInfo.getDis()];
    pColorFactor = 1f;
    //im = loadImage("halo dot.bmp");
    //im = loadImage("forme.png");
    
    ab = new AttractionBehavior(this, 60, -0.2f, 2.55f);
    attach = new VerletParticle2D(0,0);
    attach.lock();
    //spring = new VerletConstrainedSpring2D(attach, this, 0, 0.003f, 0.5f);
    spring = new VerletSpring2D(attach, this, 0, 0.004f);
  }
  
  void display() {
    
    fill(red(pColor), green(pColor), blue(pColor), (int)(pColorFactor*255));
    
    //ellipse(x, y, pSize, pSize);
    //rect(x, y, pSize, pSize);
    
    //tint(pColor, (int)(pColorFactor*255));
    //image(im, x, y, pSize, pSize);
    
    //*
    beginShape();
    //texture(im);
    vertex(x-pSize*.5, y-pSize*.5);
    vertex(x+pSize*.5, y-pSize*.5);
    vertex(x+pSize*.5, y+pSize*.5);
    vertex(x-pSize*.5, y+pSize*.5);
    endShape();
    //*/
    
    //noTint();
  }
  
  int getId() {
    return pInfo.getId();
  }
  
  int getDep() {
    return pInfo.getDep();
  }
  
  int getDis() {
    return pInfo.getDis();
  }
  
  void enableParticle(boolean on, VerletPhysics2D vp) {
    if(on) {
      vp.addParticle(this);
      enabled = true;
    }
    else {
      vp.removeParticle(this);
      enabled = false;
    }
  }
  
  // _________ inter particle behavior _____________
  
  void addParticleBehavior(VerletPhysics2D vp) {
    if(!attracted) {
      vp.addBehavior(ab);
      attracted = true;
    }
  }
  
  void removeParticleBehavior(VerletPhysics2D vp) {
    if(attracted) {
      vp.removeBehavior(ab);
      attracted = false;
    }
  }
  
  void setParticleBehavior(VerletPhysics2D vp, float radius, float attraction, float jitter) {
    if(attracted) {
      vp.removeBehavior(ab);
    }
    ab = new AttractionBehavior(this, radius, attraction, jitter);
    if(attracted) {
      vp.addBehavior(ab);
    } 
  }
  
  // _________ center attraction behavior _____________
  /*
  void addAttractionBehavior(VerletPhysics2D vp) {
    //if(!attracted) {
      vp.addBehavior(cb);
    //  attracted = true;
    //}
  }
  
  void removeAttractionBehavior(VerletPhysics2D vp) {
    //if(attracted) {
      vp.removeBehavior(cb);
    //  attracted = false;
    //}
  }
  */
  
  // ____________ spring attraction behavior ___________
  
  void addSpringBehavior(VerletPhysics2D vp, Vec2D vec) {
    vp.addSpring(spring);
    attach.x = vec.x;
    attach.y = vec.y;
    vp.addParticle(attach);
  }
  
  void removeSpringBehavior(VerletPhysics2D vp) {
    vp.removeSpring(spring);
    vp.removeParticle(attach);
  }
  
  // _____________ gravity behavior ___________________
  
  void addGravityBehavior(GravityBehavior gb) {
    this.addBehavior(gb);
    //gravited = true;
  }
  
  void removeGravityBehavior(GravityBehavior gb) {
    this.removeBehavior(gb);
    //gravited = false;
  }
}
