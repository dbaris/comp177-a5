public abstract class Viewport{

  protected int viewX;
  protected int viewY;
  protected int viewWidth;
  protected int viewHeight;
  protected int viewCenterX;
  protected int viewCenterY;

  public Viewport(int viewX, int viewY, int viewWidth, int viewHeight){
    this.set(viewX, viewY, viewWidth, viewHeight);
  }

  protected void set(int viewX, int viewY, int viewWidth, int viewHeight){
    this.viewX = viewX;
    this.viewY = viewY;
    this.viewWidth = viewWidth;
    this.viewHeight = viewHeight;
    this.viewCenterX = viewX + (viewWidth / 2);
    this.viewCenterY = viewY + (viewHeight / 2);
  }

  public int getX(){
    return this.viewX;
  }
  public int getY(){
    return this.viewY;
  }
  public int getWidth(){
    return this.viewWidth;
  }
  public int getHeight(){
    return this.viewHeight;
  }
  public int getCenterX(){
    return this.viewCenterX;
  }
  public int getCenterY(){
    return this.viewCenterY;
  }

  public abstract void draw();

  public boolean contain(int pointX, int pointY){
    if(this.viewX <= pointX && pointX <= this.viewX + this.viewWidth &&
       this.viewY <= pointY && pointY <= this.viewY + this.viewHeight)
      return true;
    else
      return false;
  }

}