public class ExperimentKeeper{

  private static final String PARTICIPANT_ID     = "p7"; //ToDo: assign a unique id for each participant
  private static final int NUMBER_OF_TRIALS      = 10;    //ToDo: deside # trials per participant
  private static final int NUMBER_OF_DATA_POINTS = 7;   //ToDo: deside # data points per trial

  private static final int STATE_PROLOGUE = 0;
  private static final int STATE_TRIAL    = 1;
  private static final int STATE_EPILOGUE = 2;

  private Canvas canvas;
  private String participantID;
  private int totalTrials;
  private int currentTrialIndex;
  private Chart[] charts;
  private Chart chart;
  private String answer;
  private Table result;
  private int state;

  public ExperimentKeeper(int canvasX, int canvasY, int canvasWidth, int canvasHeight){
    this.canvas = new Canvas(canvasX, canvasY, canvasWidth, canvasHeight);
    this.participantID = PARTICIPANT_ID;
    this.totalTrials = NUMBER_OF_TRIALS;
    this.currentTrialIndex = 0;
    int numberOfDataPointsPerTrial = NUMBER_OF_DATA_POINTS;

    int chartSize = 300;
    int chartX = this.canvas.getCenterX() - chartSize / 2;
    int chartY = this.canvas.getY() + 100;

    Data[] dataset = this.generateDatasetBy(this.totalTrials, numberOfDataPointsPerTrial);
    this.charts = this.generateChartsFor(dataset, chartX, chartY, chartSize, chartSize);

    this.chart = null;
    this.answer = "";
    this.result = this.createResultTable();
    this.state = STATE_PROLOGUE;
  }

  public Data[] generateDatasetBy(int numberOfTrials, int numberOfDataPointPerTrial){
    Data[] dataset = new Data[numberOfTrials];
    
    for (int i = 0; i < numberOfTrials; i++) {
        dataset[i] = new Data(numberOfDataPointPerTrial);
    }
    //ToDo: decide how to generate the dataset you will be using (See also Data.pde)
    //      Note that the "dataset" holds all data that will be used in one experiment

    return dataset;
  }

  public Chart[] generateChartsFor(Data[] dataset, int chartX, int chartY, int chartWidth, int chartHeight){
    
    //println ("dataset length: " + dataset.length);
    Chart[] charts = new Chart[dataset.length];

    //ToDo: decide how to generate your visualization for each data (See also Chart.pde and SampleChart.pde)
    //      Note that each data holds all datapoints that will be projected in one chart
    for(int i = 0; i < dataset.length; i++){
      if (i % 2 == 0) {
          charts[i] = new PieChart(dataset[i], chartX, chartY, chartWidth, chartHeight);
      } else {
          charts[i] = new Polar(dataset[i], chartX, chartY, chartWidth, chartHeight);
      }
    }

    return charts;
  }

  public void draw(){
    this.canvas.draw();
    if(this.state == STATE_PROLOGUE)
      this.canvas.drawIntroduction();
    else if(this.state == STATE_TRIAL)
      this.canvas.drawTrialWith(this.chart, this.answer, this.currentTrialIndex + 1, this.totalTrials);
    else if(this.state == STATE_EPILOGUE)
      this.canvas.drawClosingMessage();
  }

  private Table createResultTable(){
    Table table = new Table();
    table.addColumn("PartipantID");
    table.addColumn("TrialIndex");
    table.addColumn("ChartName");
    table.addColumn("TruePercentage");
    table.addColumn("ReportedPercentage");
    table.addColumn("Error");
    table.addColumn("Angle");
    return table;
  }

