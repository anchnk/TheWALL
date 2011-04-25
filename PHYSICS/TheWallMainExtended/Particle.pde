 class Particle extends VerletParticle2D {
  
  //private AttractionBehavior ab;
  //private GravityBehavior2D gb;
  
  //private boolean state; // active / inactive
  
  private int id;
  private int dep;
  private int dis;
  
  private float psize;
  private color pcolor;
  
  Particle(int id, int dep, int dis) {
    
    super(Vec2D.randomVector().scale(1).addSelf(width / 2, height / 2));
    
    this.id = id;
    this.dep = dep;
    this.dis = dis;
    
    psize = random(7)+5;
    pcolor = color((int)random(255), (int)random(255), (int)random(255));
    
    //ab = new AttractionBehavior(this, 60, -0.2f, 2.55f);
  }
  
  void display() {
    fill(pcolor);
    //ellipse(this.x, this.y, this.psize, this.psize);
    //rect(x, y, psize, psize);
    
    
    beginShape();
    vertex(x-psize*.5, y-psize*.5);
    vertex(x+psize*.5, y-psize*.5);
    vertex(x+psize*.5, y+psize*.5);
    vertex(x-psize*.5, y+psize*.5);
    endShape();
    
    //println(this.x + " " + this.y + " " + this.psize);
    //println(red(pcolor) + " " + green(pcolor) + " " + blue(pcolor));
  }
  
  int getDep() {
    return dep;
  }
  
  int getDis() {
    return dis;
  }
  
  /*
  void addParticleBehavior(VerletPhysics2D vp) {
    vp.addBehavior(ab);
  }
  
  void removeParticleBehavior(VerletPhysics2D vp) {
    vp.removeBehavior(ab);
  }
  
  void addGravityBehavior(GravityBehavior gb) {
    this.addBehavior(gb);
  }
  
  void removeGravityBehavior(GravityBehavior gb) {
    this.removeBehavior(gb);
  }
  */
}
