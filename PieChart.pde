public class PieChart extends Chart{

  float total = 0;
  
  public PieChart(Data data, int chartX, int chartY, int chartWidth, int chartHeight){
    super(data, chartX, chartY, chartWidth, chartHeight);
    this.name = "pie";
    
    for(int i = 0; i < data.size; i++) {
      total += this.data.dataPoints[i].value;
    }
    
  }

  @Override
  public void draw(){
    // Be careful of this!!
    float r = this.viewWidth * .4; 
    PVector center = new PVector(this.viewX + (this.viewWidth/2), this.viewY + (this.viewHeight /2));

    float start = 0;
    float end;
    stroke(0);
    strokeWeight(1);
    for (int i = 0; i < data.size; i++) {
      end = start + this.data.dataPoints[i].value * 2 * PI / this.total;
   
     if (this.data.dataPoints[i].isMarked) {
          fill(#b3cce0);
      } else {
          fill(255);
      }
   
      arc(center.x, center.y,
      r * 2,
      r * 2,
      start,
      end, PIE);
      
      start = end;
    }
  }

   private int quadrant(float theta) {
    if(theta < PI/2) {
       return 1; 
    } else if(theta < PI) {
      return 2;
    } else if(theta < 1.5*PI) {
      return 3;
    } else {
      return 4;
    }
  }

  private PVector getPoint(float theta, PVector c, float rad) {
    PVector point = new PVector(0,0);

    float cx = c.x;
    float cy = c.y;
    float r = rad;

    if (quadrant(theta) == 1) {
      point.x = cx + r * cos(theta);
      point.y = cy + r * sin(theta);
    } else if(quadrant(theta) == 2) {
      theta = PI + theta;
      point.x = cx - r * cos(theta);
      point.y = cy - r * sin(theta);
    } else if(quadrant(theta) == 3) {
      theta = theta - PI;
      point.x = cx - r * cos(theta);
      point.y = cy - r * sin(theta);
    } else {
      theta = 2*PI - theta;
      point.x = cx + r * cos(theta);
      point.y = cy - r * sin(theta);
    }
    return point;
  }


}