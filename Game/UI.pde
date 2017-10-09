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
    buttonList.add(new Button(calcX(width*0.025), calcY(width*0.1), "Speed", 0.5));//upgrade speed
    buttonList.add(new Button(calcX(width*0.025), calcY(width*0.17), "Damage", 0.5));//upgrade damage
    buttonList.add(new Button(calcX(width*0.025), calcY(width*0.5), "Next Wave", 0.38));//next wave of targets
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

    drawTowersToBuy(width*0.4);

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
  }

  /**
   * gets a tower that the user may buy, but a copy of it 
   */
  public Tower getTowerAtPos(int x, int y) {
    for (int i = 0; i < towers.length; i++) {
      Tower tower = towers[i];

      if (dist(x, y, tower.pos.x, tower.pos.y) < 2*tower.size) {
        Tower toReturn = new Tower((int)tower.pos.x, (int)tower.pos.y, tower.price, tower.towerColor, tower.directionColor);

        return toReturn;
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
    rect(x, y + sizeL/2 - sizeS/2, sizeL, sizeS);

    //draw towers 
    float startX = x + sizeL*0.25;
    float startY = y + sizeL*0.25;

    towers = new Tower[2];

    towers[0] = new Tower((int)startX, (int)startY, 150, color(0, 0, 255), color(0, 255, 0));
    towers[1] = new Tower((int)(startX + sizeL*0.5), 200, (int)startY, color(255, 0, 0), color(0));

    for (int i = 0; i < towers.length; i++) {
      towers[i].drawTower();
    }
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