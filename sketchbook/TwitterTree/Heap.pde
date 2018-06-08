
import twitter4j.conf.*;
import twitter4j.api.*;
import twitter4j.*;
import java.util.*;
import java.util.ArrayList;

public class Heap {
  private ArrayList<TreeNode> _heap;
  Tree heapTree = new Tree();
  int sortM = 0;
  
  Heap() {
    _heap = new ArrayList<TreeNode>();
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
      return _heap.get(0)._cargo;
  } //O(1)


  public void insert(Status s, int toSort, int struct) {
    sortM = toSort;
    TreeNode status = new TreeNode(s, 0, 0);
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

  public void addRT(TreeNode val, int type) {
    if (type == 2) {
      maxAddRT(val);
    } else if (type == 3) {
      minAddRT(val);
    }
  }

  //adds tweets to heap based on retweets
  public void minAddRT(TreeNode addVal)
  {
    int rt = addVal._cargo.getRetweetCount();

    //Add value as last node, to maintain balance, completeness of tree
    _heap.add(addVal);

    int addValPos = _heap.size() - 1;
    int parentPos;

    while ( addValPos > 0 ) { //potentially swap until reach root

      //pinpoint parent
      parentPos = (addValPos-1) / 2;

      if ( rt < _heap.get(parentPos)._cargo.getRetweetCount()) {//addVal < parent
        swap(addValPos, parentPos);
        addValPos = parentPos;
      } else
        break;
    }
  } //O(logn)

  //adds tweets to heap based on retweets
  public void maxAddRT( TreeNode addVal )
  {
    int rt = addVal._cargo.getRetweetCount();

    //Add value as last node, to maintain balance, completeness of tree
    _heap.add(addVal);

    int addValPos = _heap.size() - 1;
    int parentPos;

    while ( addValPos > 0 ) { //potentially swap until reach root

      //pinpoint parent
      parentPos = (addValPos-1) / 2;

      if ( rt > _heap.get(parentPos)._cargo.getRetweetCount()) {//addVal < parent
        swap( addValPos, parentPos );
        addValPos = parentPos;
      } else
        break;
    }
  } //O(logn)

  /************************************
   FOLLOWERS SORTING
   *************************************/

  public void addFol(TreeNode val, int type) {
    if (type == 2) {
      maxAddFol(val);
    } else if (type == 3) {
      minAddFol(val);
    }
  }

  public void maxAddFol( TreeNode addVal )
  {
    int followers = addVal._cargo.getUser().getFollowersCount();

    //Add value as last node, to maintain balance, completeness of tree
    _heap.add(addVal);

    int addValPos = _heap.size() - 1;
    int parentPos;

    while ( addValPos > 0 ) { //potentially swap until reach root

      //pinpoint parent
      parentPos = (addValPos-1) / 2;

      if ( followers > _heap.get(parentPos)._cargo.getUser().getFollowersCount()) {//addVal < parent
        swap( addValPos, parentPos );
        addValPos = parentPos;
      } else
        break;
    }
  } //O(logn)

  public void minAddFol( TreeNode addVal )
  {
    int followers = addVal._cargo.getUser().getFollowersCount();

    //Add value as last node, to maintain balance, completeness of tree
    _heap.add(addVal);

    int addValPos = _heap.size() - 1;
    int parentPos;

    while ( addValPos > 0 ) { //potentially swap until reach root

      //pinpoint parent
      parentPos = (addValPos-1) / 2;

      if ( followers < _heap.get(parentPos)._cargo.getUser().getFollowersCount()) {//addVal < parent
        swap( addValPos, parentPos );
        addValPos = parentPos;
      } else
        break;
    }
  } //O(logn)

  /*******************************************
   FAVORITES SORTING
   ********************************************/

  public void addFav(TreeNode val, int type) {
    if (type == 2) {
      maxAddFav(val);
    } else if (type == 3) {
      minAddFav(val);
    }
  }

  public void maxAddFav( TreeNode addVal )
  {
    int favorites = addVal._cargo.getFavoriteCount();

    //Add value as last node, to maintain balance, completeness of tree
    _heap.add(addVal);

    int addValPos = _heap.size() - 1;
    int parentPos;

    while ( addValPos > 0 ) { //potentially swap until reach root

      //pinpoint parent
      parentPos = (addValPos-1) / 2;

      if ( favorites > _heap.get(parentPos)._cargo.getFavoriteCount()) {//addVal < parent
        swap( addValPos, parentPos );
        addValPos = parentPos;
      } else
        break;
    }
  } //O(logn)
  public void minAddFav( TreeNode addVal )
  {
    int favorites = addVal._cargo.getFavoriteCount();

    //Add value as last node, to maintain balance, completeness of tree
    _heap.add(addVal);

    int addValPos = _heap.size() - 1;
    int parentPos;

    while ( addValPos > 0 ) { //potentially swap until reach root

      //pinpoint parent
      parentPos = (addValPos-1) / 2;

      if ( favorites < _heap.get(parentPos)._cargo.getFavoriteCount()) {//addVal < parent
        swap( addValPos, parentPos );
        addValPos = parentPos;
      } else
        break;
    }
  } //O(logn)
  
    private void swap( int pos1, int pos2 )
  {
    
    Status lowerSwap = _heap.get(pos1)._cargo;
    Status upperSwap = _heap.get(pos2)._cargo;
    
    _heap.get(pos1).setValue(upperSwap);
    _heap.get(pos2).setValue(lowerSwap);

  }
  
  void update() {
    //numPrinted = 0;
    heapTree = new Tree();
    for (int i = 0; i < _heap.size(); i ++) {
      heapTree.insert(_heap.get(i)._cargo, sortM);
    }
    heapTree.update();
  }
   
}
