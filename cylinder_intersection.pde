/*
Perpendicular Offset Cylinders' Intersection Template Generator.
Define the variables. Run the Processing Script.
Resize the resulting image in photoshop.
 
Created By: Garrett Bryan
www.outlyingoutlier.com
 
####################################################
User Defined Variables
####################################################
*/
float Cylinder1Diameter = 8;
float Cylinder2Diameter = 2;
float IntersectionDistance = 3;    //IntersectionDistance must be <= (Cylinder1Diameter-Cylinder2Diameter)/2
boolean saveframe = false;         //set true to save a tiff file
/*
####################################################
####################################################
*/
 
int z = 1000;  // Width and Height of resulting window.
Template cutout1;
 
void setup() {
  if(saveframe && IntersectionDistance <= (Cylinder1Diameter-Cylinder2Diameter)/2) {
    size(z,z);
    noFill();
    strokeWeight(2);
    stroke(0);
    background(255);
    cutout1 = new Template(Cylinder1Diameter,Cylinder2Diameter,IntersectionDistance);
    cutout1.display();
    saveFrame(Cylinder1Diameter + "_" + Cylinder2Diameter +"_"+ IntersectionDistance +".tif");
  }
  else if(IntersectionDistance <= (Cylinder1Diameter-Cylinder2Diameter)/2) {
    size(z,z);
    noFill();
    strokeWeight(2);
    stroke(0);
    background(255);
    cutout1 = new Template(Cylinder1Diameter,Cylinder2Diameter,IntersectionDistance);
    cutout1.display();
  }
  else {
    println("IntersectionDistance must be <= (Cylinder1Diameter-Cylinder2Diameter)/2");
  }
}
 
void draw() {
}
 
class Template {
  float y,x,arclength,arclengthmin,arclengthmax,arclengthsmall,x2;
  float a,b,c,r,h,iteration,maxX,maxY,minX,minY,xmin,xmax,scalingfactor,xmid;
 
  Template(float Dcylinder1,float Dcylinder2,float IntersectionDistance) {
    a = IntersectionDistance-(Dcylinder2/2);      //min
    b = IntersectionDistance+(Dcylinder2/2);      //max
    c = Dcylinder1/2;                             //large pipe radius
    r = (b-a)/2;
    h = IntersectionDistance;
    iteration = 200;
  }
 
  void display() {
    arclengthmin = c*(asin(a/c));
    arclengthmax = c*(asin(b/c));
    xmin =  (a+0*((b-a)/2001));
    xmax =  (a+2001*((b-a)/2001));
 
    scalingfactor = ((width-20)/(arclengthmax-arclengthmin));
    println(arclengthmin + "," + arclengthmax +","+scalingfactor);
    translate(-arclengthmin*scalingfactor+10,height/2);
    minX = c*(asin((a+0*((b-a)/2001))/c))*scalingfactor;
    maxX = c*(asin((a+2001*((b-a)/2001))/c))*scalingfactor;
    for(int i = 0; i <= 2001; i ++) {
      x = (i*((b-a)/2001));
      x2 = x-h;
      arclength = c*(asin((a+i*((b-a)/2001))/c));
      y = sqrt(pow(r,2)-pow(a+i*((b-a)/2001)-((a+b)/2),2));
      stroke(0);
      point(arclength*scalingfactor,y*scalingfactor);
      point(arclength*scalingfactor,-y*scalingfactor);
      if (y > sqrt(pow(r,2)-pow(a+(i-2)*((b-a)/2001)-((a+b)/2),2)) && y > sqrt(pow(r,2)-pow(a+(i+2)*((b-a)/2001)-((a+b)/2),2))) {
        maxY = y*scalingfactor;
        minY = -maxY;
        xmid = arclength*scalingfactor;
        //println(maxY+&quot;,&quot;+xmid);
      }
      stroke(0,255,0,25);
      translate(-(-arclengthmin*scalingfactor),0);
      point(x*scalingfactor,y*scalingfactor);
      point(x*scalingfactor,-y*scalingfactor);
      translate((-arclengthmin*scalingfactor),0);
    }
    stroke(0);
    line(xmid,minY-50,xmid,maxY+50);
    noFill();
    rectMode(CORNERS);
    rect(minX,minY,maxX,maxY);
    line(minX-50,0,maxX+50,0);
    translate(-(-arclengthmin*scalingfactor+10),-height/2);
  }
}
