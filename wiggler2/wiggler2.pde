Wiggler w;

void setup(){
  size(640, 360, P2D);
  w = new Wiggler();
}

void draw(){
  background(255);
  w.display();
  w.wiggle();
}
