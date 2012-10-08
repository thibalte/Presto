import processing.serial.*;

String[] gcode;
String temp;
int index;
Serial port;
boolean stopped = false;

void setup(){
 size(200, 200);
 gcode = loadStrings("gcode.txt"); // change the path to the gcode.txt of the svg2gcode folder for ease of use
 index = 0;
 port = new Serial(this, Serial.list()[2], 9600);
 port.bufferUntil('\n');
 delay(500);
}

void draw(){
}

// PRESS On THE SKETCH WINDOW TO START PRINTING

void mousePressed(){
  nextStep();
}

void serialEvent(Serial port){
  temp = port.readString();
  println(temp);
  if (temp.trim().startsWith("ok")){
    nextStep(); 
  }
}

void nextStep(){
   if (index < gcode.length){
     port.write(gcode[index] + "\n");
     println("instruction "+index+" of "+gcode.length);
     println(gcode[index]);
     index++;
   }
   if (index == gcode.length){
     println("finished!");
   }
}
