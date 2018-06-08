
import twitter4j.conf.*;
import twitter4j.api.*;
import twitter4j.*;
import java.util.*;
import java.util.ArrayList;

public class Heap {
  private ArrayList<Status> _heap;

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
        _heap.swap(addValPos, parentPos);
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
        _heap.swap( addValPos, parentPos );
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
    _heap.maxAddF(addVal);

    int addValPos = _heap.size() - 1;
    int parentPos;

    while ( addValPos > 0 ) { //potentially swap until reach root

      //pinpoint parent
      parentPos = (addValPos-1) / 2;

      if ( followers.compareTo(_heap.get(parentPos).getUser().getFollowersCount())) > 0 ) {//addVal < parent
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
    _heap.maxAddF(addVal);

    int addValPos = _heap.size() - 1;
    int parentPos;

    while ( addValPos > 0 ) { //potentially swap until reach root

      //pinpoint parent
      parentPos = (addValPos-1) / 2;

      if ( followers.compareTo(_heap.get(parentPos).getUser().getFollowersCount())) < 0 ) {//addVal < parent
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
    _heap.maxAddF(addVal);

    int addValPos = _heap.size() - 1;
    int parentPos;

    while ( addValPos > 0 ) { //potentially swap until reach root

      //pinpoint parent
      parentPos = (addValPos-1) / 2;

      if ( favorites.compareTo(_heap.get(parentPos).getFavoriteCount())) > 0 ) {//addVal < parent
        swap( addValPos, parentPos );
        addValPos = parentPos;
      } else
        break;
    }
  } //O(logn)
  public void maxAddFav( Status addVal )
  {
    int favorites = addVal.getFavoriteCount();

    //Add value as last node, to maintain balance, completeness of tree
    _heap.maxAddF(addVal);

    int addValPos = _heap.size() - 1;
    int parentPos;

    while ( addValPos > 0 ) { //potentially swap until reach root

      //pinpoint parent
      parentPos = (addValPos-1) / 2;

      if ( favorites.compareTo(_heap.get(parentPos).getFavoriteCount())) < 0 ) {//addVal < parent
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
}
