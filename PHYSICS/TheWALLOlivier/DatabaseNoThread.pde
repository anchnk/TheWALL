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
  String query;
  boolean isConnected;


  /********************************************************************************************************************
   *                                                 CONSTRUCTORS                                                     *
   ********************************************************************************************************************/
  DatabaseNoThread(PApplet p) 
  {
    parent = p;
    server = "88.191.17.115";
    database = "web88db1";
    user = "web88u1";
    pass = "zlw1ar66icd";
    isConnected = false;
  }

  /********************************************************************************************************************
   *                                                   METHODS                                                        *
   ********************************************************************************************************************/
  void connect() 
  {
    msql = new MySQL(parent, server, database, user, pass);
    if (msql.connect()) {
      isConnected = true;
      println("Connexion a la base " +database+ "sur le serveur " +server+ " réussie");
    } 
    else {
      isConnected = false;
    }
  }

  int returnDept(int id) 
  {
    query = "SELECT meta_value from `wp_postmeta` WHERE meta_key='etab_dep' && post_id="+id;
    msql.query(query);
    if (msql.next()) {
      return msql.getInt("meta_value");
    } 
    else {
      return -1;
    }
  }

  boolean isConnected() {
    return isConnected;
  }
}

