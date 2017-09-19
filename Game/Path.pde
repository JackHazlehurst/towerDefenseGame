import java.util.List;

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
    if (segmentList.size() < 4)
      return;

    for (int i = 0; i < segmentList.size() - 3; i++) {
      float x0 = segmentList.get(i).x;
      float y0 = segmentList.get(i).y;
      float x1 = segmentList.get(i + 1).x;
      float y1 = segmentList.get(i + 1).y;
      float x2 = segmentList.get(i + 2).x;
      float y2 = segmentList.get(i + 2).y;
      float x3 = segmentList.get(i + 3).x;
      float y3 = segmentList.get(i + 3).y;

      stroke(pathColor);
      strokeWeight(pathWidth);
      noFill();
      curve(x0, y0, x1, y1, x2, y2, x3, y3);
    }
  }
}