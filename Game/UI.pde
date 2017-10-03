public class UI {
  private PVector pos = new PVector();//top left of ui to use to draw rest of ui relative to this point 
  private PFont roboto = createFont("Roboto-Black.ttf", 18);

  private color background = color(239, 245, 205);

  public UI() {
    pos.x = width*0.85;
    pos.y = 0;
  }

  public void drawUI() {
    //background 
    noStroke();
    fill(background);
    rect(pos.x, pos.y, width - pos.x, height);

    //labels
    textFont(roboto);
    textSize(width*0.035);
    textAlign(LEFT);
    //lives
    fill(237, 28, 36);
    text(lives, calcX(width*0.05), calcY(width*0.04));
    //money
    fill(34, 177, 76);
    text(money, calcX(width*0.05), calcY(width*0.08));

    drawButton(width*0.025, width*0.1, "Test");
  }

  private void drawButton(float x, float y, String text) {
    float buttonWidth = width*0.1;
    float buttonHeight = width*0.05;
    color buttonBackground = color(52, 51, 46);
    color buttonText = background;

    //IF mouse over button, invert colors 
    if (mouseX > calcX(x) && mouseX < calcX(x) + buttonWidth && mouseY > calcY(y) && mouseY < calcY(y) + buttonHeight) {
      //background
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