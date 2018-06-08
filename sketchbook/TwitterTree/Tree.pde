import twitter4j.conf.*; 
import twitter4j.api.*; 
import twitter4j.*; 
import java.util.*;
import java.util.ArrayList;

class Tree {
  TreeNode _root;
  ArrayList<Status> order = new ArrayList<Status>();
  int row;
  int column;
  int origCol;
  int origRow;
  int limit = 10;
  int numPrinted = 0;
  
  Tree() {
    _root = null;
    //initializes a new tree with null root
  }
  
  public void insert(Status newVal, int sortM) {
    TreeNode newRoot = new TreeNode(newVal, width / 2, 60);
    if ( _root == null ) {
      _root = newRoot;
      origCol = width / 2;
      origRow = height / 8;
      _root.x = origCol;
      _root.y = origRow;
      return;
    }
    if (sortM == 1) {
      insertRT( _root, newRoot, 2);
    }
    else if(sortM == 2) {
      insertF(_root, newRoot, 2);
    }
    else if(sortM == 3) {
      //insertL(_root, newNode);
    }
  }
  
  public void insertRT( TreeNode stRoot, TreeNode newNode, int col )
  {
    if ( newNode.getRT() < stRoot.getRT() ) {
      //if no left child, make newNode the left child
      if ( stRoot.getLeft() == null ) {
        
        stRoot.setLeft( newNode );
        stRoot.getLeft().setParent(stRoot);
      }
      else //recurse down left subtree
      insertRT( stRoot.getLeft(), newNode, col + 1 );
      return;
    } 
    else { // new val >= curr, so look down right subtree
      //if no right child, make newNode the right child
      if ( stRoot.getRight() == null ) {
        
        stRoot.setRight( newNode );
        stRoot.getRight().setParent(stRoot);
      }
      else //recurse down right subtree
      insertRT( stRoot.getRight(), newNode, col + 1 );
      return;
    }
  }//end insert()
  
 public void insertF( TreeNode stRoot, TreeNode newNode, int col )
  {
    int rootFollowers = stRoot.getStatus().getUser().getFollowersCount();
    int newFollowers = newNode.getStatus().getUser().getFollowersCount();
    if ( rootFollowers > newFollowers) {
      //if no left child, make newNode the left child
      if ( stRoot.getLeft() == null ) {
        
        stRoot.setLeft( newNode );
        stRoot.getLeft().setParent(stRoot);
      }
      else //recurse down left subtree
      insertF( stRoot.getLeft(), newNode, col + 1 );
      return;
    } else { // new val >= curr, so look down right subtree
      //if no right child, make newNode the right child
      if ( stRoot.getRight() == null ) {
        
        stRoot.setRight( newNode );
        stRoot.getRight().setParent(stRoot);
      }
      else //recurse down right subtree
      insertF( stRoot.getRight(), newNode, col + 1 );
      return;
    }
  }//end insert()
  
  public void traverse() {
    traverse(_root);
    //println(order.size());
  }
  
  public void traverse( TreeNode currNode ) {
    if ( currNode == null ) {//stepped beyond leaf
      return;
  }
    //println(currNode.getStatus().getUser().getFollowersCount());
    
      order.add(currNode.getStatus());
      traverse( currNode.getLeft() );
      traverse( currNode.getRight() );


  }
  
  public ArrayList getOrder() {
    return order;
  }
  
  
  public void process() {
    Status retStat = _root.getStatus();
  }
  
  void update() {
    numPrinted = 0;
    createTree(_root); 
  }
   
  void createTree(TreeNode currNode) {
     fill(255);
     if ( currNode == null) {//stepped beyond leaf
      return;
    }
   
    if (currNode.getLeft() != null) {
      stroke(255);
      line(currNode.x, currNode.y, currNode.left.x, currNode.left.y);
    }
    if (currNode.getRight() != null) {
      stroke(255);
      line(currNode.x, currNode.y, currNode.right.x, currNode.right.y);
    }
    noStroke();
    ellipse(currNode.x, currNode.y, 40, 40);
    fill(0);
    textSize(15);
    text(currNode.followers, currNode.x - 15, currNode.y + 5);
    createTree(currNode.getLeft());
    createTree(currNode.getRight());
  }
}
