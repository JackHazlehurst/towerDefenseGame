class Path {
  private List<PVector> segmentList = new ArrayList<PVector>();//points making up path
  private color pathColor = color(190);
  private float pathWidth = width*0.045;

  /*
  * adds point to path 
   */
  public void addPoint(float x, float y) {
    segmentList.add(new PVector(x, y));
  }

  public void drawPath() {
    //cannot draw with less than two points 
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

  public void circleIntersection(float x0, float y0, float x1, float y1, Tower tower) {
    //line stuff
    float m = (y1 - y0)/(x1 - x0);
    float yint = y0 - m*x0;

    float r = tower.size;
    //tower center 
    float xc = tower.pos.x;
    float yc = tower.pos.y;

    float a = 1 + m*m;
    float b = -2*xc + 2*m*yint - 2*m*yc;
    float c = xc*xc - 2*yc*yint + yint*yint + yc*yc - r*r;

    //results 
    float xResult1 = (-b + sqrt(b*b - 4*a*c))/(2*a);
    float xResult2 = (-b - sqrt(b*b - 4*a*c))/(2*a);
    float yResult1 = m*xResult1 + c;
    float yResult2 = m*xResult2 + c;

    println(xResult1, yResult1, xResult2, yResult2);
  }
}