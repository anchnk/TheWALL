import de.bezier.data.sql.*;


// created 2005-05-10 by fjenett
// updated fjenett 20081129


MySQL posts, postmeta;
int increment = 0;
final int MAX_DISPLAY = 10;

void setup()
{
    size( 100, 100 );
	
    // this example assumes that you are running the 
    // mysql server locally (on "localhost").
    //
	
    // replace --username--, --password-- with your mysql-account.
    //
    String user     = "username";
    String pass     = "password";
	
    // name of the database to use
    //
    String database = "database";
    // add additional parameters like this:
    // bildwelt?useUnicode=true&characterEncoding=UTF-8
	
    // 2 connections à la meme BDD pour 

    posts = new MySQL( this, "88.191.17.115", database, user, pass );
    postmeta = new MySQL( this, "88.191.17.115", database, user, pass );
    
    if ( posts.connect() && postmeta.connect() )
    {
        //msql.query( "SELECT ID FROM `wp_posts` WHERE post_type=`projet`" );
        posts.query( "SELECT * FROM `wp_posts` WHERE post_type='projet'" );
        
        while (posts.next() && increment<MAX_DISPLAY) {
          int id = posts.getInt(1);
          println("projet numéro : " + id);
          println("titre : " + posts.getString("post_title"));
          
          postmeta.query( "SELECT * FROM `wp_postmeta` WHERE post_id=" + id);
          while (postmeta.next()) {
            if(postmeta.getString("meta_key").equals("domaine_du_projet")) {
              println("domaine : " + postmeta.getString("meta_value"));
            }
            else if(postmeta.getString("meta_key").equals("etab_dep")) {
              println("département : " + postmeta.getString("meta_value"));
              break;
            }
          }
          
          println("description : ");
          println(posts.getString("post_content"));
          increment++;
          //println("");
        }
    }
    else
    {
        println("failed !");
        // connection failed !
    }
}

void draw()
{
    // i know this is not really a visual sketch ...
}
