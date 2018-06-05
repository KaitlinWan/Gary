public class Button {
  
  float xcor, ycor, wd, ht, col;
  String text;
  
  public Button(float x,float y,float w,float h,String str) {
    xcor = x;
    ycor = y;
    wd = w;
    ht = h;
    col = 180;
    text = str;
  }
  
  void update() {
    fill(col);
    rect(xcor, ycor, wd, ht, 7);
  }
}
