class TheWallOSC {
  
  // TODO : gerer ici les cas de manipulations foireuses des utilisateurs incompetents
  // par exemple : poser / enlever vite plein de fiducials différents
  
  boolean kinect_receive;
  boolean rt_receive;
  
  float kinect_x = 0;
  float kinect_y = 0;
  boolean kinect_clicked = false;
  int rt1_pattern = -1;
  int rt2_pattern = -1;
  
  OscP5 kinect_in, reacTable1_in, reacTable2_in, pureData_in;
  NetAddress kinect_out, reacTable1_out, reacTable2_out, pureData_out;
  
  TheWallOSC() {
    
    kinect_receive = false;
    rt_receive = true;
    
    pureData_in = new OscP5(this, PD_IN_PORT);
    kinect_in = new OscP5(this, KINECT_IN_PORT);
    reacTable1_in = new OscP5(this, RT1_IN_PORT);
    reacTable2_in = new OscP5(this, RT2_IN_PORT);
    
    pureData_out = new NetAddress(PD_ADDRESS, PD_OUT_PORT);
    kinect_out = new NetAddress(KINECT_ADDRESS, KINECT_OUT_PORT);
    reacTable1_out = new NetAddress(RT1_ADDRESS, RT1_OUT_PORT);
    reacTable2_out = new NetAddress(RT2_ADDRESS, RT2_OUT_PORT);
  }
  
  public void oscEvent(OscMessage oscMsg) {
    
    switch(oscMsg.port()) {
      
      case KINECT_IN_PORT:
      
        if(kinect_receive) {
          
          if(oscMsg.addrPattern().equals("/xy")) {
            kinect_x = (Float)(oscMsg.arguments()[0]);
            kinect_y = (Float)(oscMsg.arguments()[1]);
          }
          else {
            kinect_clicked = true;
          }
        }
        break;
        
      case RT1_IN_PORT:
        break;
      
      case RT2_IN_PORT:
        break;
      
      default:
        break;
    }
  }
  
  public void sendToPureData(Particle[] particules) {
    /*
    TROP LOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOONG !
    OscMessage msgX = new OscMessage("/particulesX");
    OscMessage msgY = new OscMessage("/particulesY");    
    for(int i=0; i<particules.length; i++) {
      msgX.add(particules[i].x);
      msgX.add(particules[i].y);
    }
    pureData.send(msgX, pureData_out);
    pureData.send(msgY, pureData_out);
    */
  }
  
  public void sendToKinect(int light) {
    
  }
  
  public void sendToRT1(int light) {
    
  }
  
  public void sendToRT2(int light) {
    
  }
  
}
