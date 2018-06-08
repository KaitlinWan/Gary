import twitter4j.conf.*; 
import twitter4j.api.*; 
import twitter4j.*; 
import java.util.*; 

ArrayList<Button> buttons = new ArrayList<Button>();
ArrayList<Button> start = new ArrayList<Button>();

int frameCount = 0;
PFont font;
PImage img;
boolean askQ = true;
boolean show = false;
boolean canSearch = false;
boolean canSearchp = false;
boolean startup = true;
boolean sorted = false;
boolean wannalook = false;
boolean wannado = false;
boolean limit = true;
String words = "";
String pText = "";
char letter;

/*The following is a variable that indicates the sortBy method:
 * 1 = Retweets
 * 2 = followers
 * 3 = Favorites
 */
int sortBy = 0;

/*The following is a variable that indicates the data structure type:
 * 3 = minHeap
 * 2 = maxHeap
 * 1 = binary tree
 */
int struct = 0;

ArrayList<Status> currList = new ArrayList<Status>();
ArrayList<Status> sortedtweetTree = new ArrayList<Status>();
int index = 0;
int dispIndex = 0;
int xDist = width - 20;
String tweetText;


Tree tweetTree;
Heap tweetHeap;
ConfigurationBuilder cb; 
Query query; 
Twitter twitter;


void setup() {    
  cb = new ConfigurationBuilder();      //Acreditacion
  cb.setOAuthConsumerKey("TCorRWYioDzCQdLPpuaWLBBsE");   
  cb.setOAuthConsumerSecret("zu2C8GJmd3dLSk4NXc6G8mYB6ZLFKowc8nclSRT3sY7qfm54ED");   
  cb.setOAuthAccessToken("1000527653252804608-BHvNG8yI7gdKphTAfyGGk79AXEXDVR");   
  cb.setOAuthAccessTokenSecret("SRUatIDTe2Z1c8Syov3jQepZKDGrZq0GjWVspUJS4nFoV");

  twitter = new TwitterFactory(cb.build()).getInstance();
  tweetTree = new Tree();
  tweetHeap = new Heap();

  size(1024, 768);
  background(color(18, 22, 33));

  font = createFont("Arial", 22);
  textFont(font);

  /* Initialize buttons which enable user interaction */
  Button searchAgain = new Button(width - 360, height - 90, 200, 50, "Search Again");
  buttons.add(searchAgain);
  Button sort = new Button(width - 360, height - 160, 200, 50, "Sort");
  buttons.add(sort);
  Button Retweets = new Button(width - 480, height - 370, 200, 50, "Retweets");
  Button followers = new Button(width - 480, height - 300, 200, 50, "Followers");
  //Button favorites = new Button(width - 480, height - 230, 200, 50, "Favorites");
  Button minHeap = new Button(width - 240, height - 230, 200, 50, "Min Heap");
  Button maxHeap = new Button(width - 240, height - 300, 200, 50, "Max Heap");
  Button binaryTree = new Button(width - 240, height - 370, 200, 50, "Binary Tree");
  Button home = new Button(width - 480, height - 230, 200, 50, "Home");
  Button search = new Button(width - 360, height - 160, 200, 50, "search");
  Button post = new Button(width - 360, height - 90, 200, 50, "post");
  buttons.add(Retweets);
  buttons.add(followers);
  //buttons.add(favorites);
  buttons.add(minHeap);
  buttons.add(maxHeap);
  buttons.add(binaryTree);
  buttons.add(home);
  img = loadImage("logo.png");
}

