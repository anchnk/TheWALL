class DatabaseNoThread {
  
  /********************************************************************************************************************
   *                                                    FIELDS                                                        *
   ********************************************************************************************************************/
  PApplet parent;  // Reference de l'objet representant le programme principal a passer en paramétre du constructeur sql
  MySQL msql;      // Objet SQL gérant la connexion a la base de donnée

  // Paramétres de connexion a la base de données
  String server;   
  String database;
  String user;
  String pass;

  boolean isConnected;
  final boolean Reussie = true;

  /********************************************************************************************************************
   *                                                 CONSTRUCTORS                                                     *
   ********************************************************************************************************************/
  DatabaseNoThread(PApplet p) {
    parent = p;
    server = "server";
    database = "database";
    user = "user";
    pass = "pass";
    isConnected = false;
  }


  void connect() {
    //super.start();
    msql = new MySQL(parent, server, database, user, pass);
    if (msql.connect()) {
      isConnected = true;
      println("Connexion a la base " +database+ "sur le serveur " +server+ " réussie");
    } 
    else {
      isConnected = false;
    }
  }
}
