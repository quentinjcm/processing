class Cube{
  /*
    a class for storing and drawing cubes at a given position, size and colour
  */
  float px, py, pz;
  float size;
  float cr, cg, cb;
  
  Cube(float px, float py, float pz, float size, float cr, float cg, float cb){
    this.px = px;
    this.py = py;
    this.pz = pz;
    this.size = size;
    this.cr = cr;
    this.cg = cg;
    this.cb = cb;
  }
  
  void drawCube(float cube_scale){
    float v00 = px - size * cube_scale;
    float v01 = py - size * cube_scale;
    float v02 = pz - size * cube_scale;
    
    float v10 = px + size * cube_scale;
    float v11 = py - size * cube_scale;
    float v12 = pz - size * cube_scale;
    
    float v20 = px - size * cube_scale;
    float v21 = py + size * cube_scale;
    float v22 = pz - size * cube_scale;
    
    float v30 = px + size * cube_scale;
    float v31 = py + size * cube_scale;
    float v32 = pz - size * cube_scale;
    
    float v40 = px - size * cube_scale;
    float v41 = py - size * cube_scale;
    float v42 = pz + size * cube_scale;
    
    float v50 = px + size * cube_scale;
    float v51 = py - size * cube_scale;
    float v52 = pz + size * cube_scale;
    
    float v60 = px - size * cube_scale;
    float v61 = py + size * cube_scale;
    float v62 = pz + size * cube_scale;
    
    float v70 = px + size * cube_scale;
    float v71 = py + size * cube_scale;
    float v72 = pz + size * cube_scale;

    beginShape(QUADS);
    fill(cr, cg, cb);
    vertex(v00, v01, v02);
    vertex(v10, v11, v12);
    vertex(v30, v31, v32);
    vertex(v20, v21, v22);
    
    vertex(v10, v11, v12);
    vertex(v50, v51, v52);
    vertex(v70, v71, v72);
    vertex(v30, v31, v32);
    
    vertex(v50, v51, v52);
    vertex(v70, v71, v72);
    vertex(v60, v61, v62);
    vertex(v40, v41, v42);
    
    vertex(v40, v41, v42);
    vertex(v60, v61, v62);
    vertex(v20, v21, v22);
    vertex(v00, v01, v02);
    
    vertex(v00, v01, v02);
    vertex(v10, v11, v12);
    vertex(v50, v51, v52);
    vertex(v40, v41, v42);
    
    vertex(v20, v21, v22);
    vertex(v30, v31, v32);
    vertex(v70, v71, v72);
    vertex(v60, v61, v62);
    endShape();
  }
  
}
