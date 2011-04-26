DBThread dbt;


int NUM_PARTICLES;


void setup() {
  size(1024,100);
  noStroke();
  dbt = new DBThread(this, "config.txt");
  dbt.connect();
  dbt.start();
  NUM_PARTICLES = dbt.getNumberOfProjects();
  dbt.loadDatabase();
}

void draw() {
  background(0);
  fill(255, 127);
  rect(10, height/2, (float(dbt.getCounter())/NUM_PARTICLES)*(width-20), 10);
  if(dbt.done()) {
  }
}

void stop() {
    dbt.close();
    super.stop();
}



