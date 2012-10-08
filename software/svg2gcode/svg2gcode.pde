import geomerative.*;

PrintWriter gcode;
float zDwell = 10;

RShape grp;
RPoint[][] pointPaths;

float rescale = 0.3521; // scale factor

boolean ignoringStyles = true;

void setup(){
  size(700, 1000);
  
  gcode = createWriter("data/gcode.txt");

  RG.init(this);
  RG.ignoreStyles(ignoringStyles);
  
  grp = RG.loadShape("test.svg");
  
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  //RG.setPolygonizerAngle(PI/100);
  // RG.setPolygonizerStep(20);
  RG.setPolygonizerLength(20);
  
  pointPaths = grp.getPointsInPaths();
}

void draw(){
  
  background(0);
  stroke(255);
  noFill();
  
  for(int i = 0; i<pointPaths.length; i++){

    if (pointPaths[i] != null) {
      beginShape();
      gcode.println("g0x"+Math.round(pointPaths[i][0].x*rescale)+"y"+Math.round(pointPaths[i][0].y*rescale));
      gcode.println("m3"); // SPINDLE ON;
      gcode.println("g0z"+zDwell); // Using Z move to wait for servo to move
      zDwell+=5; // increment Z move for next time
      for(int j = 1; j<pointPaths[i].length-1; j++){
        vertex(pointPaths[i][j].x*rescale, pointPaths[i][j].y*rescale);
        ellipse(pointPaths[i][j].x*rescale, pointPaths[i][j].y*rescale, 5, 5);
        gcode.println("g0x"+Math.round(pointPaths[i][j].x*rescale)+"y"+Math.round(pointPaths[i][j].y*rescale));
      }
      endShape();
      gcode.println("M5"); //SPINDLE OFF;
    }
  }
  
  gcode.println("g0x0y0"); // go to origin
  gcode.flush();
  gcode.close();
  
  println("export successful!");
  
  noLoop();
}

void mousePressed(){
   exit(); 
}
