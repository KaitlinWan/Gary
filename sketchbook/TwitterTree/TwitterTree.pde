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
int sort;

/*The following is a variable that indicates the data structure type:
* 1 = quicksort
* 2 = mergesort
* 3 = insertion sort
*/
int struct;

List<Status> currList = new List<Status>();
int index = currList.size();
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
    text("Welcome to a tree!",50,50);
    if (show) {
      prompt("this is show");
    }
    
    for (Button b : buttons) {
      b.update();
      
    }
    update(mouseX, mouseY, buttons);
    update(currList, index);
    index ++;

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
  if(!askQ) {
    show = !show;
  }
}

void update(int x, int y, ArrayList<Button> buttons) {
  for (int i = 0; i < buttons.size(); i ++) {
    
    if (x >= buttons.get(i).xcor && x <= (buttons.get(i).xcor + buttons.get(i).wd) && y >= buttons.get(i).ycor && y <= (buttons.get(i).ycor + buttons.get(i).ht)) {
      buttons.get(i).col = 100;
      if (mousePressed) {
        if (buttons.get(i).text == "Search Again") {
          askQ = true;
          canSearch = true;
          words = "";
        }
      }
    }
    else
      buttons.get(i).col = 175;
  }
}

void update(List<Status> tweets, int index) {
  stroke(255);
  fill(0);
  rect(width - 480, 5, 440, 300);
  for (int i = 5; i < 300; i += 15) {
    fill(255);
    textSize(10);
    String text = tweets.get(index).getText();
    text(text, width - 460, i, 420, 290);
    index ++;
  }
}

void queryTwitter(String search) { 
  System.out.println(search);
  query = new Query(search);   
  try {     
    QueryResult result = twitter.search(query);     
    List<Status> tweets = result.getTweets();     
    currList = tweets;     
    for (Status tw : tweets) {       
      String msg = tw.getText();       
      println("tweet : " + msg);
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
