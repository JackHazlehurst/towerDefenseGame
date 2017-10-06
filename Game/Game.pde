//font used for the user interface //<>// //<>//
//https://fonts.google.com/specimen/Roboto?selection.family=Roboto

import java.util.*;

UI ui;
Path path;

List<Target> waveOfTargets = new ArrayList<Target>();

List<Target> targets = new ArrayList<Target>();
Set<Tower> towers = new HashSet<Tower>();
Set<Bullet> bullets = new HashSet<Bullet>();

Tower onMouseTower;

int lives = 100;
int money = 250;
int wave = 0;
int totalDamage = 0;

void setup() {
  //fullScreen();
  size(960, 540);

  ui = new UI();
  path = new Path();

  path.addPoint(0, 0);
  path.addPoint(width*0.2, height*0.2);
  path.addPoint(width*0.3, height*0.4);
  path.addPoint(width*0.2, height*0.6);
  path.addPoint(width*0.45, height*0.9);
  path.addPoint(width*0.7, height*0.6);
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
  int damagePerMoney = 10;
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

  int numberOfTargets = wave*5 + 12;
  float weakProb = 0.8 - ((wave*2.0)/100);

  println(wave, weakProb, numberOfTargets);

  for (int i = 0; i < numberOfTargets; i++) {
    float probability = (float)Math.random();

    //slow, weak
    if (probability < weakProb) {
      int minHealth = 15;
      int maxHealth = minHealth*3 + wave*2;
      waveOfTargets.add(new Target(path, (int)random(minHealth, maxHealth), 0.8));
    }
    //medium, medium
    if (probability < (1 - weakProb)*0.75) {
      int minHealth = 40;
      int maxHealth = 60 + wave*2;
      waveOfTargets.add(new Target(path, (int)random(minHealth, maxHealth), 0.6));
    }
    //fast, string
    if (probability < (1 - weakProb)*0.25) {
      int minHealth = 80;
      int maxHealth = 100 + wave*2;
      waveOfTargets.add(new Target(path, (int)random(minHealth, maxHealth), 0.5));
    }
  }

  wave++;
}

void mousePressed() {
  //IF tower can be added to mouse
  if (onMouseTower == null) {
    Tower newTower = ui.getTowerAtPos(mouseX, mouseY);
    
    //checks for cuffcient funds 
    if(newTower == null || money - newTower.price < 0) return;
    
    onMouseTower = newTower;
  }
  //IF tower can be placed down onto map 
  else if (onMouseTower != null) {
    towers.add(new Tower(mouseX, mouseY, width*0.15, color(0, 0, 255), color(0, 255, 0), targets, bullets));
    money -= onMouseTower.price;
    onMouseTower = null;
  }
}

void keyPressed() {
  if (key == ' ') waveOfTargets();
}