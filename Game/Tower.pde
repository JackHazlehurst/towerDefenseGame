class Tower {
  private float RANGE;

  private PVector pos;
  private int price;
  private float direction = 0;
  private float size = width*0.025  ;
  private color towerColor, directionColor;
  private boolean towerHighlight = false;
  private float bulletDamage = 15;
  private int bulletSpeed = 10;

  private Target currentTarget = null;
  private List<Target> targets;
  private Set<Bullet> bullets;

  //data for bullet creation 
  private int lastBulletFrame = 0;//last frame a bullet was created 
  private int bulletFrameRate = 30;//after how many frames should a bullet be created 

  //used to determine the upgrade paths for the tower 
  private int currentSpeedLevel = 0;
  private float[][] speedUpgrades = {{0.3, 75}, {0.25, 60}, {0.1, 50}};//percentage increase, and associated cost 
  private int currentDamageLevel = 0;
  private float[][] damageUpgrades = {{0.2, 75}, {0.25, 100}, {0.3, 120}};//percentage increase, and associated cost 

  public Tower(int x, int y, float range, color tower, color direction, List<Target> targetList, Set<Bullet> bulletSet) {
    pos = new PVector(x, y);
    RANGE = range;
    targets = targetList;
    bullets = bulletSet;
    towerColor = tower;
    directionColor = direction;
  }

  //constructor for drawing the tower model that is not part of gameplay 
  public Tower(int x, int y, int cost, color tower, color direction) {
    pos = new PVector(x, y);
    towerColor = tower;
    directionColor = direction;
    price = cost;
  }

  /*
  * Updates the tower each frame ie redraws it 
   * shoots at any targets, etc...
   */
  public void updateTower() {
    //get target and find angle towards it
    currentTarget = selectTarget();

    //only updates direction and creates bullet if something is in range 
    if (currentTarget != null) {
      float dx = pos.x - currentTarget.x;
      float dy = pos.y - currentTarget.y;

      direction = atan2(dy, dx);

      createBullet();
    }

    drawTower();
    //draw range if the mouse is hovering over tower 
    if (Math.hypot(pos.x - mouseX, pos.y - mouseY) <= size)
      drawRange();
  }

  private void createBullet() {
    //IF bullet was created too recently, return 
    if (frameCount - lastBulletFrame < bulletFrameRate)
      return;

    bullets.add(new Bullet(new PVector(pos.x, pos.y), direction, bulletDamage, bulletSpeed));
    lastBulletFrame = frameCount;
  }

  /*
  * Draws the tower 
   */
  public void drawTower() {
    pushMatrix();

    //draw tower
    if (towerHighlight)
      stroke(0);
    else
      noStroke();

    strokeWeight(4);
    fill(towerColor);
    translate(pos.x, pos.y);
    ellipse(0, 0, 2*size, 2*size);

    //draw direction indicator 
    stroke(directionColor);
    strokeWeight(4);
    rotate(direction);
    line(0, 0, -size, 0);

    popMatrix();
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

  public boolean upgradeSpeed() {
    if (currentSpeedLevel >= speedUpgrades.length) return false;//no upgrades left
    
    float upgradeCost = speedUpgrades[currentSpeedLevel][1];
    float upgradePercentage = speedUpgrades[currentSpeedLevel][0];
    
    println(upgradeCost, upgradePercentage);
    
    if (money - upgradeCost < 0) return false;//insuffcient funds 

    println(bulletFrameRate);
    bulletFrameRate -= bulletFrameRate*upgradePercentage;
    println(bulletFrameRate);
    currentSpeedLevel++;
    money -= upgradeCost;
    return true;
  }
  
  public boolean upgradeDamage() {
    if (currentDamageLevel >= damageUpgrades.length) return false;//no upgrades left
    
    float upgradeCost = damageUpgrades[currentDamageLevel][1];
    float upgradePercentage = damageUpgrades[currentDamageLevel][0];
    
    if (money - upgradeCost < 0) return false;//insuffcient funds 

    bulletDamage += bulletDamage*upgradePercentage;
    currentDamageLevel++;
    money -= upgradeCost;
    return true;
  }
}