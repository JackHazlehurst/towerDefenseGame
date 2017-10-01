class Target {
  private Path path;
  private float x, y;
  private float size = width*0.018;
  private float speed = 165.0;
  private float health = 100;
  private int segmentProgress = 0;
  private int count = 0;//number of frames since creation of target 
  private boolean reachedEnd = false;//flag for target reaching end of path or end of life ie no more health 

  public Target(Path pathToFollow) {
    path = pathToFollow;
  }

  public void updateTarget() {
    bulletHits();
    drawTarget();
  }

  private void drawTarget() {
    //updates x, y positions 
    calculatePoints();

    noStroke();
    fill(getColor());
    ellipse(x, y, 2*size, 2*size);
  }

  /**
   * Removes health if a bullet has hit the target and
   * sets that bullet for removal 
   */
  private void bulletHits() {
    for (Bullet bullet : bullets) {
      //IF the bullet has hit this target, decrease health and remove bullet 
      if (dist(x, y, bullet.pos.x, bullet.pos.y) < size) {
        health -= bullet.DAMAGE;
        bullet.hitTarget = true;
      }
    }
  }

  /**
   * calculates the gradient of the two colors to use the target as the health indicator 
   */
  private color getColor() {
    color fullHealth = color(34, 177, 76);
    color noHealth = color(237, 28, 36);

    float scale = health/100;//how much of each color is in the final color 

    int r = round(red(fullHealth) * scale + red(noHealth) * (1 - scale));
    int g = round(green(fullHealth) * scale + green(noHealth) * (1 - scale));
    int b = round(blue(fullHealth) * scale + blue(noHealth) * (1 - scale));

    return color(constrain(r, 0, 255), constrain(g, 0, 255), constrain(b, 0, 255));
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