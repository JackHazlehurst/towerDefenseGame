public class Button {
  private float buttonWidth = width*0.1;
  private float buttonHeight = width*0.05;
  private float fontSize;
  private color buttonBackground = color(52, 51, 46);
  private color buttonText = color(239, 245, 205);
  private PVector pos;
  private String text;

  public Button(float x, float y, String label, float fontScalingFactor) {
    pos = new PVector(x, y);
    text = label;
    fontSize = buttonHeight*fontScalingFactor;
  }

  public void drawButton() {
    //IF mouse over button, invert colors 
    if (mouseX > pos.x&& mouseX < pos.x + buttonWidth && mouseY > pos.y && mouseY < pos.y + buttonHeight) {
      //background
      stroke(buttonBackground);
      fill(buttonText);
      rect(pos.x, pos.y, buttonWidth, buttonHeight);

      //label
      textAlign(CENTER);
      textSize(fontSize);
      fill(buttonBackground);
      text(text, pos.x + buttonWidth/2, pos.y + buttonHeight/1.5);
    }
    //draw button normally 
    else {
      //background
      stroke(buttonBackground);
      fill(buttonBackground);
      rect(pos.x, pos.y, buttonWidth, buttonHeight);

      //label
      textAlign(CENTER);
      textSize(fontSize);
      fill(buttonText);
      text(text, pos.x + buttonWidth/2, pos.y + buttonHeight/1.5);
    }
  }

  /*
  * determines if a mouse click is on a button
   */
  public boolean buttonClicked(float x, float y) {
    if (x > pos.x && x < pos.x + buttonWidth && y > pos.y && y < pos.y + buttonHeight)
      return true;

    return false;
  }
}