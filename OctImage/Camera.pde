//camera base class
class Camera{
  void view(){}
  void mouseWheel(float incriment){}
  void mouseDragged(float x_movement, float y_movement, int button){}
  void reset(){}
};

class PerspCamera extends Camera{
  PVector initial, up;
  float angle_x, angle_y;
  PVector screen_offset;
  float fov;
  
  PerspCamera(){
    this.angle_x = PI/4;
    this.angle_y = PI/4;
    this.fov = 45;
    initial = new PVector(0, 0, 400);
    up = new PVector(0, 1, 0);
    screen_offset = new PVector(0, 0, 0);
  }
  
  void view(){
    float mx[] = M3_rotateX(angle_x);
    float my[] = M3_rotateY(angle_y);
    float rot[] = M3_mult(my, mx);
    PVector pos = M3_mult(rot, initial);
    PVector u = M3_mult(rot, up);//by rotating the up I can go all the way around the cube :D
    PVector offset = M3_mult(rot, screen_offset);
    perspective(fov, 1, 0.01, 1000);
    camera(pos.x + offset.x,    pos.y + offset.y,    pos.z + offset.z,
           offset.x,        offset.y,        offset.z,
           u.x,      u.y,      u.z);  
  }
  
  void mouseWheel(float increment){
      initial.z += increment * SCROLL_SPEED;
  }
  
  void mouseDragged(float x_movement, float y_movement, int button){
    if(button == LEFT){
      angle_x += y_movement * TUMBLE_SPEED;
      angle_y += x_movement * TUMBLE_SPEED;  
    }
    else if(button == CENTER){
      screen_offset.x += x_movement * MOVE_SPEED;
      screen_offset.y -= y_movement * MOVE_SPEED;
    }
  }
  
  void reset(){
    angle_x = PI/4;
    angle_y = PI/4;
    initial.z = 300;
    screen_offset.x = 0;
    screen_offset.y = 0;
    screen_offset.z = 0;
  }
}

class IsoCamera extends Camera{
  PVector forward, up, right;
  PVector offset;
  float screen_width;
  
  IsoCamera(PVector forward, PVector up){
    this.forward = forward.copy();
    this.up = up.copy();
    this.right = forward.cross(up);
    this.offset = new PVector(0, 0, 0);
    offset.sub(PVector.mult(forward, 300));
    this.screen_width = 150;
  }
  
  void view(){
    PVector lookat = PVector.add(offset, forward);
    ortho(-screen_width, screen_width, -screen_width, screen_width, 0.001, 1000);
    camera(offset.x, offset.y, offset.z,
           lookat.x, lookat.y, lookat.z,
           up.x,     up.y,     up.z);
  }
  
  void mouseWheel(float increment){
    screen_width += increment * SCROLL_SPEED;  
  }
  
  void mouseDragged(float x_movement, float y_movement, int button){
    offset.add(PVector.mult(right, x_movement*MOVE_SPEED)) ;
    offset.sub(PVector.mult(up, y_movement*MOVE_SPEED));
  }
  
  void reset(){
    screen_width = 150;
    offset.x = 0;
    offset.y = 0;
    offset.z = 0;
  }
}
