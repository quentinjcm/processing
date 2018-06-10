class Splat{
  PShape s;
  float subdivs;
  float x, y;
  ArrayList<PVector> verts;
  
  Splat(){
    x = width/2;
    y = height/2;
    subdivs = 0;
    verts = new ArrayList<PVector>();
    for (float a = 0; a < TWO_PI; a += TWO_PI/8){
      PVector v = PVector.fromAngle(a);
      v.mult(100);
      verts.add(v);
    }
    vertsToShape();
  }
  
  void display(){
    
    pushMatrix();
    translate(x, y);
    shape(s);
    popMatrix();
  }
  
  void vertsToShape(){
    s = createShape();
    s.beginShape();
    s.fill(230, 10, 10);
    s.strokeWeight(0);
    for (PVector v : verts){
      s.vertex(v.x, v.y);  
    }
    s.endShape(CLOSE);
  }
  
  void subdivide(float iterations){
    for (int sd = 0; sd < iterations; sd++){
      ArrayList<PVector> new_verts = new ArrayList<PVector>();
      int len = verts.size();
      for (int i = 0; i < len; i++){
        PVector v_current = verts.get(i);
        PVector v_next = verts.get((i+1)%len);
        PVector v_new = PVector.lerp(v_current, v_next, 0.5);
        v_new.normalize();
        v_new.mult(100);
        new_verts.add(v_current);
        new_verts.add(v_new);
      }
      verts = new_verts;
      new_verts = null;
    }
    vertsToShape();
  }
  
  
}
