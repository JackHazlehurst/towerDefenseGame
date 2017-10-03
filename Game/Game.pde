//font used for the user interface
//https://fonts.google.com/specimen/Roboto?selection.family=Roboto

import java.util.*;

UI ui;
Path path;

List<Target> targets = new ArrayList<Target>();
Set<Tower> towers = new HashSet<Tower>();
Set<Bullet> bullets = new HashSet<Bullet>();

int lives = 100;
int money = 0;

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
  if (frameCount % 60 == 0)
    targets.add(new Target(path)); //<>//

  //updates objects ie draws, moves, etc... 
  path.drawPath();
  
  for (Bullet bullet : bullets)
    bullet.drawBullet();
  
  for (Target target : targets)
    target.updateTarget();
  
  for (Tower tower : towers)
    tower.updateTower();
    
  ui.drawUI();
    
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

void mouseClicked() {
  towers.add(new Tower(mouseX, mouseY, width*0.15, targets, bullets));
}