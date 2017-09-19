Path path = new Path();
Target target = new Target(path);

void setup() {
  //fullScreen();
  size(960, 540);

  path.addPoint(0, 0);
  path.addPoint(width*0.2, height*0.2);
  path.addPoint(width*0.3, height*0.4);
  path.addPoint(width*0.2, height*0.6);
  path.addPoint(width*0.85, height*0.9);
  path.addPoint(width*0.7, height*0.6);
}

void draw() {
  background(255);

  path.drawPath();
  target.drawTarget();
}