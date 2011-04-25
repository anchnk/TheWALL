import oscP5.*;
import netP5.*;

import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

import controlP5.*;

final int KINECT_PORT = 8000;
final int RT1_IN_PORT = 8001;
final int RT1_OUT_PORT = 8002;
final int RT2_IN_PORT = 8003;
final int RT2_OUT_PORT = 8004;

// les identifiants reacTIVision


// les differents etats de l'automate :
final int DEFAUT = 1;
final int FILTRE = 2;
final int VISU = 3;

int etat_courant = DEFAUT;

OscP5 kinect, reacTable1_in, reacTable2_in; // reception osc
NetAddress pureData, reacTable1_out, reacTable2_out; // envoi osc

void setup() {
  size(2048,768);
  //size(1440,900);
  frameRate(30);
  
  kinect = new OscP5(this, KINECT_PORT);
  reacTable1_in = new OscP5(this, RT1_IN_PORT);
  reacTable2_in = new OscP5(this, RT2_IN_PORT);
}

void draw() {
  
}

void oscEvent(OscMessage oscMsg) {
  
  // APPELER ICI LES FONCTIONS QUI GERENT LES RECEPTIONS DE MESSAGES OSC
  
}

// peut-etre pas obligatoire si on observe mouseX et mouseY dans la boucle draw()
void mouseMoved() {
  
  // SI ON EST EN MODE SELECTION DE PROJET, METTRE EN SURBRILLANCE LES BOULES SURVOLEES
  // METTRE A JOUR UN INDEX DE LA BOULE SURVOLEE AU CAS OU ON CLIQUE
  
}

void mousePressed() {
  
  // SI ON SURVOLE UNE BOULE, LANCER LA VISUALISATION DU PROJET
  
}
