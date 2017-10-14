//font used for the user interface //<>// //<>//
//https://fonts.google.com/specimen/Roboto?selection.family=Roboto

import java.util.*;

UI ui;
Path path;

List<Target> waveOfTargets;
List<Target> targets;
Set<Tower> towers;
Set<Bullet> bullets;

Tower onMouseTower;//tower that is following the mouse, used when placing a tower after buying it
Tower highlightedTower;//which tower is currently selected, used to determine which tower should be upgraded 

int lives;
int money;
int wave;
int totalDamage;
int[] numberOfTargets;//haw many baloons to make of each type 
boolean gameOver;

int currentMap = 0;

void setup() {
  //fullScreen();
  size(960, 540);

  resetGame();
  changeMap();
}

void draw() {
  background(207, 191, 102);

  //adds new target to path
  if (frameCount % (60 - 2*wave) == 0 && !waveOfTargets.isEmpty()) {
    int targetIndex = (int)random(waveOfTargets.size());

    targets.add(waveOfTargets.get(targetIndex));
    waveOfTargets.remove(targetIndex);
  }

  //updates money
  int damagePerMoney = 5;
  while (totalDamage >= damagePerMoney) {
    money++;
    totalDamage -= damagePerMoney;
  }

  //updates objects ie draws, moves, etc... 
  path.drawPath();

  for (Bullet bullet : bullets)
    bullet.drawBullet();

  for (Target target : targets)
    target.updateTarget();

  for (Tower tower : towers)
    tower.updateTower();

  ui.drawUI();

  //draws on mouse tower
  if (onMouseTower != null) {
    onMouseTower.pos = new PVector(mouseX, mouseY);
    onMouseTower.drawTower();
  }

  removeDead();

  //game over
  if(gameOver){
    delay(3000);
    resetGame();
  }
  checkGameOver();
}

void resetGame() {
  ui = new UI();

  waveOfTargets = new ArrayList<Target>();
  targets = new ArrayList<Target>();
  towers = new HashSet<Tower>();
  bullets = new HashSet<Bullet>();

  onMouseTower = null;
  highlightedTower = null;

  lives = 20;
  money = 250;
  wave = 0;
  totalDamage = 0;
  gameOver = false;

  numberOfTargets = new int[] {5, 2, 2};
}

void changeMap() {
  int numPaths = 2;
  path = new Path();

  currentMap++;

  if (currentMap % numPaths == 0) {
    path.addPoint(width*-0.05, height*-0.05);
    path.addPoint(width*0.2, height*0.2);
    path.addPoint(width*0.3, height*0.4);
    path.addPoint(width*0.2, height*0.6);
    path.addPoint(width*0.45, height*0.9);
    path.addPoint(width*0.7, height*0.6);
    path.addPoint(width*0.6, height*0.2);
    path.addPoint(width*0.5, height*-0.05);
  } else if (currentMap % numPaths == 1) {
    path.addPoint(width*0.5, height*1.05);
    path.addPoint(width*0.25, height*0.6);
    path.addPoint(width*0.15, height*0.4);
    path.addPoint(width*0.05, height*0.15);
    path.addPoint(width*0.7, height*0.15);
    path.addPoint(width*0.7, height*0.7);
    path.addPoint(width*-0.05, height*0.7);
  }

  resetGame();
}

void removeDead() {
  //removes targets that have reached end of path
  Set<Target> targetsToRemove = new HashSet<Target>();

  for (Target target : targets)
    if (target.reachedEnd || target.health < 0)
      targetsToRemove.add(target);

  targets.removeAll(targetsToRemove);

  //removes bullets that have gone off screen 
  Set<Bullet> bulletsToRemove = new HashSet<Bullet>();

  for (Bullet bullet : bullets)
    if (bullet.dead())
      bulletsToRemove.add(bullet);

  bullets.removeAll(bulletsToRemove);
}

/**
 * generates a wave of targets for the player to deal with 
 */
void waveOfTargets() {
  //cannot start a new wave while the other is still going
  if (!waveOfTargets.isEmpty() || !targets.isEmpty()) return;

  for (int i = 0; i < numberOfTargets.length; i++) {
    for (int j = 0; j < numberOfTargets[i]; j++) {
      //slow, weak
      if (i == 0 ) {
        int minHealth = 15;
        int maxHealth = minHealth*3 + wave*2;
        waveOfTargets.add(new Target(path, (int)random(minHealth, maxHealth), 0.8 - (wave/20)));
      }
      //medium, medium
      if (i == 1) {
        int minHealth = 40;
        int maxHealth = 60 + wave*2;
        waveOfTargets.add(new Target(path, (int)random(minHealth, maxHealth), 0.6));
      }
      //fast, string
      if (i == 2) {
        int minHealth = 80;
        int maxHealth = 100 + wave*2;
        waveOfTargets.add(new Target(path, (int)random(minHealth, maxHealth), 0.5));
      }
    }
  }

  wave++;

  //increase the number of targets
  numberOfTargets[0] *= 1.2 + wave*0.3;
  numberOfTargets[1] *= 1.2 + wave*0.3;
  numberOfTargets[2] *= 1.2 + wave*0.3;
}

void checkGameOver() {
  //game not over 
  if (lives > 0) return;

  fill(255, 0, 0);
  textSize(width*0.1);
  text("Game Over!", width/2, height/2);
  
  gameOver = true;
}

/**
 * used after purchasing a tower so the tower follows the mouse so the user can place the tower on the map 
 */
void buyTowerAndPlace() {
  //IF tower can be added to mouse
  if (onMouseTower == null) {
    Tower newTower = ui.getTowerAtPos(mouseX, mouseY);

    //checks for suffcient funds 
    if (newTower == null || money - newTower.price < 0) return;

    onMouseTower = newTower;
  }
  //IF tower can be placed down onto map 
  else if (onMouseTower != null) {
    towers.add(onMouseTower);
    money -= onMouseTower.price;
    onMouseTower = null;
  }
}

/**
 * used to select a tower so that it can be upgraded 
 */
void highlightTower() {
  //unhighlight currently highlighted tower
  if (highlightedTower != null)
    highlightedTower.towerHighlight = false;
  highlightedTower = null;

  //finds new tower to highlight 
  for (Tower tower : towers) {
    if (dist(mouseX, mouseY, tower.pos.x, tower.pos.y) <= tower.size) {
      tower.towerHighlight = true;
      highlightedTower = tower;
      return;
    }
  }
}

void upgradeSelectedTowerSpeed() {
  if (highlightedTower == null) return;

  highlightedTower.upgradeSpeed();
}

void upgradeSelectedTowerDamage() {
  if (highlightedTower == null) return;

  highlightedTower.upgradeDamage();
}

void mousePressed() {
  buyTowerAndPlace();
  ui.clickedButtons(mouseX, mouseY);
  highlightTower();
}

void keyPressed() {
  //new wave of targets 
  if (key == ' ') waveOfTargets();
  if (key == 's' || key == 'S') upgradeSelectedTowerSpeed();
  if (key == 'd' || key == 'D') upgradeSelectedTowerDamage();
}