  public void onMouseClickedAt(int x, int y){
    //println("X:" + x + ", Y:" + y);
    if(this.canvas.contain(x, y)){
      switch(this.state){
        case STATE_PROLOGUE:
          if(this.canvas.hasActiveAgreeButtonAt(x, y)){
            this.chart = this.charts[this.currentTrialIndex];
            this.answer = "";
            this.state = STATE_TRIAL;
          }else if(this.canvas.hasActiveDisagreeButtonAt(x, y)){
            exit();
          }
          break;

        case STATE_TRIAL:
          if(this.canvas.hasActiveNextButtonAt(x, y)){

            Data data = this.chart.getData();

            float truePercentage = truePercentage(data);     //ToDo: decide how to compute the right answer
            float reportedPercentage = float(this.answer) /100; //ToDo: Note that "this.answer" contains what the participant inputed
            float error = log(abs(reportedPercentage - truePercentage) + .125) / log(2);
            //ToDo: decide how to compute the log error from Cleveland and McGill (see the handout for details)
            
            float m1 = 0; // the angle of the first marked section
            float m2 = 0; // the angle of the second marked section
            float angle = 0;
            for (int i = 0; i < NUMBER_OF_DATA_POINTS; i++) {
                if (data.dataPoints[i].isMarked) { // first marked segment
                    if (this.currentTrialIndex % 2 == 0) {
                        m1 = (data.dataPoints[i].value / data.total) * TWO_PI;
                    } else {
                        m1 = TWO_PI / NUMBER_OF_DATA_POINTS;
                        m2 = TWO_PI / NUMBER_OF_DATA_POINTS;
                    }
                    for (int j = i + 1; j < NUMBER_OF_DATA_POINTS; j++) {
                        if (data.dataPoints[j].isMarked) {
                            if (this.currentTrialIndex % 2 == 0 ) { // pie
                                m2 = (data.dataPoints[j].value / data.total) * TWO_PI;
                                for (int k = i + 1; k < j; k++) {
                                  angle += (data.dataPoints[k].value / data.total) * TWO_PI;
                                }
                            } else { // polar
                                float segmentAngle = TWO_PI / NUMBER_OF_DATA_POINTS;
                                angle = segmentAngle * (j - i - 1);
                            }
                            break;
                        }
                    }
                     break;
                }
           
            }
            
            //println((angle + m1 / 2 + m2 / 2) / TWO_PI * 360);
            if ((angle + m1 / 2 + m2 / 2) > PI) { // if the angle is more than 180
                angle = TWO_PI - (angle + m1 + m2);
            }
            
            //println((angle + m1 / 2 + m2 / 2) / TWO_PI * 360);
            
            TableRow row = this.result.addRow();
            row.setString("PartipantID", this.participantID);
            row.setInt("TrialIndex", this.currentTrialIndex);
            row.setString("ChartName", this.chart.getName());
            row.setFloat("TruePercentage", truePercentage);
            row.setFloat("ReportedPercentage", reportedPercentage);
            row.setFloat("Error", error);
            row.setFloat("Angle", angle);

            ++this.currentTrialIndex;
            if(this.currentTrialIndex < this.totalTrials){
              this.chart = this.charts[this.currentTrialIndex];
              this.answer = "";
            }else{
              this.state = STATE_EPILOGUE;
            }
          }
          break;

        case STATE_EPILOGUE:
          if(this.canvas.hasActiveCloseButtonAt(x, y)){
            saveTable(this.result, this.participantID + ".csv", "csv");
            exit();
          }
          break;

        default:
          break;
      }
    }
  }

  public float truePercentage(Data dataSet) {
   //get marked data points
   //calc difference
     float val1 = -1;
     float val2 = -1;
     for(int i = 0; i < dataSet.size; i++) {
       if (val1 == -1) {
         if (dataSet.dataPoints[i].isMarked ) {
            val1 = dataSet.dataPoints[i].value;
         }
       } else {
         if (dataSet.dataPoints[i].isMarked ) {
          val2 = dataSet.dataPoints[i].value; 
         }
       }
     }
     
     if (val1 > val2) {
      return val2/val1; 
     } else {
       return val1/val2; 
     }
  }

  public void onKeyTyped(int keyTyped){
    //println(int(keyTyped) + ":" + char(keyTyped));
    if(this.state == STATE_TRIAL){
      if(keyTyped == 46 || (48 <= keyTyped && keyTyped <= 57)){ //period or between 0-9
        if(this.answer.length() < 10){ //limit # charcters to be 10
          this.answer += char(keyTyped);
          if(!Float.isNaN(float(this.answer)))
            this.canvas.enableNextButton();
          else
            this.canvas.disableNextButton();
        }
      }else if(keyTyped == 8 || keyTyped == 127){ //backspace, delete
        if(this.answer.length() > 0){
          this.answer = this.answer.substring(0, this.answer.length() - 1);
          if(!Float.isNaN(float(this.answer)) && this.answer.length() > 0)
            this.canvas.enableNextButton();
          else
            this.canvas.disableNextButton();
        }
      }
    }
  }

}