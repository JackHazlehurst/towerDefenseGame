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

  private void calculatePoints() {
    List<PVector> pointsList = path.segmentList;
    int segment = segmentProgress % (pointsList.size() - 1);

    count++;

    //points of curve
    float x0 = pointsList.get(segment).x;
    float y0 = pointsList.get(segment).y;
    float x1 = pointsList.get(segment + 1).x;
    float y1 = pointsList.get(segment + 1).y;

    float amt = (count % speed)/speed;

    if (amt > 0.99)
      segmentProgress++;
    //IF reached end of path
    if (segmentProgress == pointsList.size() - 1)
      reachedEnd = true;

    x = lerp(x0, x1, amt);
    y = lerp(y0, y1, amt);
  }
}