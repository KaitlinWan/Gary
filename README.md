# Team Gary
Josh Weiner, Eric Wong, Kaitlin Wan

APCS2 Final Project - Tweetilize

## Description of our Projcect.
Have you ever wondered how different your life would be without the idea of news feeds and social media? Scrolling through unorganized, cluttered feeds can be a detrement to your life. Therefore, Team Gary has developed a new way to mitigate your aimless scrolling. With our processing based Twitter interface, you can discover a whole new experience. Our minimalistic approach to Twitter, you are capable of searching any topic. After searching, you are presented with a screen to select different ways of visualization. You can choose from sorting by followers, retweets, and location. As well as that, you are able to select the type of structure. When viewing, 

## Launch Instructions
1. Clone our repo
2. Proceed to Gary/sketchbook/TwitterTree/
3. Inside TwitterTree, copy the folder called "twitter4j01" into your local processing libraries folder. (That is all you need to do because we took care of all the hard work specially for you!)
4. Go to Gary/sketchbook/TwitterTree/ and run TwitterTree.pde in processing
5. Press the play icon on the top left cornder
4. THE END!




-- OLDER STUFF --
<p> With our project, a user searches for a tweet and is presented with tweets matching the search query. They will choose how they wish tweets to be sorted: by retweets, by the tweeter's number of followers, by likes, or by geographic proximity to the user. They can then place the tweets in various structures, including in a minHeap, maxHeap, or binary tree. When presented with tweets, they can then click on a tweet and send a reply, which will be queued until the user decides to unqueue it and send the reply out. </p>

<h1> How did we do this?</h1>
<p> The visual component of this project is done through processing, and all the tweets are retrieved using a <a href = "http://twitter4j.org/en/index.html"> Java library </a> for the twitter api. The tweets are retrieved in real time, and are stored on a per-session basis in a structure that the user decides (heaps or binary tree). </p>

<h1> How can you use this project?</h1>
<p>It's simple! In our sketchbook directory, we included a folder called twitter4j401. This folder (and its contents) should be compied into the "libraries" folder of your Processing directory. That's it! We took care of all the hard work for you.<p>
