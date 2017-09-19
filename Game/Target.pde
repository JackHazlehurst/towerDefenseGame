class Target {
  private Path path;
  private float x, y;
  private float size = width*0.033;
  private float speed = 165.0;
  private int segmentProgress = 0;
  private int count = 0;//number of frames since creation of target 
  private boolean reachedEnd = false;

  public Target(Path pathToFollow) {
    path = pathToFollow;
  }

  public void drawTarget() {
    calculatePoints();
    
    fill(0);
    strokeWeight(1);
    ellipse(x, y, size, size);
  }
  
  private void calculatePoints(){
    List<PVector> pointsList = path.segmentList;
    int segment = segmentProgress % (pointsList.size() - 3);
    
    count++;
    
    //points of curve
    float x0 = pointsList.get(segment).x;
    float y0 = pointsList.get(segment).y;
    float x1 = pointsList.get(segment + 1).x;
    float y1 = pointsList.get(segment + 1).y;
    float x2 = pointsList.get(segment + 2).x;
    float y2 = pointsList.get(segment + 2).y;
    float x3 = pointsList.get(segment + 3).x;
    float y3 = pointsList.get(segment + 3).y;
    
    float t = (count % speed)/speed;
    
    if(t > 0.99)
      segmentProgress++;
    //IF reached end of path
    if(segmentProgress == pointsList.size() - 3)
      reachedEnd = true;
    
    x = curvePoint(x0, x1, x2, x3, t);
    y = curvePoint(y0, y1, y2, y3, t);
  }
}