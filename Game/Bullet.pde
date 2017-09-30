class Bullet {
  private int SPEED = 3;
  private float SIZE = width*0.05;
  private float DIRECTION; //angle of movement in radians
  private color BULLET_COLOR = color(255, 50, 50);

  private PVector pos; 

  public Bullet(int x, int y, float dir) {
    pos = new PVector(x, y);
    DIRECTION = dir;
  }

  public void drawBullet() {
    //move the bullet 
    pos.x += SPEED * sin(DIRECTION); 
    pos.y += SPEED * cos(DIRECTION); 

    //draw the bullet 
    noStroke();
    fill(BULLET_COLOR);

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-DIRECTION);

    ellipse(0, 0, SIZE, SIZE*4);
    popMatrix();
  }
}