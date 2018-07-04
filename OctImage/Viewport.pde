float SCROLL_SPEED  = 5;
float MOVE_SPEED    = 0.25;
float TUMBLE_SPEED  = 0.017;

class Viewport{
  int old_mouse_x;
  int old_mouse_y;
  int wireframe = 1;
  
  
  ArrayList<Camera> cameras;
  int current_camera;
  
  Viewport(){
    cameras = new ArrayList<Camera>();
    
    PerspCamera pc = new PerspCamera();
    cameras.add(pc);
    
    PVector f = new PVector(0, 0, 1);
    PVector u = new PVector(0, 1, 0);
    IsoCamera ic = new IsoCamera(f, u);
    cameras.add(ic);
    
    f.z = -1;
    ic = new IsoCamera(f, u);
    cameras.add(ic);
    
    f.z = 0;
    f.x = 1;
    ic = new IsoCamera(f, u);
    cameras.add(ic);
    
    f.x = -1;
    ic = new IsoCamera(f, u);
    cameras.add(ic);
    
    f.x = 0;
    f.y = 1;
    u.y = 0;
    u.x = 1;
    ic = new IsoCamera(f, u);
    cameras.add(ic);
    
    f.y = -1;
    ic = new IsoCamera(f, u);
    cameras.add(ic);
   
    current_camera = 0;
    
  }
  
  void view(){
    noStroke();
    if(wireframe == 1){
      stroke(0);
    }
    cameras.get(current_camera).view();  
  }
  
  void mouseWheel(MouseEvent event){
    float e = event.getCount();
    cameras.get(current_camera).mouseWheel(e);
  }
  
  void mouseMoved(MouseEvent event){
    old_mouse_x = event.getX();
    old_mouse_y = event.getY();
  }
  
  void mouseDragged(MouseEvent event){
    int new_mouse_x = event.getX();
    int new_mouse_y = event.getY();
    int button = event.getButton();
    float dx = float(old_mouse_x - new_mouse_x);
    float dy = float(new_mouse_y - old_mouse_y);
    cameras.get(current_camera).mouseDragged(dx, dy, button);
    old_mouse_y = new_mouse_y;
    old_mouse_x = new_mouse_x;
  }
  
  void keyPressed(KeyEvent event){
    switch(event.getKey()){
      case '1': current_camera = 0; break;
      case '2': current_camera = 1; break;
      case '3': current_camera = 2; break;
      case '4': current_camera = 3; break;
      case '5': current_camera = 4; break;
      case '6': current_camera = 5; break;
      case '7': current_camera = 6; break;
      case 'w': wireframe = wireframe == 0? 1 : 0; break;
      case 'h': cameras.get(current_camera).reset(); break;
      case 's': save(name + ".png");
    }
  }
}
