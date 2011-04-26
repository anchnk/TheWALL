class ParticleInfo {

  private int id;
  private int dep;
  private int dis;

  ParticleInfo() {
  }

  ParticleInfo(int id, int dep, int dis) 
  {
    this.id = id;
    this.dep = dep;
    this.dis = dis;
  }

  void setID(int i) 
  {
    id = i;
  }

  void setDep(int d)
  {
    dep = d;
  }

  void setDis(int s)
  {
    dis = s;
  }

  int getId() 
  {
    return id;
  }

  int getDep() 
  {
    return dep;
  }

  int getDis() 
  {
    return dis;
  }
}

