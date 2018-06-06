import twitter4j.conf.*; 
import twitter4j.api.*; 
import twitter4j.*; 
import java.util.*; 

ArrayList<Button> buttons = new ArrayList<Button>();

PFont font;
boolean askQ = true;
boolean show = false;
boolean canSearch = true;
String words = "";
char letter;

/*The following is a variable that indicates the sort method:
* 1 = quicksort
* 2 = mergesort
* 3 = insertion sort
*/
int sort = 0;

/*The following is a variable that indicates the data structure type:
* 1 = minHeap
* 2 = maxHeap
* 3 = binary tree
*/
int struct;

ArrayList<Status> currList = new ArrayList<Status>();
int index = 0;
int xDist = width - 20;
String tweetText;

Tree tweets;
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
  tweets = new Tree();
  
  size(displayWidth, displayHeight);
  background(color(18, 22, 33));

  font = createFont("Arial",22);
  textFont(font);

  /* Initialize buttons which enable user interaction */
  Button searchAgain = new Button(width - 360, height - 90, 200, 50, "Search Again");
  buttons.add(searchAgain);
  Button sort = new Button(width - 360, height - 160, 200, 50, "Sort");
  buttons.add(sort);
  Button insertionSort = new Button(width - 480, height - 370, 200, 50, "Insertion Sort");
  Button mergeSort = new Button(width - 480, height - 300, 200, 50, "Merge Sort");
  Button quickSort = new Button(width - 480, height - 230, 200, 50, "Quick Sort");
  Button minHeap = new Button(width - 240, height - 230, 200, 50, "Min Heap");
  Button maxHeap = new Button(width - 240, height - 300, 200, 50, "Max Heap");
  Button binaryTree = new Button(width - 240, height - 370, 200, 50, "Binary Tree");
  buttons.add(insertionSort);
  buttons.add(mergeSort);
  buttons.add(quickSort);
  buttons.add(minHeap);
  buttons.add(maxHeap);
  buttons.add(binaryTree);

  

}

void draw() {
  prompt("hello, please enter your search query below");
  //background(255);
  if (!askQ) {
    background(color(18, 22, 33));
    textSize(25);
    fill(255);
    text("Welcome to a tree!",50,70);
    if (sort > 0 || struct > 0) {
      String type = "Type of sort: ";
      if (sort == 1)
        type += "Insertion Sort";
      else if (sort == 2)
        type += "Merge Sort";
      else if (sort == 3)
        type += "Quick Sort";
      type += "\n" + "Type of structure: ";
      if (struct == 1)
        type += "Binary Tree";
      else if (struct == 2)
        type += "Max Heap";
      else if (struct == 3)
        type += "Min Heap";
      text(type, 25, height - 500);
    }
    if (show) {
      prompt("this is show");
    }
    
    for (Button b : buttons) {
      b.update();
      
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
  //else {
   // Status in
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
    }
    else if((key == BACKSPACE) && words.length() > 0){
      words = words.substring(0, words.length()-1);
    }
    else if(key == ENTER) {
      q = words;
      askQ = false;
      queryTwitter(q);
      canSearch = false;
    }
  }
}
void mouseClicked() {
}

void update(int x, int y, ArrayList<Button> buttons) {
  for (int i = 0; i < buttons.size(); i ++) {
    
    if (x >= buttons.get(i).xcor && x <= (buttons.get(i).xcor + buttons.get(i).wd) && y >= buttons.get(i).ycor && y <= (buttons.get(i).ycor + buttons.get(i).ht)) {
      buttons.get(i).col = 100;
      if (mousePressed) {
        if (buttons.get(i).text == "Insertion Sort") {
          sort = 3; 
        }
        else if (buttons.get(i).text == "Merge Sort") {
          sort = 2; 
        }
        else if (buttons.get(i).text == "Quick Sort") {
          sort = 1; 
        }
        else if (buttons.get(i).text == "Min Heap") {
          struct = 3; 
        }
        else if (buttons.get(i).text == "Max Heap") {
          struct = 2; 
        }
        else if (buttons.get(i).text == "Binary Tree") {
          struct = 1; 
        }
        else if (buttons.get(i).text == "Search Again") {
          askQ = true;
          canSearch = true;
          words = "";
          currList = new ArrayList<Status>(0);
          index = 0;
        }
      }
    }
    else
      buttons.get(i).col = 175;
  }
}

void queryTwitter(String search) { 
  System.out.println(search);
  query = new Query(search);
  query.setCount(100);
  try {     
    QueryResult result = twitter.search(query);     
    List<Status> tweets = result.getTweets();     
    for (Status tw : tweets) {  
      currList.add(tw);
    }
    canSearch = false;
  }   
  catch (TwitterException te) {     
    println("Couldn''t connect: " + te);
    
  }
}

void prompt(String q) {
  background(color(18, 22, 33)); // Set background to black
  
  textSize(14);
  text(q, 50, 50);
  //text("#", 50, 70);
  //text("The String is " + words.length() +  " characters long", 50, 90);
  
  textSize(36);
  text(words, 50, 60, 500, 300);
  
  if (!askQ) {
    
  }
}
