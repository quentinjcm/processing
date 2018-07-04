VPCam c;
PImage img_building;
ArrayList<Cube> cubes;

int RED   = 16;
int GREEN = 8;
int BLUE  = 0;

void setup(){
  size(1024, 1024, P3D);
  c = new VPCam(0, 0, 100, 5, 0.017);
  img_building = loadImage("building.jpg");
  Octree tree = new Octree(img_building.pixels, 25);
  cubes = new ArrayList<Cube>();
  treeToCubes(cubes, tree.root);
}

void draw(){
  background(125);
  c.calc();
  for(Cube c: cubes){
    c.drawCube();
  }
}

void mouseWheel(MouseEvent event){
  c.mouseWheel(event);
}

void mouseDragged(MouseEvent event){
  c.mouseDragged(event);
}

void mouseMoved(MouseEvent event){
  c.mouseMoved(event);  
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