void draw() {
  if (startup) {
    background(255);
    fill(0, 0, 0);
    textSize(60);
    text("Welcome to Tweetalize", 200, 100);
    image(img, 350, 200, img.width/2.5, img.height/2.5);

    Button post = new Button(width - 360, height - 90, 200, 50, "post");
    start.add(post);
    Button search = new Button(width - 360, height - 160, 200, 50, "search");
    start.add(search);

    for (Button b : start) {
      b.update();
    }
    update(mouseX, mouseY, start);
  }

  if (wannado) {
    canSearchp = true;
    background(255);
    fill(0, 0, 0);
    textSize(60);
    tweetthis("What's on your mind?");
    textSize(36);
    text(words, 50, 60, 500, 300);
  } else {
    canSearchp = false;
    canSearch = true;
  }

  if (wannalook) {
    canSearch = true;
    prompt("hello, please enter your search query below");
    //background(255);
    if (!askQ) {
      frameCount++;

      background(color(18, 22, 33));
      textSize(20);
      fill(255);
      text("Welcome to GaryTwitter!", 50, 70);
      if (currList.size() == 0)
        text("Oop! Looks like no results came up for " + words + ". Try again!", 50, 130);
      else
        text("Select what metric you want to organize your query by, and how you want to visualize the data!", 50, 100);

      String info;
      if (sortBy == 0 && struct == 0) {
        info = "Please choose a sort method and a structure in which to display the sort";
        text(info, 25, height - 500);
      } else if (sortBy > 0 || struct > 0) {
        info = "Type of sort: ";
        if (sortBy == 1)
          info += "Retweets";
        else if (sortBy == 2)
          info += "Followers";
        else if (sortBy == 3)
          info += "Favorites";
        info += "\n" + "type of structure: ";
        if (struct == 1)
          info += "Binary Tree";
        else if (struct == 2)
          info += "Max Heap";
        else if (struct == 3)
          info += "Min Heap";
        text(info, 25, height - 500);
      }
      for (Button b : buttons) {
        b.update();
      }

      if (sorted == true) {
        background(color(18, 22, 33));
        buttons.get(0).update();

        if (frameCount >= 20) {
          if (dispIndex < currList.size()) {
            if (struct == 1) //Binary Tree
              tweetTree.insert(currList.get(dispIndex), sortBy);
            else 
            tweetHeap.insert(currList.get(dispIndex), sortBy, struct);
          }            
          //System.out.println(index);

          dispIndex ++;
          frameCount = 0;
        }
        tweetHeap.update();
        tweetTree.update();
      }
      update(mouseX, mouseY, buttons);
      if (currList.size() != 0) {
        noStroke();
        fill(255);
        rect(15, 15, width - 20, 30, 5);
        fill(0);
        textSize(15);
        tweetText = currList.get(index).getText();
        tweetText = tweetText.replace("\n", " ");
        text(tweetText, xDist, 20, width, 30); 

        // Decrement x
        xDist = xDist - 2;

        // If x is less than the negative width, then it is off the screen
        // textWidth() is used to calculate the width of the current String.
        float w = textWidth(tweetText); 
        if (xDist < -w) {
          xDist = width;
          // index is incremented when the current String has left the screen in order to display a new String.
          index = (index + 1) % currList.size();
        }
      }
    }
  } else {
    canSearch = false;
  }
  //else {
}

void keyTyped() {
  // The variable "key" always contains the value 
  // of the most recent key pressed.
  String q = "";
  if (canSearch) {
    if ((key >= 'A' && key <= 'z') || key == ' ') {
      letter = key;
      words = words + key;
      // Write the letter to the console
      //println(key);
    } else if ((key == BACKSPACE) && words.length() > 0) {
      words = words.substring(0, words.length()-1);
    } else if (key == ENTER) {
      q = words;
      askQ = false;
      tweetHeap = new Heap();
      queryTwitter(q);
      canSearch = false;
    }
  }

  if (canSearchp) {
    print(key);
    if (pText.length() < 280) {
      if ((key == BACKSPACE) && pText.length() > 0) {
        pText = pText.substring(0, pText.length()-1);
      } else if (key == ENTER) {
        q = pText;
        canSearchp = false;
        try {
          Status status = twitter.updateStatus(pText);
          System.out.println("Successfully updated the status to [" + status.getText() + "].");
        }
        catch (TwitterException te) {
          te.printStackTrace();
          System.out.println("Failed to get timeline: " + te.getMessage());
          System.exit(-1);
        }
        wannado = false;
        startup = true;
      } else {
        letter = key;
        pText = pText + key;
      }
    } else {
      if ((key == BACKSPACE) && pText.length() > 0) {
        pText = pText.substring(0, pText.length()-1);
      }
    }
  }
}

