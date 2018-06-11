class Splat{
  ArrayList<PShape> shapes;            //all of the pshapes that make up the paint splat
  int base_subdivs, draw_subdivs;    //subdivision variables
  int num_splats;
  float x, y;                          //splat offset
  float radius;
  ArrayList<Vert> base_verts;       //base shape vertices
  
  Splat(){
    //some general variables
    x = width/2;
    y = height/2;
    base_subdivs = 7;
    draw_subdivs = 5;
    num_splats = 100;
    radius = 300;
    shapes = new ArrayList<PShape>();
    
    //initial vertex positions and weights
    base_verts = new ArrayList<Vert>();
    for (float a = 0; a < TWO_PI; a+= TWO_PI/12){
      Vert v = new Vert();
      v.p = PVector.fromAngle(a);
      v.p.mult(radius);
      v.w = random(1.0);
      base_verts.add(v);
    }
    
    //subdivide for base shape
    for(int sd = 0; sd < base_subdivs; sd++){
      base_verts = subdivide(base_verts, sd);
    }
    
    //creating the shapes
    for(int i = 0; i < num_splats; i++){
      ArrayList<Vert> temp_verts = duplicateBaseVerts();
      for(int sd = base_subdivs; sd < base_subdivs + draw_subdivs; sd++){
          temp_verts = subdivide(temp_verts, sd);
      }
      vertsToShape(temp_verts);
    }
  }
  
  ArrayList<Vert> duplicateBaseVerts(){
    ArrayList<Vert> temp_verts = new ArrayList<Vert>();
    for(Vert v: base_verts){
      temp_verts.add(v.copy());  
    }
    return temp_verts;
  }
  
  void vertsToShape(ArrayList<Vert> verts){
    PShape s = createShape(); 
    s.beginShape();
    s.fill(230, 10, 10, 2);
    s.noStroke();
    for (Vert v : verts){
      s.vertex(v.p.x, v.p.y);  
    }
    s.endShape(CLOSE);
    shapes.add(s); 
  }
  
  void display(){
    pushMatrix();
    translate(x, y);
    for (PShape s: shapes){
      shape(s);
    }
    //println("base: ", base_subdivs, "draw: ", draw_subdivs);
    popMatrix();  
  }
  
  ArrayList subdivide(ArrayList<Vert> vertices, int division){
    ArrayList<Vert> new_verts = new ArrayList<Vert>();
    int len = vertices.size();
    for(int i = 0; i < len; i++){
        Vert v_current = vertices.get(i).copy();
        Vert v_next = vertices.get((i+1)%len);
        Vert v_new = v_current.average(v_next);
        
        v_current.p.add(randOffset(division, 1.3, 80*v_current.w));
        //PVector offset = new PVector(randomGaussian(), randomGaussian(), randomGaussian());

        new_verts.add(v_current);
        new_verts.add(v_new);
    }
    return new_verts;
  }
  
  PVector randOffset(float division, float exp, float scale){
    PVector v = new PVector(randomGaussian(), randomGaussian(), randomGaussian());
    v.mult(pow(1/(division+1), exp) * scale);
    return v;
  }
  
}
