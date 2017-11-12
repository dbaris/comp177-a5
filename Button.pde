public class Button extends Viewport{

  private String title;
  private boolean isEnabled;

  public Button(String title, boolean isEnabled, int buttonX, int buttonY, int buttonWidth, int buttonHeight){
    super(buttonX, buttonY, buttonWidth, buttonHeight);
    this.title = title;
    this.isEnabled = isEnabled;
  }

  public void enable(){
    this.isEnabled = true;
  }

  public void disable(){
    this.isEnabled = false;
  }

  public boolean isEnabled(){
    return this.isEnabled;
  }

  @Override
  public void draw(){
    noStroke();
    if(this.isEnabled)
      fill(41, 128, 164);
    else
      fill(238, 188, 208);
    rect(this.viewX, this.viewY, this.viewWidth, this.viewHeight);
    fill(255);
    textSize(14);
    textAlign(CENTER, CENTER);
    text(this.title, this.viewCenterX, this.viewCenterY);
  }

}