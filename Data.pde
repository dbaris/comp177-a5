import java.util.*;


public class Data{

  private int size;
  private DataPoint[] dataPoints;
  Random rand = new Random();

  public Data(int size){
    this.size = size;
    this.dataPoints = new DataPoint[size];
    println(this.size);
    int count = 2;

    for (int i = 0; i < size; i++) {
      
        if (count > 0){
            int value = rand.nextInt((100 - 20) + 1) + 20;
            this.dataPoints[i] = new DataPoint(float(value), true);
            count--;
        } else {
            int value = rand.nextInt((100 - 20) + 1) + 20;
            this.dataPoints[i] = new DataPoint(float(value), false);
        }   
    }

    Collections.shuffle(Arrays.asList(this.dataPoints)); 
  }

  //ToDo: feel free to add varialves and methods for your convenience


  public int size(){
    return this.size;
  }

  private class DataPoint{
    private float value;
    private boolean isMarked;

    public DataPoint(float value, boolean isMarked){
      this.value = value;
      this.isMarked = isMarked;
    }

    public boolean isMarked(){
      return this.isMarked;
    }

    public float getValue(){
      return this.value;
    }

  }

}