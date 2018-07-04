class Node{
  int leaf;
  int limit;          //number of colours added before the node subdivides itself, ingerited from creating node
  Node parent;        //reference to the parent node
  Node[] children;    //references to the child nodes
  PVector centre;     //the colour centre of the node
  float size;         //width of the node
  PVector sum_colour; //sum of all the colours in this node
  int sum_count;      //the number of colours contained in this node
  
  Node(int l, Node p, PVector c, float s){
    leaf = 1;
    limit = l;
    parent = p;
    centre = c;
    size = s;
    children = new Node[8];
    sum_colour = new PVector(0, 0, 0);
    sum_count = 0;
  }

  void addColour(int c){
    //extract colour data
    float cr = (c>>RED)&0xFF;
    float cg = (c>>GREEN)&0xFF;
    float cb = (c>>BLUE)&0xFF;
    
    //update sums
    sum_colour.add(cr, cg, cb);
    sum_count += 1;
    
    // if node is full, add the colour to the relevant child
    if(sum_count > limit){
      leaf = 0;
      int data[] = findChildData(cr, cg, cb);
      if(children[data[0]] == null){
        PVector new_centre = new PVector(centre.x + size/4 * data[1],
                                         centre.y + size/4 * data[2],
                                         centre.z + size/4 * data[3]);
        children[data[0]] = new Node(limit, this, new_centre, size/2);
      }
      children[data[0]].addColour(c);
    }
  }
  
  int[] findChildData(float cr, float cg, float cb){
    //    3------7
    //   /|     /|
    //  2-|----6 |    g
    //  | 1----|-5    | b
    //  |/     |/     |/
    //  0------4      o-----r
    int index[] = {0, -1, -1, -1};
    if(cr > centre.x){
      index[0] += 4;
      index[1] = 1;
    }
    if(cg > centre.y){
      index[0] += 2;
      index[2] = 1;
    }
    if(cb > centre.z){
      index[0] += 1;
      index[3] = 1;
    }
    return index;
  }
}
