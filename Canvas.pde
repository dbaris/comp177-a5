import controlP5.*;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.sql.ResultSet;

public class Canvas extends Viewport{

  private Button agreeButton;
  private Button disagreeButton;
  private TextField answerTextField;
  private Button nextButton;
  private Button closeButton;

  public Canvas(int canvasX, int canvasY, int canvasWidth, int canvasHeight){
    super(canvasX, canvasY, canvasWidth, canvasHeight);

    int buttonWidth = 70;
    int buttonHeight = 34;
    int textFieldWidth = 200;
    int textFieldHeight = 34;

    this.agreeButton = new Button("AGREE", true, this.viewCenterX + 50, this.viewCenterY + 160, buttonWidth, buttonHeight);
    this.disagreeButton = new Button("DISAGREE", true, this.viewCenterX - 50 - buttonWidth, this.viewCenterY + 160, buttonWidth, buttonHeight);
    this.answerTextField = new TextField(this.viewCenterX - 140, this.viewCenterY + 200, textFieldWidth, textFieldHeight);
    this.nextButton = new Button("NEXT", false, this.viewCenterX + 80, this.viewCenterY + 200, buttonWidth, buttonHeight);
    this.closeButton = new Button("CLOSE", true, this.viewCenterX - (buttonWidth / 2), this.viewCenterY + 100, buttonWidth, buttonHeight);
  }

  @Override
  public void draw(){
    noStroke();
    fill(230);
    rect(this.viewX, this.viewY, this.viewWidth, this.viewHeight);
  }

  public void drawIntroduction(){
    fill(0);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("In this experiment, \n" +
         "you are asked to judge \n" +
         "ratios between graphical elements in serveral charts. \n\n" +
         "We won't record any other information from you except your answers.\n" +
         "Click the \"agree\" button to begin. \n\n" +
         "Thank you!", this.viewCenterX, this.viewCenterY);
    this.disagreeButton.draw();
    this.agreeButton.draw();
  }

  public void drawTrialWith(Chart chart, String answer, int trialNumber, int totalTrials){
    chart.draw();
    int y = chart.getY() + chart.getHeight() + 30;
    fill(0);
    textSize(20);
    textAlign(RIGHT, TOP);
    text("(" + trialNumber + "/" + totalTrials + ")", this.viewX + this.viewWidth, this.viewY);
    textSize(16);
    textAlign(CENTER);
    if (trialNumber % 2 == 1) { // pie charts
        text("Note: Value is encoded by area.\n" +
             "Two sections are highlighted. \n" +
             "What percentage is the smaller of the larger? \n" +
             "Please put your answer below. \n" +
             "e.g. If you think the smaller is exactly a half of the larger, \n" +
             "please input \"50\".", this.viewCenterX, y - 15);
    } else {// polar
        text("Note: Value is encoded in the radius.\n" +
             "Two sections are highlighted. \n" +
             "What percentage is the smaller of the larger? \n" +
             "Please put your answer below. \n" +
             "e.g. If you think the smaller is exactly a half of the larger, \n" +
             "please input \"50\".", this.viewCenterX, y - 15);
    }
    this.answerTextField.draw(answer);
    fill(0);
    textSize(16);
    textAlign(LEFT, TOP);
    text("ANSWER", this.answerTextField.getX(), this.answerTextField.getY() + this.answerTextField.getHeight());
    this.nextButton.draw();
  }

  public void drawClosingMessage(float pieErr, float polErr, float pieAvgErr, float polAvgErr){
    fill(0);
    textSize(60);
    textAlign(CENTER, CENTER);
    text("Thanks!", this.viewCenterX, this.viewCenterY);
    text("pie error: " + str(pieErr), this.viewCenterX, this.viewCenterY + 10);
    text("pol error: " + str(polErr), this.viewCenterX, this.viewCenterY + 20);
    text("pie average error: " + str(pieAvgErr), this.viewCenterX, this.viewCenterY + 30);
    text("pol average error: " + str(polAvgErr), this.viewCenterX, this.viewCenterY + 40);
    this.closeButton.draw();
  }

  public void enableNextButton(){
    this.nextButton.enable();
  }

  public void disableNextButton(){
    this.nextButton.disable();
  }

  public boolean hasActiveAgreeButtonAt(int x, int y){
    if(this.agreeButton.isEnabled() && this.agreeButton.contain(x, y))
      return true;
    else
      return false;
  }

  public boolean hasActiveDisagreeButtonAt(int x, int y){
    if(this.disagreeButton.isEnabled() && this.disagreeButton.contain(x, y))
      return true;
    else
      return false;
  }

  public boolean hasActiveNextButtonAt(int x, int y){
    if(this.nextButton.isEnabled() && this.nextButton.contain(x, y))
      return true;
    else
      return false;
  }

  public boolean hasActiveCloseButtonAt(int x, int y){
    if(this.closeButton.isEnabled() && this.closeButton.contain(x, y))
      return true;
    else
      return false;
  }

}