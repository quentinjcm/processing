class Octree{
  Node root;
  
  Octree(int img_pixels[], int limit){
    root = new Node(limit, null, new PVector(127.5, 127.5, 127.5), 255); 
    for(int p: img_pixels){
      root.addColour(p);  
    }
  }
  
  PVector[] quantize(int num_cols){
    PVector[] colours = new PVector[num_cols]; 
    return colours;
  }
}
