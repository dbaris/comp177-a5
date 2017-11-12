public class SampleChart extends Chart{

  public SampleChart(Data data, int chartX, int chartY, int chartWidth, int chartHeight){
    super(data, chartX, chartY, chartWidth, chartHeight);
    this.name = "sample";
  }

  @Override
  public void draw(){
    stroke(0);
    strokeWeight(1);
    fill(255);
    rect(this.viewX, this.viewY, this.viewWidth, this.viewHeight);
    fill(0);
    textSize(30);
    textAlign(CENTER, CENTER);
    text(this.name + "(" + this.data.size() + ")", this.viewCenterX, this.viewCenterY);
  }

}