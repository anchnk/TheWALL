import de.bezier.data.sql.*;

class DatabaseLoader 
{

  PApplet parent;
  BufferedReader reader;

  MySQL mysql;
  String server;   
  String database;
  String user;
  String pass;
  String query;
  boolean isConnected;

  int numberOfProjects;

  /**
   * Constructeur sans fichier de config. Dans ce cas il est utile d'appeler la méthode readConfigFile par la suite
   ----------------------------------------------------------------------------------------------------------------------------------------
   * @params p
   *               Reference à l'objet PApplet afin de le passer en paramétre au constructure de l'objet MySQL
   */
  DatabaseLoader(PApplet p) 
  {
    parent = p;
  }

  /**
   * Constructeur en utilisant un fichier de config.
   ----------------------------------------------------------------------------------------------------------------------------------------
   * @params p
   *               Reference à l'objet PApplet afin de le passer en paramétre au constructure de l'objet MySQL
   * @params file
   *               Nom du fichier de configuration a charger depuis le répertoire data inhérent au sketch
   */
  DatabaseLoader(PApplet p, String file) 
  {
    parent = p;
    isConnected = false;
    readConfigFile(file);
    mysql = new MySQL(parent, server, database, user, pass);
  }

  /** 
   * Methode qui permet de lire les informations de connexion a la bdd dans un fichier de config de la forme
   ----------------------------------------------------------------------------------------------------------------------------------------
   * serveur:ip_du_serveur
   * database:nom_de_la_bdd
   * user:nom_d_utilisateur
   * pass:mot_de_passe_de_l_utilisateur
   *
   * @params file
   *               nom du fichier a charger dans le répertoire data
   */
  void readConfigFile(String file) 
  {
    String ligne;
    reader = createReader(file);
    /**
     * On essaye de lire une nouvelle ligne. Si une nouvelle ligne est disponible, on rempli chaque paramétre
     * de connexion de la bdd au propriétes de la classe correspondant. Ainsi les paramétres de connexion a la 
     * bdd sont stockés en externe.
     */
    try {
      while((ligne = reader.readLine()) !=null) {
        String[] params = split(ligne, (':'));
        if(params[0].equals("serveur"))server=params[1];
        if(params[0].equals("database"))database=params[1];
        if(params[0].equals("user"))user=params[1];
        if(params[0].equals("pass"))pass=params[1];
      }
    }
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  /**
   * Méthode gérant la connexion a la base de données. Pour le moment informe les informations de connexion dans la zone terminale
   * Prévoir de faire apparaître ces informations dans l'application lors de l'initialisation de celle-ci.
   ----------------------------------------------------------------------------------------------------------------------------------------
   * @return 
   *         boolean : true si la connexion s'établie, false dans le cas contraire
   */
  boolean connect() 
  {
    if(mysql.connect()) {
      isConnected = true;
      println("Connexion a la base de donnée réussie");
      println("-----------------------------------");
      println("Serveur: " + server);
      println("Nom de la Base: " + database);
      println("Utilisateur: " +user);
      println("-----------------------------------");
      return isConnected;
    } 
    else {
      isConnected = false;
      println("Connexion a la base de donnée échouée");
      println("-----------------------------------");
      println("Serveur: " + server);
      println("Nom de la Base: " + database);
      println("Utilisateur: " +user);
      println("-----------------------------------");
    }
    return isConnected;
  }

  /**
   * Accesseurs permettant de modifier la propriétés numberOfProjects qui correspond au nombre de projet ayant une id unique
   ----------------------------------------------------------------------------------------------------------------------------------------
   * @params n 
   *           valeur entiére qui sera affectée au nombre de projets
   */
  void setNumberOfProjects(int n) 
  {
    numberOfProjects = n;
  }

  /**
   * Accesseurs permettant de récupérer la propriétés numberOfProjects
   * Pour récupérer l'information de la base de données, il est nécessaire d'appeler queryNumberOfProjets() auparavant
   ----------------------------------------------------------------------------------------------------------------------------------------
   * @return  
   *           entier : correspond au nombre de projet
   */
  int getNumberOfProjects() 
  {
    return numberOfProjects;
  }

  /**
   * Requête permettant de compter le nombre de projet ayant une id unique dans la base de données.
   * A utiliser pour connaître par la suite le nombre de particules
   ----------------------------------------------------------------------------------------------------------------------------------------
   */
  void queryNumberOfProjects() 
  {
    if(isConnected) {
      query = "SELECT COUNT(DISTINCT ID) FROM `wp_posts`";
      mysql.query(query);
      if(mysql.next()) 
      {
        setNumberOfProjects(mysql.getInt(1));
      }
    }
  }

  void close() 
  {
    mysql.close();
  }

  /**
   * Renvoi le département associé a l'id passée en paramétre
   * Cette fonction peut être appelé lors de la création d'une particule pour lui rattacher le département correspondant a son id
   ----------------------------------------------------------------------------------------------------------------------------------------
   * @params id 
   *           id de la particule correspondant au post_id de la base de données et correspondant a un projet unique
   */
  int queryProjectDep(int id) 
  {
    if(isConnected) {
      query = "SELECT meta_value FROM `wp_postmeta` WHERE meta_key='etab_dep' && post_id=" + id;
      mysql.query(query);
      if(mysql.next()) {
        return mysql.getInt("meta_value");
      }
      else {
        return -1;  // renvoi  -1 si la valeur n'est pas renseignée dans la base de donnée
      }
    }
    else {
      return -2; // renvoi -2 si la connexion a la base de donnée est perdue
    }
  }

  /**
   * Renvoi le département associé a l'id passée en paramétre
   * Cette fonction peut être appelé lors de la création d'une particule pour lui rattacher le département correspondant a son id
   ----------------------------------------------------------------------------------------------------------------------------------------
   * @params id 
   *           id de la particule correspondant au post_id de la base de données et correspondant a un projet unique
   */
  int getDept(int id) {
    return queryProjectDep(id);
  }


  String queryProjectDis(int id) 
  {
    if(isConnected) {
      query = "SELECT meta_value FROM `wp_postmeta` WHERE meta_key='domaine_du_projet' && post_id=" + id;
      mysql.query(query);
      if(mysql.next()) {
        return mysql.getString("meta_value");
      }
      else {
        return "Discipline Not Found !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!";  // renvoi  -1 si la valeur n'est pas renseignée dans la base de donnée
      }
    }
    else {
      return "-2"; // renvoi -2 si la connexion a la base de donnée est perdue
    }
  }

  String getDis(int id) {
    return queryProjectDis(id);
  }
}

