class Vert{
  PVector p;
  float w;
  
  Vert average(Vert b){
    Vert v = new Vert();
    v.p = PVector.lerp(p, b.p, 0.5);
    v.w = (w + b.w)/2;
    return v;
  }
  
  Vert copy(){
    Vert v = new Vert();
    v.p = p;
    v.w = w;
    return v;
  }
}
