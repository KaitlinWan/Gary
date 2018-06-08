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
  public boolean isEmpty() { return _heap.isEmpty(); } //O(1)


  /*****************************************************
   * Integer peekMin()
   * Returns min value in heap
   * Postcondition: Heap remains unchanged.
   *****************************************************/
  public Integer peekMin()
  {
  if ( _heap.size() < 1 )
      return null;
  else
      return _heap.get(0);
    } //O(1)

//adds tweets to heap based on retweets
  public void minaddRT( Status addVal )
  {
    int rt = addVal.getRetweetCount();

  //Add value as last node, to maintain balance, completeness of tree
  _heap.addRT(addVal);

  int addValPos = _heap.size() - 1;
  int parentPos;

  while( addValPos > 0 ) { //potentially swap until reach root

      //pinpoint parent
      parentPos = (addValPos-1) / 2;

      if ( rt.compareTo(_heap.get(parentPos).getRetweetCount()) < 0 ) {//addVal < parent
    swap( addValPos, parentPos );
    addValPos = parentPos;
      }
      else
    break;
  }
    } //O(logn)

    //adds tweets to heap based on retweets
      public void maxaddRT( Status addVal )
      {
        int rt = addVal.getRetweetCount();

      //Add value as last node, to maintain balance, completeness of tree
      _heap.addRT(addVal);

      int addValPos = _heap.size() - 1;
      int parentPos;

      while( addValPos > 0 ) { //potentially swap until reach root

          //pinpoint parent
          parentPos = (addValPos-1) / 2;

          if ( rt.compareTo(_heap.get(parentPos).getRetweetCount()) > 0 ) {//addVal < parent
        swap( addValPos, parentPos );
        addValPos = parentPos;
          }
          else
        break;
      }
        } //O(logn)


}
