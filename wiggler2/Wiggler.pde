class Wiggler{
  PShape s; // the shape object
  float x, y; // the centre of the circle
  float yoff = 0; //vertical offset for the perlin noise
  ArrayList<PVector> original;  //list of starting points for the circel verts
  
  Wiggler(){
    x = width/2;
    y = height/2;
    original = new ArrayList<PVector>(); //create new array for the verts
    for(float a = 0; a < TWO_PI; a+=0.2){
      PVector v = PVector.fromAngle(a);//quick way to build up a circle
      v.mult(100); // circles radius is 100 pixels
      original.add(v); //append the new vertex
    }
    s = createShape();//create a shape to put all of the verts into
    s.beginShape();
    s.fill(120);//fill colour
    s.stroke(0); //line colour
    s.strokeWeight(2); //line weight
    for (PVector v : original){
      s.vertex(v.x, v.y);  //add verts to the shape
    }
    s.endShape(CLOSE);//end the shape and close the line to make a full circle
  }
  
  void wiggle(){
    float xoff = 0;
    for (int i = 0; i < s.getVertexCount(); i++){
      PVector pos = original.get(i);
      float a = TWO_PI * noise(xoff, yoff);
      PVector r = PVector.fromAngle(a);
      r.mult(4);
      r.add(pos);
      s.setVertex(i, r.x, r.y);
      xoff += 0.5;
    }
    yoff += 0.02;
  }

  void display(){
    pushMatrix();
    translate(x, y);
    shape(s);
    popMatrix();
  }
}
