/**
 * <p>Premiere implémentation du test de filtrage de particule</p>
 * <ul>
 *   <li>@author : anchnk</li>
 *   <li>@date : 22042011</li>
 * </ul>
 */


final int NUM_PARTICLES = 3;
Boule[] boules = new Boule[NUM_PARTICLES];

void setup() {
  size(400, 200);
  boules[0] = new Boule(random(width), 10, 20 , 64);
    boules[0] = new Boule(random(width), 10, 20 , 64);
      boules[0] = new Boule(random(width), 10, 20 , 64);
}

void draw() {
   for (Boule b : boules) {
    b.update();
    b.afficher();
  }
}

class Boule {
  
  int id;
  color couleur;
  float taille;
  PVector pos;
  float gravity;
  int departement;
  
  Boule() {
    this(width/2, height/2, 20, 64);
  }
  
  Boule(float x, float y, float t, int dept) {
    pos = new PVector(x, y);
    taille = t;
    departement = dept;
    gravity = .2f;
  }
  
  void update() {
    pos.mult(gravity);
  }
  
  void afficher() {
    ellipse(pos.x, pos.y, taille, taille);
  }
}


