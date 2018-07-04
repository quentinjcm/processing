/*
  a bunch of functions to help with matrix calculations, used by the Camera classes to 
  calculate rotations. 
  
  Originally I wanted to have a Mat3 class but because processing doesnt allow static 
  methods (because everything is an inner class of the sketch class:
  https://stackoverflow.com/questions/44250964/static-methods-unallowed-in-processing)
  so I just wrote a few functions to do matrix stuff on plain float arrays instead. 
  
  The arrays are indexed in the arrays as follows:
  |0 1 2|
  |3 4 5|
  |6 7 8|
  
  Very basic but works okay for what I'm doing and could be a good starting point for
  a more fleshed out set of matrix functions.
  
  Things it would be nice to add:
  -rotation around arbitrary axes
  -4x4 matricies so I can get some translations in here
  -rotations around arbitrary axes and points
  -some quaternion functions for those silky smooth rotations...
*/

float[] M3_ident(){
  /* 
    Creats a float array representing the 3x3 identity matrix (with 1s on the leading
    diagonal):
    |1 0 0|
    |0 1 0|
    |0 0 1|
  */
  float data[] = new float[9];
  data[0] = 1;
  data[4] = 1;
  data[8] = 1;
  return data;
}

float[] M3_init(float a, float b, float c, float d, float e, float f, float g, float h, float i){
  /*
    Initialize a matrix with the 9 inputted values. Probably not necessary but felt nice for the sake
    of completeness, maybt it will be useful if i want to come back and change the underlying format
    for some strange reason...
    |a b c|
    |d e f|
    |g h i|
  */
  float data[] = new float[9];
  data[0] = a;
  data[1] = b;
  data[2] = c;
  data[3] = d;
  data[4] = e;
  data[5] = f;
  data[6] = g;
  data[7] = h;
  data[8] = i;
  return data;
}

float[] M3_mult(float[] m1, float[] m2){
  /*
    Multiply 2 matricies (represented as the same float array format I have been using for all of the other 
    functions) together.
  */
    float result[] = new float[9];
    result[0] = m1[0] * m2[0] + m1[1] * m2[3] + m1[2] * m2[6];
    result[1] = m1[0] * m2[1] + m1[1] * m2[4] + m1[2] * m2[7];
    result[2] = m1[0] * m2[2] + m1[1] * m2[5] + m1[2] * m2[8];
    result[3] = m1[3] * m2[0] + m1[4] * m2[3] + m1[5] * m2[6];
    result[4] = m1[3] * m2[1] + m1[4] * m2[4] + m1[5] * m2[7];
    result[5] = m1[3] * m2[2] + m1[4] * m2[5] + m1[5] * m2[8];
    result[6] = m1[6] * m2[0] + m1[7] * m2[3] + m1[8] * m2[6];
    result[7] = m1[6] * m2[1] + m1[7] * m2[4] + m1[8] * m2[7];
    result[8] = m1[6] * m2[2] + m1[7] * m2[5] + m1[8] * m2[8];
    return result;
}

PVector M3_mult(float[] m, PVector v){
  /*
    multiplies a PVector by a matrix, returning the transformed vector
  */
  PVector result = new PVector();
  result.x = v.x * m[0] + v.y * m[1] + v.z * m[2];
  result.y = v.x * m[3] + v.y * m[4] + v.z * m[5];
  result.z = v.x * m[6] + v.y * m[7] + v.z * m[8];
  return result;
}

float[] M3_rotateX(float ang){
  /*
    Returns a matrix representing a rotation around the x axis
  */
  float result[] = new float[9];
  float s = sin(ang);
  float c = cos(ang);
  result[0] = 1;
  result[1] = 0;
  result[2] = 0;
  result[3] = 0;
  result[4] = c;
  result[5] = -s;
  result[6] = 0;
  result[7] = s;
  result[8] = c;
  return result;
}

float[] M3_rotateY(float ang){
  /*
    Returns a matrix representing a rotation around the y axis
  */
  float result[] = new float[9];
  float s = sin(ang);
  float c = cos(ang);
  result[0] = c;
  result[1] = 0;
  result[2] = s;
  result[3] = 0;
  result[4] = 1;
  result[5] = 0;
  result[6] = -s;
  result[7] = 0;
  result[8] = c;
  return result;
}

float[] M3_rotateZ(float ang){
  /*
    Returns a matrix representing a rotation around the z axis
  */
  float result[] = new float[9];
  float s = sin(ang);
  float c = cos(ang);
  result[0] = c;
  result[1] = -s;
  result[2] = 0;
  result[3] = s;
  result[4] = c;
  result[5] = 0;
  result[6] = 0;
  result[7] = 0;
  result[8] = 1;
  return result;
}
