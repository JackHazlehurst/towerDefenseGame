class Tower {
  private float RANGE;

  private PVector pos;
  private float direction = 0;
  private float size = width*0.025  ;
  private color towerColor = color(0, 0, 255);

  private Target currentTarget = null;
  private List<Target> targets;

  public Tower(int x, int y, float range, List<Target> targetList) {
    pos = new PVector(x, y);
    RANGE = range;
    targets = targetList;
  }

  /*
  * Updates the tower each frame ie redraws it 
   * shoots at any targets, etc...
   */
  public void updateTower() {
    //get target and find angle towards it
    currentTarget = selectTarget();

    //only updates direction if something is in range 
    if (currentTarget != null) {
      float dx = pos.x - currentTarget.x;
      float dy = pos.y - currentTarget.y;

      direction = atan2(dy, dx);
    }

    drawTower();
  }

  /*
  * Draws the tower 
   */
  private void drawTower() {
    pushMatrix();
    //draw tower
    fill(towerColor);
    noStroke();
    translate(pos.x, pos.y);
    ellipse(0, 0, 2*size, 2*size);
    
    //draw direction indicator 
    stroke(0, 255, 0);
    strokeWeight(4);
    rotate(direction);
    line(0, 0, -size, 0);
    popMatrix();

    //draw range if the mouse is hovering over tower 
    if (Math.hypot(pos.x - mouseX, pos.y - mouseY) <= size)
      drawRange();
  }

  /*
  * draws the range at which the tower will shoot objects at 
   */
  private void drawRange() {
    noStroke();
    fill(127, 50);

    ellipse(pos.x, pos.y, 2*RANGE, 2*RANGE);
  }

  /*
  *  finds a target that the tower needs to shoot at ie is in range 
   *  If there is more than one tower in range it will pick the first one
   *  ie closest to the end of the track
   */
  private Target selectTarget() {
    //IF there are no targets, return null
    if (targets.isEmpty())
      return null;

    //returns the first target in range
    for (Target target : targets) {
      if (inRange(target.x, target.y))
        return target;
    }

    //IF there are no targets in range 
    return null;
  }

  /*
  *  checks if input is in range of the tower 
   */
  private boolean inRange(float x, float y) {
    if (dist(pos.x, pos.y, x, y) <= RANGE)
      return true;

    return false;
  }
}