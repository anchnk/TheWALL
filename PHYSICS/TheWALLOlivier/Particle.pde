class Particle extends VerletParticle2D {

  /********************************************************************************************************************
   *                                                    FIELDS                                                        *
   ********************************************************************************************************************/
  private int pId;  // id de la particule (db table wp_posts champ ID)
  private int pDep; // departement rattaché a la particule (db table wp_postmeta champ meta_key='domaine_du_projet')
  private int pDis; // discipline rattachée à la particule (db table wp-postmeta champ meta_key='etab_dep')

  private float pSize;
  private color pColor;

  int cnt;

  /********************************************************************************************************************
   *                                                 CONSTRUCTORS                                                     *
   *******************************************************************************************************************/

  /**
   * Crée une particule avec une direction aléatoire placée au mieu de l'écran et la lie avec les valeurs de la bdd
   * --------------------------------------------------------------------------------------------------------------
   * @param id   id de la particule
   * @param dep  département du projet auquel est lié cette particule
   * @param dis  discipline du projet a laquelle est liée cette particule
   */
  Particle(int id, int dep, int dis) {
    super(Vec2D.randomVector().scale(1).addSelf(width/2, height/2));
    pId = id;
    pDep = dep;
    pDis = dis;
    pSize = random(7)+5;
    pColor = color((int)random(255), (int)random(255), (int)random(255));
  }

  /********************************************************************************************************************
   *                                                   METHODS                                                        *
   ********************************************************************************************************************/
  Particle display() 
  {
    fill(pColor);
    beginShape();
    vertex(x-pSize*.5, y-pSize*.5);
    vertex(x+pSize*.5, y-pSize*.5);
    vertex(x+pSize*.5, y+pSize*.5);
    vertex(x-pSize*.5, y+pSize*.5);
    endShape();
    return this;
  }


  /********************************************************************************************************************
   *                                                  ACCESSORS                                                       *
   *******************************************************************************************************************/
  int getDep() {
    return pDep;
  }

  int getDis() {
    return pDis;
  }

  float getSize() {
    return pSize;
  }
}

