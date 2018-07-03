VP_Cam c;

void setup(){
  size(512, 512, P3D);
  noStroke();
  c = new VP_Cam(100, 100, 100, 0, 0, 0, 0, 1, 0, 5,0.017);
}

void draw(){
  lights();
  background(0);
  
  c.calc();
  
  box(45);
}

void mouseWheel(MouseEvent event){
  c.mouseWheel(event);
}

void mouseClicked(MouseEvent event){
  c.mouseClicked(event);  
}

void mouseDragged(MouseEvent event){
  c.mouseDragged(event);
}
