PImage img;
ArrayList<Cube> cubes;
Viewport viewer;

String name = "skull";

int RED   = 16;
int GREEN = 8;
int BLUE  = 0;



void setup(){
  size(1024, 1024, P3D);
  img = loadImage(name + ".jpg");
  Octree tree = new Octree(img.pixels, 25);
  cubes = new ArrayList<Cube>();
  treeToCubes(cubes, tree.root);
  viewer = new Viewport(cubes);
  img.resize(200, 0);
  
}

void draw(){
  background(125);
  viewer.viewScene();
  
  pushMatrix();
  image(img, 0, 0);
  popMatrix();
}

void mouseWheel(MouseEvent event){
  viewer.mouseWheel(event);
}

void mouseDragged(MouseEvent event){
  viewer.mouseDragged(event);
}

void mouseMoved(MouseEvent event){
  viewer.mouseMoved(event);  
}

void keyPressed(KeyEvent event){
  viewer.keyPressed(event);
}


void treeToCubes(ArrayList<Cube> cubes, Node current_node){
  if(current_node.leaf == 1){
    PVector p = current_node.centre;
    p.sub(127, 127, 127);
    PVector c = current_node.sum_colour.copy();
    c.div(current_node.sum_count);
    Cube new_cube = new Cube(p.x, p.y, p.z, current_node.size/2, c.x, c.y, c.z);
    cubes.add(new_cube);
  }
  else{
    for(int i = 0; i < 8; i++){
      if( current_node.children[i] != null){
        treeToCubes(cubes, current_node.children[i]);
      }
    }
  }
}
