public class BarChart extends Chart{
  
  float offset = 20;
  float lx = this.viewX + offset;
  float rx = lx + this.viewWidth - 2 * offset;
  float ty = this.viewY + offset;
  float by = ty + this.viewHeight - 2 * offset;
  
  public BarChart(Data data, int chartX, int chartY, int chartWidth, int chartHeight){
    super(data, chartX, chartY, chartWidth, chartHeight);
    this.name = "Bar Chart";
  }

  @Override
  public void draw(){

       this.draw_axes();
       
       int len = this.data.size;
       float max = 0;
       float interval = this.viewWidth / (len+2);
       float bar_width = interval*.8;
     
       for(int i = 0; i < len; i++) {
           if (this.data.dataPoints[i].value > max) {
               max = this.data.dataPoints[i].value;
           }
       }
     
       for (int i = 0; i < len; i++){
         float x_pos = lx + i * interval;  // determine x pos of bars
         float y_pos = by - ((this.data.dataPoints[i].value / max) * this.viewHeight);  
         
         rect(x_pos, y_pos, bar_width, by - y_pos);
         if (this.data.dataPoints[i].isMarked) {
             fill(0);
             ellipse(x_pos + bar_width/2, y_pos + (by - y_pos)/2, 5, 5);
             noFill();
         }
        }
  }
    
  void draw_axes(){
      stroke(0);

      line(lx, by, rx, by);
      //line(lx, ty, lx, by);

   }
}