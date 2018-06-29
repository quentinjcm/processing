PImage img_snail;
PImage img_whale;
PImage img_manatee;
PImage img_q_snail;
PImage img_q_whale;
PImage img_q_manatee;
PImage img_current;
int    img_index;

int RED   = 16;
int GREEN = 8;
int BLUE  = 0;

void setup(){
  size(500, 500);
  background(255);
  img_snail = loadImage("snail.jpeg");
  img_snail.resize(width, height);
  img_whale = loadImage("whae.jpg");
  img_whale.resize(width, height);
  img_manatee = loadImage("manatee.jpg");
  img_manatee.resize(width, height);
  img_index = 0;
  img_current = img_snail;
  img_q_whale = quantizeOct(img_whale);
  img_q_snail = quantizeOct(img_snail);
  img_q_manatee = quantizeOct(img_manatee);
}

void draw(){
  image(img_current, 0, 0);  
}

void keyPressed(){
  img_index = (img_index + 1) % 6;
  switch(img_index){
    case 0: img_current = img_snail; break; 
    case 1: img_current = img_q_snail; break;
    case 2: img_current = img_whale; break;
    case 3: img_current = img_q_whale; break; 
    case 4: img_current = img_manatee; break;
    case 5: img_current = img_q_manatee; break;
  }
}

PImage quantizeOct(PImage img){
  Octree o = new Octree(img.pixels);
  return img;
}

PImage quantizeMC(PImage img){
  PImage tmp_img = img.copy();
  int[] tmp_pixels = new int[img.pixels.length];
  arrayCopy(img.pixels, tmp_pixels);
  int n = img.width * img.height;
  
  quickSortColours(tmp_pixels, GREEN, 0, n - 1);
  
  quickSortColours(tmp_pixels, RED, 0, n/2-1);
  quickSortColours(tmp_pixels, RED, n/2, n-1);
  
  quickSortColours(tmp_pixels, BLUE, 0, n/4-1);
  quickSortColours(tmp_pixels, BLUE, n/4, n/2-1);
  quickSortColours(tmp_pixels, BLUE, n/2, 3*n/4-1);
  quickSortColours(tmp_pixels, BLUE, 3*n/4, n-1);
  
  PVector[] averages = new PVector[8];
  for(int i = 0; i < 8; i++){
    averages[i] = new PVector(0, 0, 0);  
  }
  int storage_index = -1;
  for(int i = 0; i < tmp_pixels.length; i++){
    if(i%(tmp_pixels.length/8) == 0){
      storage_index++;  
    }
    averages[storage_index].add(colToVec(tmp_pixels[i]));
  }
  for(PVector c: averages){
    c.div(tmp_pixels.length/8);  
  }
  
  for(int i = 0; i < img.pixels.length; i++){
    int closest = 0;
    float dist = 1000;
    PVector c = colToVec(img.pixels[i]);
    for(int j = 0; j < 8; j++){
      float temp_dist = c.dist(averages[j]);
      if(temp_dist < dist){
        dist = temp_dist;
        closest = j;
      }
    }
    tmp_img.pixels[i] = vecToCol(averages[closest]);
  }
  return tmp_img;
}

PVector colToVec(int colour){
  return new PVector((colour>>RED)&0xFF, 
                          (colour>>GREEN)&0xFF, 
                          (colour>>BLUE)&0xFF);
}

int vecToCol(PVector vec){
  return color(vec.x, vec.y, vec.z);
}


void quickSortColours(int[] colours, int bit_shift, int lo, int hi){
  if (lo < hi){
    int pi = partition(colours, bit_shift, lo, hi); 
    quickSortColours(colours, bit_shift, lo, pi-1);
    quickSortColours(colours, bit_shift, pi+1, hi);
  }
}

int partition(int[] colours, int bit_shift, int lo, int hi){
  float pivot = (colours[hi] >> bit_shift) & 0xff;
  int i = lo-1;
  for(int j = lo; j < hi-1; j++){
    if(((colours[j] >> bit_shift) & 0xff) <= pivot){
      i++;
      swap(colours, i, j);
    }
  }
  swap(colours, i+1, hi); 
  return i+1;
}

void swap(int[] colours, int x, int y){
  int tmp = colours[x];
  colours[x] = colours[y];
  colours[y] = tmp;
}
