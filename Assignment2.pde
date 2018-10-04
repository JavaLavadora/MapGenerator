import controlP5.*;
import java.util.Map;

ControlP5 con;

Button start;

DropdownList d1;

//float sliderMaxSteps;
Slider sliderMax;
Slider sliderRate;
Slider sliderScale;

Toggle toggConst;
Toggle toggTerr;
Toggle toggStr;
Toggle toggRan;

Textfield textSeed;


//PositionTuple posAux = new PositionTuple(400, 400);
SquarePath sq = new SquarePath(400, 400); 

//Aux variables
float auxSteps = 1;
float auxShape = 0;
boolean reset = false;
float shape = 0;


//UI variables
float sliderMaxSteps = 0;
float sliderStepRate = 0;
float sliderStepScale = 0;
float sliderSize = 0;

//Terrain genration variables
HashMap<PVector,Integer> hm; 
PVector paux = new PVector(400, 400);

void setup() {
    con= new ControlP5(this);
    
    //BUTTON
    start = con.addButton("startGame")
             .setValue(0)
             .setPosition(10, 5)
             .setSize(180, 50)
             .setColorBackground(#009900);
    start.getCaptionLabel().setSize(20).set("START");
    
    
    //DROP DOWN
    d1 = con.addDropdownList("shapeSelector")
          .setPosition(10, 70)
          .setSize(180, 90)
          .setBarHeight(30)
          .addItem("Squares", 0).setItemHeight(30)
          .addItem("Hexagons", 1).setItemHeight(30)
          ;
          
     //SLIDER
    con.addTextlabel("label1")  
        .setText("Maximum Steps")
        .setPosition(10,180);
    
    sliderMax = con.addSlider("sliderMaxSteps")
                  .setPosition(10, 190)
                  .setSize(180, 30)
                  .setRange(1, 5000)
                  .setCaptionLabel("");
    //SLIDER          
    con.addTextlabel("label2")  
    .setText("Step Rate")
    .setPosition(10,225);
    
    sliderRate = con.addSlider("sliderStepRate")
                  .setPosition(10, 235)
                  .setSize(180, 30)
                  .setRange(1, 1000)
                  .setCaptionLabel("");
    
    //SLIDER
    con.addTextlabel("label3")  
    .setText("Step Size")
    .setPosition(10,280);

    sliderRate = con.addSlider("sliderSize")
              .setPosition(10, 295)
              .setSize(100, 30)
              .setRange(10, 30)
              .setCaptionLabel("");
    
    
    //SLIDER          
    con.addTextlabel("label4")  
    .setText("Step Scale")
    .setPosition(10,335);
    
    sliderScale = con.addSlider("sliderStepScale")
                  .setPosition(10, 345)
                  .setSize(100, 30)
                  .setRange(1.0, 1.5)
                  .setCaptionLabel("");
                  
     //TOGGLE
     toggConst = con.addToggle("toggleConstraint")
                      .setPosition(10, 390)
                      .setSize(25, 25);
     toggConst.setCaptionLabel("Constraint Steps");
                 
     //TOGGLE
     toggTerr = con.addToggle("toggleTerrain")
                      .setPosition(10, 430)
                      .setSize(25, 25);
     toggTerr.setCaptionLabel("Simulate Terrain");            
            
     //TOGGLE
     toggStr = con.addToggle("toggleStroke")
                      .setPosition(10, 470)
                      .setSize(25, 25);
     toggStr.setCaptionLabel("Use Stroke");               
             
     //TOGGLE
     toggRan = con.addToggle("toggleRandom")
                      .setPosition(10, 510)
                      .setSize(25, 25);
     toggRan.setCaptionLabel("Use Random Seed");                    
                  
     //TEXTFIELD             
     textSeed = con.addTextfield("inputSeed")
                   .setPosition(90, 510)
                   .setSize(40, 25);
     textSeed.setInputFilter(ControlP5.INTEGER);
     textSeed.setCaptionLabel("");
                  
    size(800, 800);
    background(30,144,255);
    fill(153);
    rect(100, 400, 200, height);
    
    
}



void draw() {
  if(reset){
    rectMode(CENTER);
    
    //Restart Canvas
    println("RESETTING");
    background(30,144,255);
    fill(153);
    rect(100, 400, 200, height);
    
    //Reset objects
    sq.wx = 400;
    sq.wy = 400;
    auxSteps = 1;
    auxShape = shape;
     
    //Reset Hash Map and vector
    hm = new HashMap<PVector,Integer>();
    paux.x = 400;
    paux.y = 400;
    
    //Use seed
    if(toggRan.getBooleanValue()){    
      if(! textSeed.getText().equals("")){
        println(Long.parseLong(textSeed.getText()));
        randomSeed(Long.parseLong(textSeed.getText()));
      }
    }
    
    reset = false;
  }
  
  
  //Path generation
  
  //If square 
  if(auxShape == 0){   
    
     //Check stroke
     if(toggStr.getBooleanValue()){
       stroke(0);
     }
     else{
       noStroke();
     }
     
    //Draw first square
    if(auxSteps == 1){ 
        rect(400, 400, sliderSize * sliderStepScale, sliderSize * sliderStepScale);
        //Add to hashmap
        hm.put(paux, 1);
    }
    
    if(auxSteps < sliderMaxSteps){  
      for(int j = 0; j < sliderStepRate; j++){
        sq.update(); 
      }
      auxSteps++;
    }
  }
   

}



void startGame(){
  reset = true;
  //Max num of steps
  //Num of steps taken
  //Distance of step
  //Scale of step (to add borders)
  //Color selected
  //Stroke selected
  //Boundaries of viewable area
  
}



  //Max num of steps
  //Num of steps taken
  //Distance of step --> side of square / radius of hexagon
  //Scale of step (to add borders)
  //Color selected
  //Stroke selected
  //Boundaries of viewable area


///////////// SQUARE ///////////////
class SquarePath {
  //Boundaries yes or no
  float wx, wy, sizeStep;

  SquarePath (float cx, float cy) {  
    wx = cx; 
    wy = cy; 
  }
  
  //PositionTuple update() { 
  void update() {
    
    //Generating movement
    int ran = (int) random(0, 4);
    
    switch(ran){
      //Left
      case 0: wx = wx - (int)(sliderSize * sliderStepScale);
              if(toggConst.getBooleanValue() && (wx < 200)){
                //Out of screen
                wx = 200;
              }
              break;
        
      //Up
      case 1: wy = wy + (int)(sliderSize * sliderStepScale);
              if(toggConst.getBooleanValue() && (wy < 0)){
                //Out of screen
                wy = 0;
              }
              break;
      //Right
      case 2: wx = wx + (int)(sliderSize * sliderStepScale);
              if(toggConst.getBooleanValue() && (wx > 800)){
                //Out of screen
                wx = 200;
              }      
              break;
      //Down
      default: wy = wy - (int)(sliderSize * sliderStepScale);
              if(toggConst.getBooleanValue() && (wy > 800)){
                //Out of screen
                wy = 800;
              }      
               break;
    }        
    
     //Keep track of visits of the point
     paux.x = wx;
     paux.y = wy;
     int total;
     if(hm.get(paux) != null){
       //First time visiting the point
       total = hm.get(paux);
       total++;
       hm.put(paux, total);
     }
     else{
       total = 1;
       hm.put(paux, total);
     }
     
     
     //Render square
     if(toggTerr.getBooleanValue()){
       //Computing color of terrain
       if(total < 4){
         fill(160, 126, 84);
       }
       else if(total < 7){
         fill(143, 170, 64);
       }
       else if(total < 10){
         fill(134, 134, 134);
       }
       else{
         total = total * 20;
         if(total > 255){
           total = 255;
         }
         fill(total);
       }
       
     }
     else{
       //No terrain no gain
       fill(153);
     }
     rect(wx, wy, sliderSize * sliderStepScale, sliderSize * sliderStepScale);
  } 

}

class PositionTuple {
  float x, y;
  
  PositionTuple (float cx, float cy){
    x = cx;
    y = cy;
  }
  

}


void shapeSelector(){
  shape = d1.getValue();
  println(shape);
}


/*void sliderMaxSteps(){
  float index = sliderMax.getValue();
  text(index, 400, 400);
}*/

/*void sliderStepRate(){
  float index = sliderRate.getValue();
  text(index, 400, 400);
}*/


/*void sliderStepScale(){
  float index = sliderScale.getValue();
  text(index, 400, 400);
}*/

void toggleConstraint(boolean res){
   float index = toggConst.getValue();
  text(index, 400, 400);
}

void toggleTerrain(){
   float index = toggTerr.getValue();
  text(index, 400, 400);
}
/*
void toggleStroke(){
   float index = toggStr.getValue();
  text(index, 400, 400);
}
*/
void toggleRandom(){
   float index = toggRan.getValue();
  text(index, 400, 400);
}

void inputSeed(String txt){
   text(txt, 400, 400);
}
