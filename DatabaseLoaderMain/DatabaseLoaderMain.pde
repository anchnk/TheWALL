DatabaseLoader dbl;
boolean databaseLoaded;
float startTime;
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
  startTime = millis();
  cnt = 0;
}

void draw() {
  //background(0);
  if(!databaseLoaded) {
    if(cnt<dbl.getNumberOfProjects()) {   
      rect(2 + cnt, height/2, 1, 10);
      println("i: " + (cnt+1) + " dept: " + dbl.getDept(cnt+1) + " disc: " +  dbl.getDis(cnt+1));
      startTime = millis();
      cnt++;
    }
    if(cnt == dbl.getNumberOfProjects())databaseLoaded = true;
  }
}
void stop() {
  dbl.close();
  super.stop();
}

