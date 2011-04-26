class DBThread extends Thread 
{

  ParticleInfo[] particlesInfos;

  private PApplet parent;
  private DatabaseWrapper dbwrap;

  String threadName;
  boolean running;
  boolean loadingData;
  boolean done;
  int counter;


  /**
   * Constructeur permettant uniquement d'initialiser l'état du thread et d'encapsuler la création de l'obet DatabaseWrapper avec les
   * paramétres de connexion contenu dans file.
   ----------------------------------------------------------------------------------------------------------------------------------------
   * @params p
   *               Reference à l'objet PApplet afin de le passer en paramétre au constructure de l'objet MySQL
   * @params file
   *               Nom du fichier de configuration a charger depuis le répertoire data inhérent au sketch
   */
  DBThread(PApplet p, String file) 
  {
    parent = p;
    dbwrap = new DatabaseWrapper(parent, file);
    threadName = "DBThread";
    running = false;
    loadingData = false;
    done = false;
    counter = 0;
  }


  /**
   * Méthode gérant la connexion a la base de données. Pour le moment affiche les paramétres de connexion dans la zone terminale.
   * Prévoir de faire apparaître ces informations dans l'application lors de l'initialisation de celle-ci.
   ----------------------------------------------------------------------------------------------------------------------------------------
   * @return 
   *         boolean : true si la connexion s'établie, false dans le cas contraire
   */
  boolean connect() 
  {
    return dbwrap.connect();
  }


  /**
   * Méthode gérant la déconnexion a la base de donnée. 
   * Cette méthode doit être appelé dans le main dans la fonction stop() ou bien a chaque fois que la connexion a la base de donnée
   * est nécessaire
   ----------------------------------------------------------------------------------------------------------------------------------------
   */
  void close()
  {
    println("Déconnexion de la base de donnée");
    dbwrap.close();
  }


  /**
   * Méthode surchargée de la classe Thread chargée d'appeler la méthode run afin de lancer l'execution du thread.
   * Emet une requête vers la bdd 
   ----------------------------------------------------------------------------------------------------------------------------------------
   */
  void start() 
  {
    if(dbwrap.isConnected) {
      running = true;
      dbwrap.getNumberOfProjects(true);
      particlesInfos = new ParticleInfo[getNumberOfProjects()];
      super.start();
    } 
    else { 
      running = false;
      println("La méthode connect() doit être appelée auparavant");
    }
  }
  
  

  int getNumberOfProjects() 
  {
    return dbwrap.getNumberOfProjects(false);
  }


  void run()
  {
    while(running) {
      if (counter<getNumberOfProjects()) {
        if(loadingData) {
          particlesInfos[counter] = getProjectInfo(counter+1);
          counter++;
        }
      } 
      else {
        done = true;
        println("Chargement Terminé");
        running = false;
        loadingData = false;
      }
    }
  }


  ParticleInfo getProjectInfo(int id) {
    return new ParticleInfo(id, dbwrap.getDept(id), int(random(17)));
  }


  void loadDatabase() {
    loadingData = true;
  }


  boolean done() 
  {
    return done;
  }


  int getCounter() 
  {
    return counter;
  }

}

