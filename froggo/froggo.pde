PImage img;
float  angle;
float  time;
PGraphics mask;

void setup(){
  size(160, 160);
  background(255);
  img = loadImage("froggo.png");
  img.resize(width, height);
}

void draw(){
  //time
  time += 0.5;
  
  //masking
  float radius = (cos(radians(time))+1)/2 * width;
  mask = createGraphics(width, height);
  mask.beginDraw();
  mask.background(0);
  mask.fill(255);
  mask.ellipse(width/2, height/2, radius, radius);
  mask.fill(0);
  mask.ellipse(width/2, height/2, radius-10, radius-10);
  mask.endDraw();
  img.mask(mask);
  
  //roataions
  angle += radians(0.5);
  translate(width/2, height/2);
  rotate(angle);
  
  //drawing
  image(img, -width/2, -height/2);
}

void mousePressed(){
  saveFrame("out_####.png");
}
