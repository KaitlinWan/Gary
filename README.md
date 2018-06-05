# Gary - Josh Weiner, Eric Wong, Kaitlin Wan
<b> Interactive: Twitter </b>
<h1>What can you do with our project </h1>
<p> With our project, a user searches for a tweet and is presented with tweets matching the search query. They will choose a sort method: by retweets, by the tweeter's number of followers, or by proximity. They can then place the tweets in various structures, including in a minHeap, maxHeap, or binary tree. When presented with tweets, they can then click on a tweet and send a reply, which will be queued until the user decides to unqueue it and send the reply out. </p>

<h1> How did we do this?</h1>
<p> The visual component of this project is done through processing, and all the tweets are retrieved using a <a href = "http://twitter4j.org/en/index.html"> Java library </a> for the twitter api. The tweets are retrieved in real time, and are stored on a per-session basis in a structure that the user decides (heaps or binary tree). </p>
