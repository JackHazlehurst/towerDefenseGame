class Bullet {
  private int SPEED = 10;
  private float SIZE = width*0.005;
  private float DIRECTION; //angle of movement in radians
  private color BULLET_COLOR = color(255, 50, 50);

  private PVector pos; 

  public Bullet(PVector position, float dir) {
    pos = position;
    DIRECTION = dir;
  }

  public void drawBullet() {
    pushMatrix();

    //move the bullet 
    pos.x += SPEED * cos(DIRECTION + PI); 
    pos.y += SPEED * sin(DIRECTION + PI); 

    //draw the bullet 
    noStroke();
    fill(BULLET_COLOR);

    translate(pos.x, pos.y);
    rotate(DIRECTION + PI/2);

    ellipse(0, 0, SIZE, SIZE*4);

    popMatrix();
  }

  /**
   *  returns true if the bullet is off the screen 
   */
  public boolean offScreen() {    
    if (pos.x < -SIZE || pos.x > width + SIZE || pos.y < -SIZE || pos.y > height + SIZE)
      return true;

    //bullet still on screen 
    return false;
  }
}