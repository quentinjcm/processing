class VPCam{
  PVector initial;
  PVector origin;
  PVector up;
  float ang_x, ang_y;
  float fov;
  
  int old_x, old_y;
  
  float scroll_speed;
  float rot_speed;

  
  VPCam(float ax, float ay, float d, float ss, float rs){
    initial = new PVector(0, 0, d);
    origin = new PVector(0, 0, 0);
    up = new PVector(0, 1, 0);
    ang_x = ax;
    ang_y = ay;
    scroll_speed = ss;
    rot_speed = rs;
  }
  
  void calc(){
    float mx[] = M3_rotateX(ang_x);
    float my[] = M3_rotateY(ang_y);
    float rot[] = M3_mult(my, mx);
    PVector pos = M3_mult(rot, initial);
    PVector ori = M3_mult(rot, origin);
    PVector u = M3_mult(rot, up);//by rotating the up I can go all the way around the cube :D
    perspective(45, 1, 0.01, 1000);
    camera(pos.x,    pos.y,    pos.z,
           0,        0,        0,
           u.x,      u.y,      u.z);  
  }
  
  void mouseWheel(MouseEvent event){
    float e = event.getCount() * scroll_speed;
    initial.z += e;
  }
  
  void mouseMoved(MouseEvent event){
    old_x = event.getX();
    old_y = event.getY();
  }
  
  void mouseDragged(MouseEvent event){
    int new_x = event.getX();
    int new_y = event.getY();
    int button = event.getButton();
    if(button == LEFT){
      //trying to fix axis flipping when rotating x too far, soooorrttooof working...
      float clamped_x = abs(ang_x%PI);
      float y_mult = 1;
      if(clamped_x > PI/2){
        y_mult = -1;
      }
      ang_y += float(old_x - new_x) * rot_speed * y_mult;
      ang_x += float(new_y - old_y) * rot_speed;
    }
    else if(button == CENTER){
      //this doesnt actually work and needs some tinkering.
      origin.x += float(old_x - new_x);
      origin.y += float(old_y - new_y);
    }
    old_x = new_x;
    old_y = new_y;
  }
  
}
