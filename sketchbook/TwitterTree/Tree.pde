import twitter4j.conf.*; 
import twitter4j.api.*; 
import twitter4j.*; 
import java.util.*;
import java.util.ArrayList;

class Tree {
  TreeNode _root;
  ArrayList<Status> order = new ArrayList<Status>();
  ArrayList<TreeNode> nodes = new ArrayList<TreeNode>();
  int row;
  int column;
  int origCol;
  int origRow;
  int frameCount = 0;
  int limit = 10;
  int numPrinted = 0;
  int sort;

  Tree() {
    _root = null;
    //initializes a new tree with null root
  }

  public void insert(Status newVal, int sortM) {
    TreeNode newRoot = new TreeNode(newVal, width / 2, 60);
    nodes.add(newRoot);
    sort = sortM;
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
    } else if (sortM == 2) {
      insertF(_root, newRoot, 2);
    } else if (sortM == 3) {
      //insertL(_root, newNode);
    }
  }

  public void insertRT( TreeNode stRoot, TreeNode newNode, int col )
  {
    int distx = abs(stRoot.y - origCol);
    if ( newNode.getRT() < stRoot.getRT() ) {
      //if no left child, make newNode the left child
      if ( stRoot.getLeft() == null ) {
        newNode.x = stRoot.x - (distx / 2);
        newNode.y = stRoot.y + 100;
        newNode.parentX = stRoot.x;
        newNode.parentY = stRoot.y;
        stRoot.setLeft( newNode );
      } else //recurse down left subtree
      insertRT( stRoot.getLeft(), newNode, col + 1 );
      return;
    } else { // new val >= curr, so look down right subtree
      //if no right child, make newNode the right child
      if ( stRoot.getRight() == null ) {
        newNode.x = stRoot.x + (distx / col);
        newNode.y = stRoot.y + 100;
        newNode.parentX = stRoot.x;
        newNode.parentY = stRoot.y;
        stRoot.setRight( newNode );
      } else //recurse down right subtree
      insertRT( stRoot.getRight(), newNode, col + 1 );
      return;
    }
  }//end insert()

  public void insertF( TreeNode stRoot, TreeNode newNode, int col )
  {
    int rootFollowers = stRoot.getStatus().getUser().getFollowersCount();
    int newFollowers = newNode.getStatus().getUser().getFollowersCount();
    int distx = abs(stRoot.y - origCol);
    if ( rootFollowers > newFollowers) {
      //if no left child, make newNode the left child
      if ( stRoot.getLeft() == null ) {
        newNode.x = stRoot.x - (distx / 2);
        newNode.y = stRoot.y + 100;
        newNode.parentX = stRoot.x;
        newNode.parentY = stRoot.y;
        stRoot.setLeft( newNode );
      } else //recurse down left subtree
      insertF( stRoot.getLeft(), newNode, col + 1 );
      return;
    } else { // new val >= curr, so look down right subtree
      //if no right child, make newNode the right child
      if ( stRoot.getRight() == null ) {

        newNode.x = stRoot.x + (distx / 2);
        newNode.y = stRoot.y + 100;
        newNode.parentX = stRoot.x;
        newNode.parentY = stRoot.y;
        stRoot.setRight( newNode );
      } else //recurse down right subtree
      insertF( stRoot.getRight(), newNode, col + 1 );
      return;
    }
  }//end insert()

  public void insertFav( TreeNode stRoot, TreeNode newNode, int col )
  {
    int rootFav = stRoot.getStatus().getFavoriteCount();
    int newFav = newNode.getStatus().getFavoriteCount();
    int distx = abs(stRoot.y - origCol);
    if ( rootFav > newFav) {
      //if no left child, make newNode the left child
      if ( stRoot.getLeft() == null ) {
        newNode.x = stRoot.x - (distx / 2);
        newNode.y = stRoot.y + 100;
        newNode.parentX = stRoot.x;
        newNode.parentY = stRoot.y;
        stRoot.setLeft( newNode );
      } else //recurse down left subtree
      insertFav( stRoot.getLeft(), newNode, col + 1 );
      return;
    } else { // new val >= curr, so look down right subtree
      //if no right child, make newNode the right child
      if ( stRoot.getRight() == null ) {

        newNode.x = stRoot.x + (distx / 2);
        newNode.y = stRoot.y + 100;
        newNode.parentX = stRoot.x;
        newNode.parentY = stRoot.y;
        stRoot.setRight( newNode );
      } else //recurse down right subtree
      insertFav( stRoot.getRight(), newNode, col + 1 );
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

    order.add(0, currNode.getStatus());
    traverse( currNode.getRight() );
    traverse( currNode.getLeft() );
  }

  public ArrayList getOrder() {
    return order;
  }


  void update() {
    numPrinted = 0;
    createTree(_root);
    for (TreeNode t : nodes) {
      fill(255);
      noStroke();
      if (mouseX >= t.getX() && mouseX <= (t.getX() + 40) && mouseY >= t.getY() && mouseY <= t.getY() + 40) {
        rect(10, height-200, 400, 200);
        String details = "";
        details += "User: " + t.getStatus().getUser().getName();
        details += "\n" + t.getStatus().getText();
        details += "\n" + "retweets: " + t.getStatus().getRetweetCount();
        details += "\n" + "followers: " + t.getStatus().getUser().getFollowersCount();
        details += "\n" + "favorites: " + t.getStatus().getFavoriteCount();
        fill(67, 23, 90);
        textSize(12);
        text(details, 17, height-180, 380, 180);
      }
    }
  }

    void createTree(TreeNode currNode) {
      fill(255);
      if ( currNode == null) {//stepped beyond leaf
        return;
      }
      if (currNode.y > 496)
        numPrinted = 6;
      else
        numPrinted = 0;

      if (numPrinted > 5) 
        return;

      if (currNode.getLeft() != null && currNode.y != 496) {
        stroke(255);
        line(currNode.x, currNode.y, currNode.left.x, currNode.left.y);
      }
      if (currNode.getRight() != null && currNode.y != 496) {
        stroke(255);
        line(currNode.x, currNode.y, currNode.right.x, currNode.right.y);
      }
      System.out.println(currNode.y);
      noStroke();
      ellipse(currNode.x, currNode.y, 40, 40);
      fill(0);
      textSize(15);
      String txt = "";
      if (sort == 1) {
        txt = str(currNode.getStatus().getRetweetCount());
      } else if (sort == 2) {
        txt = str(currNode.getStatus().getUser().getFollowersCount());
      }
      text(txt, currNode.x - 15, currNode.y + 5);
      createTree(currNode.getLeft());
      createTree(currNode.getRight());
    }
  }
