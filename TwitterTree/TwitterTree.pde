import twitter4j.conf.*; 
import twitter4j.api.*; 
import twitter4j.*; 
import java.util.*;  
ConfigurationBuilder   cb; 
Query query; 
Twitter twitter;
void setup() {    
  cb = new ConfigurationBuilder();      //Acreditacion
  cb.setOAuthConsumerKey("TCorRWYioDzCQdLPpuaWLBBsE");   
  cb.setOAuthConsumerSecret("zu2C8GJmd3dLSk4NXc6G8mYB6ZLFKowc8nclSRT3sY7qfm54ED");   
  cb.setOAuthAccessToken("1000527653252804608-BHvNG8yI7gdKphTAfyGGk79AXEXDVR");   
  cb.setOAuthAccessTokenSecret("SRUatIDTe2Z1c8Syov3jQepZKDGrZq0GjWVspUJS4nFoV");
  
  twitter = new TwitterFactory(cb.build()).getInstance();    
  queryTwitter();
  
  size(displayWidth, displayHeight);
  background(255);
}

void draw() {
}
