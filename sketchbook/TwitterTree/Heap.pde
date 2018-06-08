
import twitter4j.conf.*;
import twitter4j.api.*;
import twitter4j.*;
import java.util.*;
import java.util.ArrayList;

public class Heap {
  private ArrayList<Status> _heap;
  Tree heapTree = new Tree();

  Heap() {
    _heap = new ArrayList<Status>();
  }

  /*****************************************************
   * boolean isEmpty()
   * Returns true if no meaningful elements in heap, false otherwise
   *****************************************************/
  public boolean isEmpty() { 
    return _heap.isEmpty();
  } //O(1)


  /*****************************************************
   * Integer peekMin()
   * Returns min value in heap
   * Postcondition: Heap remains unchanged.
   *****************************************************/
  public Status peekMin()
  {
    if ( _heap.size() < 1 )
      return null;
    else
      return _heap.get(0);
  } //O(1)


  public void insert(Status status, int toSort, int struct) {
    if (toSort == 1)
      addRT(status, struct);
    else if (toSort == 2)
      addFol(status, struct);
    else
      addFav(status, struct);
  }
  /**************
   RETWEET SORTING
   ***************/

  public void addRT(Status val, int type) {
    if (type == 2) {
      maxAddRT(val);
    } else if (type == 3) {
      minAddRT(val);
    }
  }

  //adds tweets to heap based on retweets
  public void minAddRT(Status addVal)
  {
    int rt = addVal.getRetweetCount();

    //Add value as last node, to maintain balance, completeness of tree
    _heap.add(addVal);

    int addValPos = _heap.size() - 1;
    int parentPos;

    while ( addValPos > 0 ) { //potentially swap until reach root

      //pinpoint parent
      parentPos = (addValPos-1) / 2;

      if ( rt < _heap.get(parentPos).getRetweetCount()) {//addVal < parent
        swap(addValPos, parentPos);
        addValPos = parentPos;
      } else
        break;
    }
  } //O(logn)

  //adds tweets to heap based on retweets
  public void maxAddRT( Status addVal )
  {
    int rt = addVal.getRetweetCount();

    //Add value as last node, to maintain balance, completeness of tree
    _heap.add(addVal);

    int addValPos = _heap.size() - 1;
    int parentPos;

    while ( addValPos > 0 ) { //potentially swap until reach root

      //pinpoint parent
      parentPos = (addValPos-1) / 2;

      if ( rt > _heap.get(parentPos).getRetweetCount()) {//addVal < parent
        swap( addValPos, parentPos );
        addValPos = parentPos;
      } else
        break;
    }
  } //O(logn)

  /************************************
   FOLLOWERS SORTING
   *************************************/

  public void addFol(Status val, int type) {
    if (type == 2) {
      maxAddFol(val);
    } else if (type == 3) {
      minAddFol(val);
    }
  }

  public void maxAddFol( Status addVal )
  {
    int followers = addVal.getUser().getFollowersCount();

    //Add value as last node, to maintain balance, completeness of tree
    _heap.add(addVal);

    int addValPos = _heap.size() - 1;
    int parentPos;

    while ( addValPos > 0 ) { //potentially swap until reach root

      //pinpoint parent
      parentPos = (addValPos-1) / 2;

      if ( followers > _heap.get(parentPos).getUser().getFollowersCount()) {//addVal < parent
        swap( addValPos, parentPos );
        addValPos = parentPos;
      } else
        break;
    }
  } //O(logn)

  public void minAddFol( Status addVal )
  {
    int followers = addVal.getUser().getFollowersCount();

    //Add value as last node, to maintain balance, completeness of tree
    _heap.add(addVal);

    int addValPos = _heap.size() - 1;
    int parentPos;

    while ( addValPos > 0 ) { //potentially swap until reach root

      //pinpoint parent
      parentPos = (addValPos-1) / 2;

      if ( followers < _heap.get(parentPos).getUser().getFollowersCount()) {//addVal < parent
        swap( addValPos, parentPos );
        addValPos = parentPos;
      } else
        break;
    }
  } //O(logn)

  /*******************************************
   FAVORITES SORTING
   ********************************************/

  public void addFav(Status val, int type) {
    if (type == 2) {
      maxAddFav(val);
    } else if (type == 3) {
      minAddFav(val);
    }
  }

  public void maxAddFav( Status addVal )
  {
    int favorites = addVal.getFavoriteCount();

    //Add value as last node, to maintain balance, completeness of tree
    _heap.add(addVal);

    int addValPos = _heap.size() - 1;
    int parentPos;

    while ( addValPos > 0 ) { //potentially swap until reach root

      //pinpoint parent
      parentPos = (addValPos-1) / 2;

      if ( favorites > _heap.get(parentPos).getFavoriteCount()) {//addVal < parent
        swap( addValPos, parentPos );
        addValPos = parentPos;
      } else
        break;
    }
  } //O(logn)
  public void minAddFav( Status addVal )
  {
    int favorites = addVal.getFavoriteCount();

    //Add value as last node, to maintain balance, completeness of tree
    _heap.add(addVal);

    int addValPos = _heap.size() - 1;
    int parentPos;

    while ( addValPos > 0 ) { //potentially swap until reach root

      //pinpoint parent
      parentPos = (addValPos-1) / 2;

      if ( favorites < _heap.get(parentPos).getFavoriteCount()) {//addVal < parent
        swap( addValPos, parentPos );
        addValPos = parentPos;
      } else
        break;
    }
  } //O(logn)
  
    private void swap( int pos1, int pos2 )
  {
    _heap.set( pos1, _heap.set( pos2, _heap.get(pos1) ) );
  }
  
  void update() {
    //numPrinted = 0;
    createHeap(0);
  }
 
   
  void createHeap(int index) {
     fill(255);
     int posX;
     int posY;
     int parentX;
     int parentY;
     
     if ( _heap.get(index) == null) {//stepped beyond leaf
      return;
    }
    
    
    if (index == 0) {
       heapTree._root = _heap.get(index);
    }
    else {
      heapTree._root = _heap
    }
    else if (index < 7) {
       posX = (width / 5) * (index / 3);
       posY = 260;
    }
    else
      return;
      
    /*
    if (heap.get(0).getLeft() != null) {
      stroke(255);
      line(currNode.x, currNode.y, currNode.left.x, currNode.left.y);
    }
    if (heap.get(0).getRight() != null) {
      stroke(255);
      line(currNode.x, currNode.y, currNode.right.x, currNode.right.y);
    }
    */
    noStroke();
    ellipse(posX, posY, 40, 40);
    fill(0);
    textSize(15);
    text(_heap.get(index).getUser().getFollowersCount(), posX - 15, posY + 5);
    
    int newIndex = index * 2;
    newIndex += 1;
    if (newIndex < _heap.size())
       createHeap(newIndex);

    newIndex += 1;
    if (newIndex < _heap.size())
      createHeap(newIndex);
  }
}