void mouseClicked() {
  for (int i = 0; i < buttons.size(); i ++) {
    if (mouseX >= buttons.get(i).xcor && mouseX <= (buttons.get(i).xcor + buttons.get(i).wd) && mouseY >= buttons.get(i).ycor && mouseY <= (buttons.get(i).ycor + buttons.get(i).ht)) {
      if (buttons.get(i).text == "Sort") {
        if (sortBy > 0 || struct > 0) {
          index = 0;
          sort();
        }
        /*
          for (Status s: sortedtweetTree) {
         println(s.getUser().getFollowersCount());
         }
         */
      }
    }
  }
}


void update(int x, int y, ArrayList<Button> buttons) {
  for (int i = 0; i < buttons.size(); i ++) {
    if (x >= buttons.get(i).xcor && x <= (buttons.get(i).xcor + buttons.get(i).wd) && y >= buttons.get(i).ycor && y <= (buttons.get(i).ycor + buttons.get(i).ht)) {
      buttons.get(i).col = 100; 
      if (mousePressed) {
        if (buttons.get(i).text == "Retweets") {
          sortBy = 1;
        } else if (buttons.get(i).text == "Followers") {
          sortBy = 2;
        } else if (buttons.get(i).text == "Favorites") {
          sortBy = 3;
        } else if (buttons.get(i).text == "Min Heap") {
          struct = 3;
        } else if (buttons.get(i).text == "Max Heap") {
          struct = 2;
        } else if (buttons.get(i).text == "Binary Tree") {
          struct = 1;
        } else if (buttons.get(i).text == "Search Again") {
          askQ = true;
          canSearch = true;
          sorted = false;
          words = "";
          currList = new ArrayList<Status>(0);
          index = 0;
        } else if (buttons.get(i).text == "search") {
          wannalook = true;
          startup = false;
        } else if (buttons.get(i).text == "post") {
          wannado = true;
          startup = false;
        } else if (buttons.get(i).text == "Home") {
          askQ = true;
          show = false;
          canSearch = false;
          canSearchp = false;
          startup = true;
          sorted = false;
          wannalook = false;
          wannado = false;
          limit = true;
          words = "";
          pText = "";
        }
      }
    } else {
        buttons.get(i).col = 175;
      }
    }
  }

  void queryTwitter(String search) { 
    System.out.println(search);
    query = new Query(search);
    query.setCount(100);
    try {     
      QueryResult result = twitter.search(query);     
      List<Status> listTweets = result.getTweets();  
      //println("New Tweet: ");
      for (Status tw : listTweets) {  
        currList.add(tw);
      }
      canSearch = false;
    }   
    catch (TwitterException te) {     
      println("Couldn''t connect: " + te);
    }
  }

  void sort() {
    sorted = true;
    tweetTree._root = null;
    tweetHeap.heapTree._root = null;
  }


  void prompt(String q) {
    background(color(18, 22, 33)); // Set background to black

    textSize(14);
    text(q, 50, 50);
    //text("#", 50, 70);
    //text("The String is " + words.length() +  " characters long", 50, 90);

    textSize(36);
    text(words, 50, 60, 500, 300);
    //currlist to tree, depending on method selected
  }

  void tweetthis(String a) {
    background(225);
    textSize(60);
    text(a, 200, 100);
    textSize(36);
    text(pText, 100, 150, 800, 500);
  }
