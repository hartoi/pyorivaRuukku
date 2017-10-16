float ylinPiste = 150;
ViisiKulmioPyramidi kuvio = new ViisiKulmioPyramidi(2);
ViisiKulmioPyramidi kuvio2 = new ViisiKulmioPyramidi(2);
Ruukku ruukkuKuvio = new Ruukku();

int i = 0;
void setup() {
    size(200, 500, P3D);
    background(0);
    stroke(255);
    noFill();
    frameRate(10);
}

void draw(){
    background(0);
    ortho(-width/2, width/2, -height/2, height/2);
  //  camera(mouseX, mouseY, (height/2) / tan(PI/6), mouseX, height/2, 200, 500, 100, 0);
//camera(0,0,0, 50, 50, -50, 0.0, 1.0, 0.0);
 //      camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
    rotateX((PI/2) );

    translate(width/2, height/2, -width);
    scale(0.5);
    rotateZ(radians(i));
//    pushMatrix();
//    rotateX(PI/2);
 //   rotateY(PI/2);
    ruukkuKuvio.drawIt();

//    popMatrix();
    i += 1;
    
}

class Ruukku {
  ViisiKulmioPyramidi katto,pohja;
  Ruukku(){
   katto = new ViisiKulmioPyramidi(2);
   pohja = new ViisiKulmioPyramidi(-2);
   pohja.phi = PI/4;
   pohja.rotatePentagon();

   float pohjaOffset = -1;
   for( int i = 0; i < pohja.kulmat.length; i++ ) {
      pohja.kulmat[i].z += pohjaOffset; 
   }
   pohja.ylaKulma.z += pohjaOffset;
  }
  void drawIt(){
   katto.drawItNew();
    pohja.drawItNew();
    
    beginShape();
//    fill(0);
    for( int i = 0; i < katto.kulmat.length + 1; i++ ) {
       vertex(katto.kerroin * katto.kulmat[i % katto.kulmat.length].x,
       katto.kerroin * katto.kulmat[i % katto.kulmat.length].y,katto.kerroin * katto.kulmat[i % katto.kulmat.length].z);
       vertex(pohja.kerroin * pohja.kulmat[i % katto.kulmat.length].x,pohja.kerroin * pohja.kulmat[i % katto.kulmat.length].y,
       pohja.kerroin * pohja.kulmat[i % katto.kulmat.length].z);       
    }
    endShape();
  }
}

int zZoom = 0;
void mousePressed(){
  println("Zoomlevel:"+zZoom);
  zZoom -= 25;
}

class Point {
 float x,y,z;
  Point(float x_, float y_){
   x = x_;
   y = y_;
   z = 0;
 }
 void setZ(float z_){
  z = z_; 
 }
} // end of Point class


class ViisiKulmioPyramidi extends Pentagoni {
Point ylaKulma;
ViisiKulmioPyramidi(float z_){
  super(0);
  ylaKulma = new Point(0,0);
  ylaKulma.z = z_;
  println(ylaKulma);
}
  void drawItNew(){
    drawIt();
    /*
    beginShape();
    for(int i = 0; i < kulmat.length; i++){
       vertex(kerroin * kulmat[i].x,kerroin * kulmat[i].y,0); 
    }
      vertex(kerroin * kulmat[0].x,kerroin * kulmat[0].y,0); 
    endShape();   
    */
    beginShape();
//      fill(0);        
      for(int i = 0; i < kulmat.length; i++){
         vertex(kerroin * kulmat[i].x,kerroin * kulmat[i].y,kerroin * kulmat[i].z); 
         vertex(kerroin * ylaKulma.x,kerroin * ylaKulma.y, kerroin * ylaKulma.z);          
      }

    endShape();
  }

}

class Pentagoni {
  Point kulmat[] = {new Point(0,0),new Point(0,0),new Point(0,0),new Point(0,0),new Point(0,0)};
  float phi,kerroin;
  float c1,c2,s1,s2;
  float z;
  Pentagoni(float phi_) {  // phi corresponds to the angle it is rotated
    phi = phi_;
    kerroin = 150.0;
    c1 = 0.25 * (sqrt(5) - 1 );
    c2 = 0.25 * (sqrt(5) + 1 );
    s1 = 0.25 * sqrt(10 + 2 * sqrt(5) );
    s2 = 0.25 * sqrt(10 - 2 * sqrt(5) );

    kulmat[0] =  new Point(1,0);
    kulmat[1] =  new Point(c1,s1);
    kulmat[2] =  new Point(-c2,s2);
    kulmat[3] = new Point(-c2,-s2);
    kulmat[4] = new Point(c1,-s1); 
    
    rotatePentagon();
  }
  
  Point rotatePoint(Point point, float phi_){
    float xP = cos(phi_) * point.x - sin(phi_) * point.y;
    float yP = sin(phi_) * point.x + cos(phi_) * point.y; 
   // Point returnValue = new Point(xP,yP);
    return new Point(xP,yP);//returnValue;
  }
  
  void rotatePentagon(){
    for(int i = 0; i < kulmat.length; i++){
       kulmat[i] = rotatePoint(kulmat[i],phi); 
    }
  }

  void drawIt(){
    beginShape();
//      fill(0);
      for(int i = 0; i < kulmat.length; i++){
         vertex(kerroin * kulmat[i].x,kerroin * kulmat[i].y,kerroin * kulmat[i].z); 
      }
      vertex(kerroin * kulmat[0].x,kerroin * kulmat[0].y,kerroin * kulmat[0].z); 
    endShape();    
  } // end of func drawIt
} // end of class Pentagoni