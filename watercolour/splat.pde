class Splat{
  PShape s;
  float subdivs;
  float x, y;
  ArrayList<PVector> base_verts;
  ArrayList<PVector> draw_verts;
  
  Splat(){
    x = width/2;
    y = height/2;
    subdivs = 1;
    base_verts = new ArrayList<PVector>();
    for (float a = 0; a < TWO_PI; a += TWO_PI/8){
      PVector v = PVector.fromAngle(a);
      v.mult(100);
      base_verts.add(v);
    }
    base_subdivide(7);
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
    s.fill(230, 10, 10, 5);
    s.strokeWeight(0);
    for (PVector v : draw_verts){
      s.vertex(v.x, v.y);  
    }
    s.endShape(CLOSE);
  }
  
  void base_subdivide(float iterations){
    for (int sd = 0; sd < iterations; sd++){
      ArrayList<PVector> new_verts = new ArrayList<PVector>();
      int len = base_verts.size();
      for (int i = 0; i < len; i++){
        PVector v_current_offset = randGaussOffset();
        PVector v_next_offset = randGaussOffset();
        PVector v_current = base_verts.get(i);
        PVector v_next = base_verts.get((i+1)%len);
        v_current.add(v_current_offset);
        v_next.add(v_next_offset);
        
        PVector v_new = PVector.lerp(v_current, v_next, 0.5);

        
        new_verts.add(v_current);
        new_verts.add(v_new);
      }
      base_verts = new_verts;
      new_verts = null;
      subdivs += 1;
    }
  }
  
  PVector randGaussOffset(){
    PVector v = new PVector(randomGaussian(), randomGaussian(), randomGaussian());
    v.mult(pow(1/subdivs, 2) * 30);
    return v;
  }
  
  void draw_subdivide(float iterations){
    draw_verts = base_verts;
    for (int sd = 0; sd < iterations; sd++){
      ArrayList<PVector> new_verts = new ArrayList<PVector>();
      int len = draw_verts.size();
      for (int i = 0; i < len; i++){
        PVector v_current_offset = randGaussOffset();
        PVector v_next_offset = randGaussOffset();
        PVector v_current = draw_verts.get(i);
        PVector v_next = draw_verts.get((i+1)%len);
        v_current.add(v_current_offset);
        v_next.add(v_next_offset);
        
        PVector v_new = PVector.lerp(v_current, v_next, 0.5);

        
        new_verts.add(v_current);
        new_verts.add(v_new);
      }
      draw_verts = new_verts;
      new_verts = null;
      subdivs += 1;
    }
    vertsToShape();
  }
  
  
}
