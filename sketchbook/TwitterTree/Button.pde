public class Button {
  
  public float xcor;
  public float ycor;
  public float wd;
  public float ht;
  public color col;
  public String text;
  
  public Button(float x,float y,float w,float h,String str) {
    xcor = (float)x;
    ycor = y;
    wd = w;
    ht = h;
    col = 175;
    text = str;
  }
  
  void update() {
    fill(col);
    rect(xcor, ycor, wd, ht, 7);
    
    fill(255);
    textSize(25);
    text(text, xcor, ycor, wd + 10, ht + 5);
  }
}
