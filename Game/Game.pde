import java.util.*;

Path path = new Path();
Set<Target> targets = new HashSet<Target>();

void setup() {
  //fullScreen();
  size(960, 540);

  path.addPoint(0, 0);
  path.addPoint(width*0.2, height*0.2);
  path.addPoint(width*0.3, height*0.4);
  path.addPoint(width*0.2, height*0.6);
  path.addPoint(width*0.45, height*0.9);
  path.addPoint(width*0.7, height*0.6);
}

void draw() {
  background(255);

  //adds new target to path
  if (frameCount % 60 == 0)
    targets.add(new Target(path));

  //draws everything 
  path.drawPath();
  for (Target target : targets)
    target.drawTarget();

  //removes targets that have reached end of path
  Set<Target> targetsToRemove = new HashSet<Target>();

  for (Target target : targets)
    if (target.reachedEnd)
      targetsToRemove.add(target);

  targets.removeAll(targetsToRemove);
}