import twitter4j.conf.*; 
import twitter4j.api.*; 
import twitter4j.*; 
/*****************************************************
 * class Tree_cargo
 * Implements a node for use in a binary tree.
 * holds Status cargo.
 *****************************************************/

public class TreeNode
{

  //instance variables / attributes of a TreeNode:
  Status _cargo;        //this node's data
  TreeNode left, right, parent; //poStatusers to left, right subtrees
  int rt; //stores retweets
  int followers; //stores followers of tweeter  
  int x,y, parentX, parentY; //stores coordinates
  String text;


  /*****************************************************
   * default constructor
   * Construct a tree node with specified value, 
   * with null left and right subtrees.
   *****************************************************/
  TreeNode( Status initValue, int xCor, int yCor )
  {
    _cargo = initValue;
    followers = _cargo.getUser().getFollowersCount();
    x = xCor;
    y = yCor;
  }
          

  /*****************************************************
   * overloaded constructor
   * Construct tree node w specified value, left, and right subtrees.
   *****************************************************/
  /*TreeNode( Status initValue, TreeNode initLeft, TreeNode initRight ) 
  {
    this(initValue);
    left = initLeft;
    right = initRight;
  }
 

  /*****************************************************
   * Returns the left subtree of this node.
   *****************************************************/
  TreeNode getLeft() 
  {
    return left;
  }
  
  int getLFollowers() {
    return left.getStatus().getUser().getFollowersCount();
  }
  
   int getRFollowers() {
    return left.getStatus().getUser().getFollowersCount();
  }


  /*****************************************************
   * Returns the right subtree of this node.
   *****************************************************/
  TreeNode getRight() 
  {
    return right;
  }

  TreeNode getParent() {
    return parent;
  }
  /*****************************************************
   * Returns the value stored in this tree node.
   *****************************************************/
  Status getStatus() 
  {
    return _cargo;
  }
  
  /*****************************************************
   * Returns the number of followers of the Status 
   stored in this tree node.
   *****************************************************/
  int getRT()
  {
    return _cargo.getRetweetCount();
  }
  

  /*****************************************************
   * Sets the value of the left subtree of this node.
   *****************************************************/
  void setLeft( TreeNode theNewLeft ) 
  {
    left = theNewLeft;
  }


  /*****************************************************
   * Sets the value of the right subtree of this node.
   *****************************************************/
  void setRight( TreeNode theNewRight ) 
  {
    right = theNewRight;
  }
  
  void setParent( TreeNode newParent ) {
    parent = newParent;
  }
  
  void setX(int xCor) {
    x = xCor;
  }
  void setY(int yCor) {
    y = yCor;
  }
  int getX() {
    return x;
  }
  int getY() {
    return y;
  }
  int getParentX() {
    return getParent().getX();
  }
  int getParentY() {
    return getParent().getY();
  }
  
  /*****************************************************
   * Sets the value of this tree node.
   *****************************************************/
  void setValue( Status theNewValue ) 
  {
    _cargo = theNewValue;
  }
  
  void update() {
    text = str(this.getStatus().getRetweetCount());
    fill(225);
    ellipse(x, y, 40, 40);
    
    fill(78,89,11);
    textSize(15);
    text(text, x, y, 30, 35);
  }
 
}//end class
