class Octree{
  Node root;
  
  Octree(int img_pixels[]){
    root = new Node(50, null, new PVector(127.5, 127.5, 127.5), 255); 
    for(int p: img_pixels){
      root.addColour(p);  
    }
  }
  
  PVector[] quantize(int num_cols){
    PVector[] colours = new PVector[num_cols]; 
    return colours;
  }
  /*
  int[] visualise(int depth){
    //int px = new int[255 * 255];
  
  }*/
  
  
}
