PImage img;   // base image
PImage gimg;  // gradient image
PImage eimg;  // edited image
PImage cimg;  // current image to display

PGraphics g;

int draw_index;

int vecToCol(PVector v, float scale){
  return color(v.x  * scale, v.y * scale, v.z * scale);
}

PVector gradKernelA(int x, int y, PImage image){
  PVector pixel_grad = new PVector();
  for (int i = x-1; i < x+2; i++){
    for (int j = y-1; j < y+2; j++){
      PVector dir = new PVector(x-i, y-j, 0);
      dir.normalize();
      float col = red(image.pixels[i + image.width * j]);
      dir.mult(col);
      pixel_grad.add(dir);
    }
  }
  pixel_grad.normalize();
  pixel_grad.mult(0.5);
  pixel_grad.add(0.5, 0.5, 0.5);
  
  return pixel_grad;
}

PGraphics editImage(PImage image, PImage grad_image){
  PGraphics edit = createGraphics(image.width, image.height);
  edit.beginDraw();
  edit.background(0);
  edit.noStroke();
  PVector[] verts = new PVector[4];
  
  for (int i = 0; i < 2000000; i++){
    int px = int(random(image.width));
    int py = int(random(image.height));
    
    int p_col = image.pixels[px + image.width * py];
    int p_grad = grad_image.pixels[px + image.width * py];
    PVector up = new PVector(1, 0, 0);
    PVector grad = new PVector(red(p_grad)/255, green(p_grad)/255, blue(p_grad)/255);
    grad.mult(2);
    grad.sub(1, 1, 1);
    //println(grad);
    float ang = PVector.angleBetween(up, grad);
    ang += HALF_PI;
    
    PVector offset = new PVector(px, py, 0);
    
    float h = 10;
    float w = 1;
    
    verts[0] = new PVector(-w,  h, 0);
    verts[1] = new PVector( w,  h, 0);
    verts[2] = new PVector( w, -h, 0);
    verts[3] = new PVector(-w, -h, 0);
    
    for (PVector v: verts){
      v.rotate(ang+ HALF_PI);
      v.add(offset);
    }
    edit.fill(p_col, 20);
    edit.quad(verts[0].x, verts[0].y, 
              verts[1].x, verts[1].y, 
              verts[2].x, verts[2].y, 
              verts[3].x, verts[3].y);
  }
  edit.endDraw();
  return edit;
}

PImage imgGradient(PImage image){
  PImage grad_img = createImage(image.width, image.height, RGB);
  for(int x = 1; x < image.width-1; x++){
    for(int y = 1; y < image.height-1; y++){
        grad_img.pixels[x + image.width * y] = vecToCol(gradKernelA(x, y, image), 255);
    }
  }
  return grad_img;
}

void setup(){
  size(500, 500);
  img = loadImage("seal.jpg");
  eimg = img.copy();
  eimg.filter(GRAY);
  eimg.filter(BLUR, 10);
  gimg = imgGradient(eimg);
  gimg.filter(BLUR, 2);
  cimg = gimg;
  g = editImage(img, gimg);
}

void draw(){
  switch(draw_index){
    case 0: image(img, 0, 0); break;
    case 1: image(eimg, 0, 0); break;
    case 2: image(gimg, 0, 0); break;
    case 3: image(g, 0, 0); break;
  }
}

void keyPressed(){
  draw_index += 1;
  draw_index = draw_index%4;
}
