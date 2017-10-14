public class UI { //<>//
  private PVector pos = new PVector();//top left of ui to use to draw rest of ui relative to this point 
  private float UIWidth, UIHeight, UIGap;
  private PFont roboto = createFont("Roboto-Black.ttf", 18);

  private List<Button> buttonList = new ArrayList<Button>();
  private Tower[] towers;

  private color background = color(239, 245, 205);

  public UI() {
    pos.x = width*0.85;
    pos.y = 0;
    UIWidth = width - pos.x;
    UIHeight = height;
    UIGap = UIWidth*0.1;

    //creates buttons and adds them to a list 
    buttonList.add(new Button(calcX(width*0.025), calcY(width*0.12), "Speed", 0.5));//upgrade speed
    buttonList.add(new Button(calcX(width*0.025), calcY(width*0.18), "Damage", 0.5));//upgrade damage
    buttonList.add(new Button(calcX(width*0.025), calcY(width*0.44), "Next Wave", 0.38));//next wave of targets
    buttonList.add(new Button(calcX(width*0.025), calcY(width*0.5), "Change Map", 0.35));//changes map
  }

  public void drawUI() {
    //background 
    noStroke();
    fill(background);
    rect(pos.x, pos.y, UIWidth, UIHeight);

    //labels
    textFont(roboto);
    textSize(width*0.035);
    textAlign(LEFT);
    //lives
    fill(237, 28, 36);
    text(lives, calcX(width*0.05), calcY(width*0.04));
    //money
    fill(34, 177, 76);
    text("$ " + money, calcX(width*0.05), calcY(width*0.08));
    //currently selected tower stats 
    fill(52, 51, 46);
    textSize(width*0.015);
    if (highlightedTower != null) {
      text("Shooting Speed: " + (60/highlightedTower.bulletFrameRate), calcX(width*0.01), calcY(width*0.25));
      text("Bullet Damage: " + highlightedTower.bulletDamage, calcX(width*0.01), calcY(width*0.27));
    } else {
      text("No Tower Selected", calcX(width*0.01), calcY(width*0.25));
    }
    //upgrade cost
    text("$50 per upgrade", calcX(width*0.025), calcY(width*0.11));
    //current wave
    text("Wave: " + wave, calcX(width*0.025), calcY(width*0.43));

    drawTowersToBuy(width*0.28);

    //draws buttons
    for (Button button : buttonList)
      button.drawButton();
  }

  /*
  * calls appropriate method depenging on the button pressed 
   */
  public void clickedButtons(float x, float y) {
    int buttonClicked = -1; 

    for (int i = 0; i < buttonList.size(); i++) {
      Button currentButton = buttonList.get(i);

      if (currentButton.buttonClicked(x, y)) {
        buttonClicked = i;
        break;
      }
    }

    //no button was clicked 
    if (buttonClicked == -1) return;

    //upgrade speed
    if (buttonClicked == 0)
      upgradeSelectedTowerSpeed();
    //upgrade damage
    if (buttonClicked == 1)
      upgradeSelectedTowerDamage();
    //upgrade damage
    if (buttonClicked == 2)
      waveOfTargets();
    if (buttonClicked == 3)
      changeMap();
  }

  /**
   * gets a tower that the user may buy
   */
  public Tower getTowerAtPos(int x, int y) {
    for (int i = 0; i < towers.length; i++) {
      Tower tower = towers[i];

      if (dist(x, y, tower.pos.x, tower.pos.y) < 2*tower.size) {
        return tower;
      }
    }
    return null;
  }

  private void drawTowersToBuy(float yPos) {
    float x = calcX(UIGap);
    float y = calcY(yPos);
    color divider = color(52, 51, 46);

    //draw dividers 
    float sizeS = UIGap/3;
    float sizeL = UIWidth - UIGap*2;

    fill(divider);
    //vertical 
    rect(x + sizeL/2 - sizeS/2, y, sizeS, sizeL);
    //horizontal 
    //rect(x, y + sizeL/2 - sizeS/2, sizeL, sizeS);

    //draw towers 
    float startX = x + sizeL*0.25;
    float startY = y + sizeL*0.25;

    towers = new Tower[2];

    towers[0] = new Tower(10, 45, 150, color(0, 0, 255), color(0, 255, 0), targets, bullets);
    towers[1] = new Tower(2, 15, 100, color(255, 0, 0), color(0, 0, 255), targets, bullets);

    //draw each tower
    for (int i = 0; i < towers.length; i++) {
      int xTower = (int)(startX  + sizeL*0.5*i);
      int yTower = (int)startY;
      towers[i].pos = new PVector(xTower, yTower);

      towers[i].drawTower();
      //description
      fill(52, 51, 46);
      text("$" + towers[i].price, xTower*0.975, yTower*1.15);

      if (dist(mouseX, mouseY, towers[i].pos.x, towers[i].pos.y) < towers[i].size) 
        statsBox(mouseX, mouseY, towers[i].bulletFrameRate, towers[i].bulletDamage);
    }
  }

  private void statsBox(int x, int y, float speed, float damage) {
    float size = width*0.05;
    float xTop = x - 2*size;
    float yTop = y - size;

    //box
    fill(52, 51, 46, 127);
    noStroke();
    rect(xTop, yTop, 2*size, size);

    //text
    fill(background);
    text("Speed: " + (60/speed), xTop*1.005, yTop*1.05);
    text("Damage: " + damage, xTop*1.005, yTop*1.12);
  }

  /**
   * calculates position relative to ui
   */
  private float calcX(float x) {
    return x + pos.x;
  }

  /**
   * calculates position relative to ui
   */
  private float calcY(float y) {
    return y + pos.y;
  }
}