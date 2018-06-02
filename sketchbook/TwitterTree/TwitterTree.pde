import twitter4j.conf.*; 
import twitter4j.api.*; 
import twitter4j.*; 
import java.util.*; 

PFont font;
ConfigurationBuilder cb; 
Query query; 
Twitter twitter;
boolean askQ = true;
boolean show = false;
String words = "";
char letter;

void setup() {    
  cb = new ConfigurationBuilder();      //Acreditacion
  cb.setOAuthConsumerKey("TCorRWYioDzCQdLPpuaWLBBsE");   
  cb.setOAuthConsumerSecret("zu2C8GJmd3dLSk4NXc6G8mYB6ZLFKowc8nclSRT3sY7qfm54ED");   
  cb.setOAuthAccessToken("1000527653252804608-BHvNG8yI7gdKphTAfyGGk79AXEXDVR");   
  cb.setOAuthAccessTokenSecret("SRUatIDTe2Z1c8Syov3jQepZKDGrZq0GjWVspUJS4nFoV");
  
  twitter = new TwitterFactory(cb.build()).getInstance();    
  
  size(600, 600);
  background(255);

  font = createFont("Arial",22);
  textFont(font);

  
}

void draw() {
  prompt("hello, please enter your search query below");
  //background(255);
  if (!askQ) {
    background(0);
    textSize(25);
    text("Welcome to a tree!",50,50);
    if (show) {
      queryTwitter();
    }
  }
}


void keyTyped() {
  // The variable "key" always contains the value 
  // of the most recent key pressed.
  if ((key >= 'A' && key <= 'z') || key == ' ') {
    letter = key;
    words = words + key;
    // Write the letter to the console
    println(key);
  }
  else if((key == BACKSPACE) && words.length() > 0){
    words = words.substring(0, words.length()-1);
  }
  else if(key == ENTER) {
    askQ = false;
  }
}
void mouseClicked() {
  if(!askQ) {
    show = true;
  }
}

void queryTwitter() {   
  query = new Query(words);   
  query.setCount(1);   
  try {     
    QueryResult result = twitter.search(query);     
    Tree tweets = new Tree();
    tweets.insert(result.getTweets().get(0));
    text((result.getTweets().get(0).getText()), 50, 70.0);
  }
  catch (TwitterException te) {     
    println("Couldn''t connect: " + te);
  }
}

void prompt(String q) {
   background(0); // Set background to black
  
  textSize(14);
  text(q, 50, 50);
  //text("#", 50, 70);
  //text("The String is " + words.length() +  " characters long", 50, 90);
  
  textSize(36);
  text("#" + words, 50, 60, 500, 300);
}
