class Database extends Thread { 

  /********************************************************************************************************************
   *                                                    FIELDS                                                        *
   ********************************************************************************************************************/
  boolean running;
  int wait;
  String id;
  int count;

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
  Database(PApplet p, int w) {
    wait = w;
    running = false;
    count = 0;
    id = "myThread";

    parent = p;
    server = "88.191.17.115";
    database = "web88db1";
    user = "web88u1";
    pass = "zlw1ar66icd";
    isConnected = false;
    msql = new MySQL(parent, server, database, user, pass);
    if(msql.connect())isConnected = true;
  }


  void start () {
    running = true;
    super.start();
  }

  void run() {
    if(isConnected) {
      msql.query("SELECT * from `wp_posts`");
    }
    while(running) {
      if(msql.next()) {
        count++;
      }
    }
    println(count);
  }
}

