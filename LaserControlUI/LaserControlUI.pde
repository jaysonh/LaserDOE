import controlP5.*;
import processing.serial.*;

Serial serial;
ControlP5 ui;

Slider sliderR;
Slider sliderG;
Slider sliderB;

final int baudSpeed   =  230400;
final int waitToStart = 2000;

int lf = 10; // ASCII linefeed
 
boolean connected = false;

long lastSend = 0;

void setup()
{
    size(600,600);
    ui = new ControlP5(this);
    sliderR=ui.addSlider("r")
     .setPosition(20,20)
     .setSize(200,15)
     .setRange(0,255);
     sliderG=ui.addSlider("g")
     .setPosition(20,40)
     .setSize(200,15)
     .setRange(0,255);
     sliderB=ui.addSlider("b")
     .setPosition(20,60)
     .setSize(200,15)
     .setRange(0,255);
      
    String portName = "COM6";//Serial.list()[0];
    serial = new Serial(this, portName, baudSpeed);
    serial.bufferUntil(lf);
    serial.write(lf);
   
    textSize(18);
     
}

void draw()
{
   background(sliderR.getValue(), sliderG.getValue(), sliderB.getValue());
   
   if(millis()> waitToStart && !connected) connected = true;
   
   if(connected)
   {
       fill(0,255,0);
       text("connected to esp32", 20,95);
   }
     
}

void sendCol(int r, int g, int b)
{
    if(connected)
    {      
        if(millis() - lastSend > 50)
        {
            String sendStr = str(b) + "," + str(g) + "," + str(r) + "\n";
            serial.write( sendStr );
            println("SENT:" + str(b) + "," + str(g) + "," + str(r) );
            lastSend = millis();
        }
    }
}

// Process a line of text from the serial port.
void serialEvent(Serial p) {
  String input = (serial.readString());
  println("received: " + input);
}

void exit()
{   
    sendCol( 0, 0 ,0);
    
    // wait a little for message to send then exit
    delay(100);
    System.exit(0);
}

void keyPressed()
{      
  if (key == ESC) {
    sendCol( 0, 0, 0);
       
    delay(100);
    System.exit(0);
      
  }
}

void controlEvent(ControlEvent theEvent) 
{
 
 if(theEvent.isController()) 
 {    
   sendCol( (int)sliderR.getValue(), (int)sliderG.getValue() , (int)sliderB.getValue());  
 } 
}
 
