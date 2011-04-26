class Magma { // extends VerletPhysics2D ?

  final int MAX_INCREMENT = 100;
  
  /*
  0 : defaut (etat 0),
  1 : transition vers etat 1,
  2 : etat 1,
  3 : transition vers etat 2,
  4 : etat 2,
  5 : transition vers etat 0
  */
  int etat;

  VerletPhysics2D moteur;
  GravityBehavior gravite;
  //AttractionBehavior interattraction;
  
  Particle[] particules;
  int nparticules;
  
  ArrayList pEcartees;
  ArrayList pSelectionnees;
  
  int increment;
  boolean incrementant;
  
  // ____________________________________________ constructeur ______________________________________________________
  
  Magma(int nparticules) {
    
    this.nparticules = nparticules;
    particules = new Particle[nparticules];
    
    pEcartees = new ArrayList();
    pSelectionnees = new ArrayList();
    incrementant = false;
    etat = 0;
    
    moteur = new VerletPhysics2D();
    moteur.setDrag(0.015f);
    moteur.setWorldBounds(new Rect(0+BORDER_RADIUS, 0+BORDER_RADIUS, width-2*BORDER_RADIUS, height-2*BORDER_RADIUS));
    
    gravite = new GravityBehavior(new Vec2D(0,0.5f));
    //interattraction = new AttractionBehavior(new Vec2D(0,0), 350, 1f);
  }
  
  // _______________________________ fonction update : gere les transitions _________________________________________
  
  void update() {
    moteur.update();
    
    if(etat == 1) {
      //println(increment);
      if(increment < MAX_INCREMENT) {
        particlesFadeOut(pEcartees, increment);
        increment++;
      }
      else {
        endTransition1();
      }
    }
    
    for(int i=0; i<nparticules; i++) {
      if(particules[i]!=null && particules[i].enabled) {
        particules[i].display();  
      }
    }    
  }
  
  // ______________________________ fonctions mouse et click : gerent un genre de souris osc _____________________________
  
  void mouse(float x, float y) {
    
  }
  
  void click() {
    
  }
  
  // ________________________ creation + ajout d'une particule creee depuis une ParticleInfo ______________________________
  
  void addParticle(ParticleInfo pInfo) {
    particules[pInfo.getId()-1] = new Particle(pInfo);
    moteur.addParticle(particules[pInfo.getId()-1]);
    particules[pInfo.getId()-1].addParticleBehavior(moteur);
  }
  
  // selection de l'ensemble des particules possedant a la fois un certain departement et une certaine dscipline,
  // ou selection de l'ensemble oppose (them==true : l'ensemble, them==false, l'oppose)
  
  boolean selectParticles(int dep, int dis) {
    for(int i=0; i<nparticules; i++) {
      if(particules[i]!=null) {
         if(particules[i].getDep() != dep || particules[i].getDis() != dis) {
           pEcartees.add(particules[i].getId()-1);
         }
         else if(particules[i].getDep() == dep && particules[i].getDis() == dis) {
           pSelectionnees.add(particules[i].getId()-1);
         }
      }
    }
    if(pSelectionnees.size()>0) {
      removeParticleBehavior(pEcartees);
      addGravityBehavior(pEcartees);
      launchTransition1();
      return true;
    }
    else {
      pEcartees = new ArrayList();
      pSelectionnees = new ArrayList();            
      return false;
    }
  }    
  
  void launchTransition1() {
    etat = 1;
    //incrementant = true;
    increment = 0;
  }
  
  void endTransition1() {
    particlesFadeOut(pEcartees, increment);
    for(int i=0; i<pEcartees.size(); i++) {
      int j = (Integer)(pEcartees.get(i));
      particules[j].enableParticle(false, moteur);
    }
    incrementant = false;
    
    // ici on change le comportement des boules au moment ou elles sont rattachees aux elastiques
    moteur.setDrag(0.5f);
    setParticleBehavior(pSelectionnees, 200, -25f, 0f);
    addParticleAttractor(pSelectionnees);
    etat = 2;
  }
  
  boolean reset() {
    if(etat != 1) {
      removeParticleAttractor(pSelectionnees);
      removeGravityBehavior(pEcartees);
      addParticleBehavior(pEcartees);
      setParticleBehavior(pSelectionnees, 60, -0.2f, 2.55f);
      moteur.setDrag(0.015f);
    
      for(int i=0; i<pEcartees.size(); i++) {
        int j = (Integer)(pEcartees.get(i));
        particules[j].pColorFactor = 1;
        particules[j].enableParticle(true, moteur);
      }
      pEcartees = new ArrayList();
      pSelectionnees = new ArrayList();
      etat = 0;
      return true;
    }
    else {
      return false;
    }
  }
  
  // changer le comportement d'un ensemble de particules ____________________________________
  
  void setParticleBehavior(ArrayList indexes, float radius, float attraction, float jitter) {
    for(int i=0; i<indexes.size(); i++) {
      int j = (Integer)(indexes.get(i));
      if(particules[j]!=null) {
        particules[j].setParticleBehavior(moteur, radius, attraction, jitter);
      }
    }
  }
  
  void addParticleBehavior(ArrayList indexes) {
    for(int i=0; i<indexes.size(); i++) {
      int j = (Integer)(indexes.get(i));
      if(particules[j]!=null) {
        particules[j].addParticleBehavior(moteur);
      }
    }
  }
    
  void removeParticleBehavior(ArrayList indexes) {
    for(int i=0; i<indexes.size(); i++) {
      int j = (Integer)(indexes.get(i));
      if(particules[j]!=null) {
        particules[j].removeParticleBehavior(moteur);
      }
    }
  }

  // activer le comportement du mode sous-groupe __________________________________________
  
  void addParticleAttractor(ArrayList indexes) {
    for(int i=0; i<indexes.size(); i++) {
      int j = (Integer)(indexes.get(i));
      if(particules[j]!=null) {
        particules[j].addSpringBehavior(moteur, new Vec2D(width/2, height/2));
      }
    }
  }

  void removeParticleAttractor(ArrayList indexes) {
    for(int i=0; i<indexes.size(); i++) {
      int j = (Integer)(indexes.get(i));
      if(particules[j]!=null) {
        particules[j].removeSpringBehavior(moteur);
      }
    }
  }

  // activation / desactivation des GravityBehavior et des ParticleAttractor ______________
  
  void addGravityBehavior(ArrayList indexes) {
    for(int i=0; i<indexes.size(); i++) {
      int j = (Integer)(indexes.get(i));
      if(particules[j]!=null) {
        particules[j].addGravityBehavior(gravite);
      }
    }
  }
    
  void removeGravityBehavior(ArrayList indexes) {
    for(int i=0; i<indexes.size(); i++) {
      int j = (Integer)(indexes.get(i));
      if(particules[j]!=null) {
        particules[j].removeGravityBehavior(gravite);
      }
    }
  }
 
  // fades graphiques ______________________________________________________________________
  
  void particlesFadeOut(ArrayList indexes, int increment) {
    for(int i=0; i<indexes.size(); i++) {
      int j = (Integer)(indexes.get(i));
      particules[j].pColorFactor = (1f - ((float)increment / (float)MAX_INCREMENT));
    }
  }
}
