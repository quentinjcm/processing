Splat s;

void setup(){
  size(512, 512);
  s = new Splat();
}


void draw(){
  background(255);
  s.display();
}

void keyPressed(){
  s.subdivide(7);
}
