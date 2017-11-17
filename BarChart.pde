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
      
  }

  public void draw_bar(float pieErr, float polErr, float pieAvgErr, float polAvgErr){
       this.draw_axes();
       
       int len = 4;
       float max = 0;
       float interval = this.viewWidth / (len+2);
       float bar_width = interval*.8;
       
       float[] values = {pieErr, pieAvgErr, polErr, polAvgErr}; 
       String[] labels = {"User", "Average", "User", "Average"};
     
       for (float v : values) {
         if (v > max){
           max = v;
         }
       }
     
       for (int i = 0; i < len; i++){
         float x_pos = lx + i * interval;  // determine x pos of bars
        
         float y_pos = by - ((values[i] / max) * this.viewHeight); 
         
         if (i > 1){
             x_pos += bar_width;
         }
         
         if (i % 2 == 0) {
             fill(#afdbab);
         } else {
             fill(#b3cce0);
         }
         
         rect(x_pos, y_pos, bar_width, by - y_pos);
         
         fill(0);
         textSize(12);
         textAlign(CENTER, TOP);
         text(labels[i], x_pos + bar_width/2, by);
        }
        
        textAlign(CENTER, BOTTOM);
        textSize(20);
        text("Pie", lx + 3 * interval / 2 - bar_width, by + 50);
        text("Polar", lx + 3 * bar_width + 3 * interval /2, by + 50);
  }
    
  void draw_axes(){
      stroke(0);

      line(lx, by, rx, by);
      //line(lx, ty, lx, by);

   }
}