public class UI {
  private PVector pos = new PVector();//top left of ui to use to draw rest of ui relative to this point 
  private float UIWidth, UIHeight, UIGap;
  private PFont roboto = createFont("Roboto-Black.ttf", 18);

  private Tower[] towers;

  private color background = color(239, 245, 205);

  public UI() {
    pos.x = width*0.85;
    pos.y = 0;
    UIWidth = width - pos.x;
    UIHeight = height;
    UIGap = UIWidth*0.1;
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

    drawButton(width*0.025, width*0.1, "Test");
  }

  /**
   * gets a tower that the user may buy, but a copy of it 
   */
  public Tower getTowerAtPos(int x, int y) {
    for (int i = 0; i < towers.length; i++) {
      Tower tower = towers[i];

      if (dist(x, y, tower.pos.x, tower.pos.y) < 2*tower.size){
        Tower toReturn = new Tower((int)tower.pos.x, (int)tower.pos.y, tower.price, tower.towerColor, tower.directionColor);
        
        return toReturn;
      } //<>//
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

  private void drawButton(float x, float y, String text) {
    float buttonWidth = width*0.1;
    float buttonHeight = width*0.05;
    color buttonBackground = color(52, 51, 46);
    color buttonText = background;

    //IF mouse over button, invert colors 
    if (mouseX > calcX(x) && mouseX < calcX(x) + buttonWidth && mouseY > calcY(y) && mouseY < calcY(y) + buttonHeight) {
      //background
      stroke(buttonBackground);
      fill(buttonText);
      rect(calcX(x), calcY(y), buttonWidth, buttonHeight);

      //label
      textAlign(CENTER);
      fill(buttonBackground);
      text(text, calcX(x + buttonWidth/2), calcY(y + buttonHeight/1.5));
    }
    //draw button normally 
    else {
      //background
      stroke(buttonBackground);
      fill(buttonBackground);
      rect(calcX(x), calcY(y), buttonWidth, buttonHeight);

      //label
      textAlign(CENTER);
      fill(buttonText);
      text(text, calcX(x + buttonWidth/2), calcY(y + buttonHeight/1.5));
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