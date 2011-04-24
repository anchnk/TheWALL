class Magma extends VerletPhysics2D {

  Magma() {
    super();
  }

  void initPhysics() {
    int BORDER_RADIUS = 5;
    setDrag(0.01f);
    Rect worldBounds = new Rect(0+BORDER_RADIUS, 0+BORDER_RADIUS, width-2*BORDER_RADIUS, height-2*BORDER_RADIUS);  
    setWorldBounds(worldBounds);
  }
}

