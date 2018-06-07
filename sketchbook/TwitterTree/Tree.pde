import twitter4j.conf.*; 
import twitter4j.api.*; 
import twitter4j.*; 
import java.util.*;
import java.util.ArrayList;

class Tree {
  TreeNode _root;
  ArrayList<Status> order = new ArrayList<Status>();
  
  
  Tree() {
    _root = null;
    //initializes a new tree with null root
  }
  
  public void insert(Status newVal) {
    TreeNode newNode = new TreeNode(newVal);
    if ( _root == null ) {
      _root = newNode;
      return;
    }
    insertRT( _root, newNode );
  }
  
  public void insertRT( TreeNode stRoot, TreeNode newNode )
  {
    if ( newNode.getRT() < stRoot.getRT() ) {
      //if no left child, make newNode the left child
      if ( stRoot.getLeft() == null )
        stRoot.setLeft( newNode );
      else //recurse down left subtree
      insertRT( stRoot.getLeft(), newNode );
      return;
    } else { // new val >= curr, so look down right subtree
      //if no right child, make newNode the right child
      if ( stRoot.getRight() == null )
        stRoot.setRight( newNode );
      else //recurse down right subtree
      insertRT( stRoot.getRight(), newNode );
      return;
    }
  }//end insert()
  
 public void insertFollowers( TreeNode stRoot, TreeNode newNode )
  {
    int userFollowers = stRoot.getStatus().getUser().getFollowersCount();
    int tweeterFollowers = newNode.getStatus().getUser().getFollowersCount();
    if ( tweeterFollowers < userFollowers) {
      //if no left child, make newNode the left child
      if ( stRoot.getLeft() == null )
        stRoot.setLeft( newNode );
      else //recurse down left subtree
      insertRT( stRoot.getLeft(), newNode );
      return;
    } else { // new val >= curr, so look down right subtree
      //if no right child, make newNode the right child
      if ( stRoot.getRight() == null )
        stRoot.setRight(newNode);
      else //recurse down right subtree
      insertRT( stRoot.getRight(), newNode );
      return;
    }
  }//end insert()
  
    public void traverse( TreeNode currNode )
  {
    if ( currNode == null ) //stepped beyond leaf
      return;
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
}
