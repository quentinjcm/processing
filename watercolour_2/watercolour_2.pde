Splat s;

void setup(){
  size(1024, 1024);
  s = new Splat();
}

void draw(){
  background(240, 235, 225);
  s.display();
}

void keyPressed(){
  saveFrame();
}
