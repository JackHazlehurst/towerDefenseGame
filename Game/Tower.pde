class Tower {
  float x, y;
  float size = width*0.05;
  color towerColor = color(0, 0, 255);

  public Tower(int xPos, int yPos) {
    x = xPos;
    y = yPos;
  }

  /*
  * Draws the tower 
   */
  public void drawTower() {
    fill(towerColor);
    noStroke();
    ellipse(x, y, size, size);
  }
}