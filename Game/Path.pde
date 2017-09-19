class Path {
  private List<PVector> segmentList = new ArrayList<PVector>();//points making up path
  private color pathColor = color(190);
  private float pathWidth = width*0.45;

  /*
  * adds point to path 
   */
  public void addPoint(float x, float y) {
    segmentList.add(new PVector(x, y));
  }

  public void drawPath() {
    //cannot draw with less than four points 
    if (segmentList.size() < 2)
      return;

    for (int i = 0; i < segmentList.size() - 1; i++) {
      float x0 = segmentList.get(i).x;
      float y0 = segmentList.get(i).y;
      float x1 = segmentList.get(i + 1).x;
      float y1 = segmentList.get(i + 1).y;

      stroke(pathColor);
      strokeWeight(pathWidth);
      noFill();
      line(x0, y0, x1, y1);
    }
  }
}