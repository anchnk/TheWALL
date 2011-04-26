import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;

import oscP5.*;
import netP5.*;

import processing.opengl.*;

// _________________ LE GROS BOUSIN (CONSTANTES) ________________________

final int DORDOGNE = 24;
final int GIRONDE = 33;
final int LANDES = 40;
final int LOT_ET_GARONNE = 47;
final int PYRENEES = 64;

final int deps[] = {
  DORDOGNE, GIRONDE, LANDES, LOT_ET_GARONNE, PYRENEES
};

final int ARTS_PLASTIQUES = 0;
final int BENEVOLES = 1;
final int CENTRE_DE_PRESSE = 2;
final int DANSE = 3;
final int DEBATS = 4;
final int DEFILE_DE_MODE = 5;
final int DIVERS = 6;
final int ECRITURE = 7;
final int EXPOSITION_PHOTO = 8;
final int MATCH_D_IMPROVISATION = 9; 
final int MULTIMEDIA = 10;
final int MUSIQUE = 11;
final int SCIENCES = 12;
final int SLAM = 13;
final int SPECTACLE_DE_RUE = 14;
final int THEATRE = 15;
final int VIDEO = 16;
final int DISCIPLINE_INDEFINIE = 17;

final color dis_colors[] = {
  #85004B,
  #006363,
  #ffff40,
  #ad66d5,
  #ff7400,
  #33cccc,
  #679b00,
  #fefefe,
  #009999,
  #838281,
  #f0028e,
  #1240ab,
  #bfbf30,
  #585655,
  #832609,
  #951174,
  #d6e30d,
  #004591
};

final int KINECT_IN_PORT = 8000;
final int KINECT_OUT_PORT = 8001;
final String KINECT_ADDRESS = "127.0.0.1";

final int RT1_IN_PORT = 8002;
final int RT1_OUT_PORT = 8003;
final String RT1_ADDRESS = "127.0.0.1";

final int RT2_IN_PORT = 8004;
final int RT2_OUT_PORT = 8005;
final String RT2_ADDRESS = "127.0.0.1";

final int PD_IN_PORT = 8006;
final int PD_OUT_PORT = 8007;
final String PD_ADDRESS = "127.0.0.1";

// _________________ FIN DU GROS BOUSIN ___________________________

int NUM_PARTICLES;
float BORDER_RADIUS = 5;

DBThread dbt;
boolean firstFrame;

Vec2D mousePos;

Magma wudu;
ArrayList displayed_particles = new ArrayList();
ArrayList hidden_particles = new ArrayList();
char tmp_key = ' ';

TheWallOSC osc = new TheWallOSC();

// ____________________________________________ SETUP ____________________________________

void setup() {
  size(2048,768,OPENGL);
  frameRate(60);
  noStroke();

  dbt = new DBThread(this, "config.txt");
  dbt.connect();
  dbt.start();
  NUM_PARTICLES = dbt.getNumberOfProjects();
  dbt.loadDatabase();
  firstFrame = true;

  wudu = new Magma(NUM_PARTICLES);
}

// ____________________________________________ DRAW ____________________________________

void draw() {

  if(!dbt.done()) {
    background(0);
    fill(255, 127);
    rect(width/4, height/2, (float(dbt.getCounter())/NUM_PARTICLES)*(width/2), 10);
  }
  else {
    if(firstFrame) {
      for(int i=0; i<NUM_PARTICLES; i++) {
        wudu.addParticle(dbt.particlesInfos[i]);
        //wudu.addParticle(new ParticleInfo(i, deps[(int)(random(4))], (int)(random(17))));
      }
      firstFrame = false;
      //println(wudu.particules.length);
    }

    background(0);
    wudu.update();

    switch(wudu.etat) {
      case(0) :
      if(osc.rt1_pattern != -1 && osc.rt2_pattern != -1) {
        wudu.selectParticles(osc.rt1_pattern, osc.rt2_pattern);
      }
      //wudu.etat = 1;
      //osc.sendToPureData(wudu.particules);
      break;

      case(2) :
      /*
      wudu.mouse(osc.kinect_x, osc.kinect_y);
       if(osc.kinect_clicked) {
       osc.kinect_clicked = false;
       wudu.click();
       }
       */
      break;

      case(4) :
      /*
      wudu.mouse(osc.kinect_x, osc.kinect_y);
       if(osc.kinect_clicked) {
       osc.kinect_clicked = false;
       wudu.click();
       }
       */
      break;

    default :
      break;
    }
  }

  println(frameRate);
}

void keyPressed() {
  switch(key) {

  case 'a' :
    if(tmp_key != 'a') { 
      int dep = deps[(int)(random(5))];
      int dis = (int)(random(17));
      if(!wudu.selectParticles(dep, dis)) {
        // afficher si aucun post ne correspond aux filtres
      }
      else {
        tmp_key = 'a';
      }
    }
    break;

  case 'z' :
    if(tmp_key != 'z') { 
      if(wudu.reset()) {
        tmp_key = 'z';
      }
    }
    break;

  default :
    break;
  }
}

void stop() {
  dbt.close();
  super.stop();
}

