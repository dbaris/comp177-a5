public class TextField extends Viewport{

  private static final String CARET = "|";

  private String text;

  public TextField(int viewX, int viewY, int viewWidth, int viewHeight){
    super(viewX, viewY, viewWidth, viewHeight);
    this.text = "";
  }

  public void clear(){
    this.text = "";
  }

  public void draw(String text){
    this.text = text;
    this.draw();
  }

  @Override
  public void draw(){
    stroke(39, 102, 127);
    fill(18, 64, 85);
    rect(this.viewX, this.viewY, this.viewWidth, this.viewHeight);
    fill(255);
    textSize(20);
    textAlign(LEFT, CENTER);
    text(this.text + CARET, this.viewX, this.viewCenterY);
  }

}