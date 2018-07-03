class VP_Cam{
  PVector pos;
  PVector origin;
  PVector up;
  
  int old_x, old_y;
  
  float scroll_speed;
  float rot_speed;

  
  VP_Cam(int px, int py, int pz, int ox, int oy, int oz, int ux, int uy, int uz, float ss, float rs){
    pos = new PVector(px, py, pz);
    origin = new PVector(ox, oy, oz);
    up = new PVector(ux, uy, uz);
    scroll_speed = ss;
    rot_speed = rs;
  }
  
  void calc(){
    camera(pos.x,    pos.y,    pos.z,
           origin.x, origin.y, origin.z,
           up.x,     up.y,     up.z);  
  }
  
  void mouseWheel(MouseEvent event){
    float e = event.getCount() * scroll_speed;
    PVector dir = PVector.sub(origin, pos);
    dir.normalize();
    dir.mult(e);
    pos.add(dir);
  }
  
  void mouseClicked(MouseEvent event){
    old_x = event.getX();
    old_y = event.getY();
  }
  
  void mouseDragged(MouseEvent event){
    int new_x = event.getX();
    int new_y = event.getY();
  
    if(new_x != old_x){
      float ang_x = float(old_x - new_x) * rot_speed;
      rotateY(ang_x);
    }
    
    old_x = new_x;
    old_y = new_y;
  }
  
  void rotateX(float angle){
    float sa = sin(angle);
    float ca = cos(angle);
    pos.y = pos.y * ca - pos.z * sa;
    pos.z = pos.y * sa + pos.z * ca;
  }
  
  void rotateY(float angle){
    float sa = sin(angle);
    float ca = cos(angle);
    pos.x = ((pos.x * ca) + (pos.z * sa));
    pos.z = (-(pos.x * sa) + (pos.z * ca));
    //println(pos);
    //println(pos.mag());
  }
}
