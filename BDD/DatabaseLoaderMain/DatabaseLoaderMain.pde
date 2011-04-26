DatabaseLoader dbl;
boolean databaseLoaded;
int cnt;
PFont font;

void setup() {
  size(768, 100);
  noStroke();

  background(0);
  textFont(createFont("SansSerif", 12));
  textAlign(CENTER);
  fill(255,192);
  text("Loading Database...", width/2, height/2 - 10);
  fill(255,25);
  dbl = new DatabaseLoader(this, "config.txt");
  dbl.connect();
  dbl.queryNumberOfProjects();
  println(dbl.getNumberOfProjects());
  databaseLoaded = false;

  for (int i=0; i<dbl.getNumberOfProjects(); i++) {
    println("i: " + (i+1) + " dept: " + dbl.getDept(i+1) + " disc: " +  dbl.getDis(i  +1));
  }
  /*
  cnt = 0;
  if(!databaseLoaded) {
    if(cnt<dbl.getNumberOfProjects()) {   
      rect(2 + cnt, height/2, 1, 10);
      println("i: " + (cnt+1) + " dept: " + dbl.getDept(cnt+1) + " disc: " +  dbl.getDis(cnt+1));

      cnt++;
    }
    if(cnt == dbl.getNumberOfProjects())databaseLoaded = true;
  }
  */
}

void draw() {
  //background(0);
}
void stop() {
  dbl.close();
  super.stop();
}

