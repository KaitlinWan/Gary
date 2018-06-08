# Team Gary
Josh Weiner, Eric Wong, Kaitlin Wan

APCS2 Final Project - Tweetalyze

## Description of our Project.
Have you ever wondered how different your life would be without the idea of news feeds and social media? Scrolling through unorganized, cluttered feeds can be a detriment to your life. Therefore, Team Gary has developed a new way to mitigate your aimless scrolling. With our processing based Twitter interface, you can discover a whole new experience. With our minimalistic approach to Twitter, you are capable of searching any topic. After searching, you are presented with a screen to select different ways of visualization. You can choose from sorting by followers, retweets, and favorites. As well as that, you are able to select the type of structure. When viewing, you will be presented with a visualization of either a binary search tree, or a max/min heap, depending on the user selected structure. The user can also choose to tweet something or reply to a tweet.

## How do I work?
We used an unofficial Java library called <a href = "http://twitter4j.org/en/index.html"> twitter4j </a> to access the twitter api and retrieve tweets.
First, the user is presented with a home screen where you can search for a tweet or post a tweet. <br>
If user selects search: <br>
When you search, you retrieve 30 tweets, which are all first placed into an arrayList. The user can then choose a sort method and structure they want:
<ul>
<li>if the user selects binary tree, the data in the arrayList of tweets will be added onto a node-based tree - when we insert each tweet (or Status) into the tree, it will automatically insert it in the right place and create a corresponding node in the visual tree, using recursion. This happens in real-time. </li>
<li> if the user selects min or max heap, the data in the arrayList will be added onto a min or max heap, one at a time in compliance with the heap properties of the heap selected. This is also presented in a tree-like structure.</li>
</ul>
In the Tree class, each node has a an x and y position that determines where to create a new "circle" on the visual tree. For each consecutive node, the position changes depending on if the node belongs on the left or right subtree. We recurse to the right position on the tree and if on left subtree, the x position will decrease and the y position will increase, compared to the previous node. If on the right subtree, the x position will increase, and the y position will also increase accordingly.
<br>
If the user selects post, they can then tweet something from our account:
they can type something and using the twitter api, it'll post! Try it out!



## Launch Instructions
1. Clone our repo
2. Proceed to Gary/sketchbook/TwitterTree/
3. Inside TwitterTree, copy the folder called "twitter4j01" into your local processing libraries folder. (That is all you need to do because we took care of all the hard work specially for you!)
4. Go to Gary/sketchbook/TwitterTree/ and run TwitterTree.pde in processing
5. Press the play icon on the top left corner
6. Enjoy!
