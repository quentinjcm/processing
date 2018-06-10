void setup(){
  size(800, 800);
  background(200, 50, 30);
}

void draw(){
  if(keyPressed){
    fill(255);
    ellipse(mouseX, mouseY, 80, 80);
  }
}
